import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:sufenbao/service.dart';

/// 激励视频播放结果
class CsjRewardResult {
  const CsjRewardResult({required this.success, this.transactionId, this.message});

  final bool success;
  final String? transactionId;
  final String? message;
}

/// 穿山甲激励视频封装
///
/// 使用方式：
/// ```dart
/// final result = await CsjAdManager.instance.showRewardAd();
/// if (result.success) {
///   await BService.csjReward(transactionId: result.transactionId!);
/// }
/// ```
///
/// 说明：插件本身没有"奖励流水号"概念，这里用 [customData] 传入客户端生成的
/// 唯一 ID，SDK 在 onAdReward 时原样回传，服务端用它做幂等去重。
class CsjAdManager {
  CsjAdManager._();

  static final CsjAdManager instance = CsjAdManager._();

  Map<String, dynamic> _config = {};
  bool _inited = false;
  bool _listening = false;
  Completer<CsjRewardResult>? _pending;
  String? _pendingTxId;

  Map<String, dynamic> get config => _config;

  bool get enabled => _config['enabled'] == true;

  int get rewardIntegral => _asInt(_config['rewardIntegral']);

  int get dailyLimit => _asInt(_config['dailyLimit']);

  /// 拉取服务端配置（默认走缓存，force 强制刷新）
  Future<Map<String, dynamic>> loadConfig({bool force = false}) async {
    if (!force && _config.isNotEmpty) {
      return _config;
    }
    try {
      final res = await BService.csjConfig();
      _config = Map<String, dynamic>.from(res);
    } catch (e) {
      debugPrint('穿山甲配置拉取失败: $e');
      _config = <String, dynamic>{'enabled': false};
    }
    return _config;
  }

  /// 当前平台的广告位 ID
  String get _posId {
    final android = _config['rewardedVideoId'];
    final ios = _config['rewardedVideoIdIos'];
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      if (ios is String && ios.isNotEmpty) {
        return ios;
      }
    }
    return android is String ? android : '';
  }

  Future<bool> _ensureInit() async {
    if (_inited) {
      return true;
    }
    await loadConfig();
    if (!enabled) {
      return false;
    }
    final appId = _config['appId'];
    if (appId is! String || appId.isEmpty) {
      return false;
    }
    try {
      final ok = await FlutterPangleAds.initAd(appId);
      _inited = ok;
      if (ok) {
        _registerListener();
      }
      return ok;
    } catch (e) {
      debugPrint('穿山甲初始化失败: $e');
      return false;
    }
  }

  void _registerListener() {
    if (_listening) {
      return;
    }
    _listening = true;
    FlutterPangleAds.onEventListener((AdEvent event) {
      switch (event.action) {
        case AdEventAction.onAdReward:
          final reward = event as AdRewardEvent;
          final tx = reward.customData;
          if (tx != null && tx == _pendingTxId && reward.rewardVerify) {
            _complete(CsjRewardResult(success: true, transactionId: tx));
          }
          break;
        case AdEventAction.onAdError:
          final err = event as AdErrorEvent;
          debugPrint('穿山甲广告错误: ${err.errCode} ${err.errMsg}');
          _complete(CsjRewardResult(
              success: false, message: err.errMsg ?? '广告加载失败，请稍后再试'));
          break;
        case AdEventAction.onAdClosed:
          // 没走到 onAdReward 就关闭，说明用户提前退出
          _complete(const CsjRewardResult(success: false, message: '需看完广告才能领取奖励'));
          break;
        default:
          break;
      }
    });
  }

  void _complete(CsjRewardResult result) {
    final pending = _pending;
    if (pending != null && !pending.isCompleted) {
      pending.complete(result);
    }
  }

  /// 展示激励视频，等待奖励回调
  Future<CsjRewardResult> showRewardAd() async {
    if (!await _ensureInit()) {
      return const CsjRewardResult(success: false, message: '广告功能未开启');
    }
    if (_pending != null) {
      return const CsjRewardResult(success: false, message: '广告正在播放');
    }
    final posId = _posId;
    if (posId.isEmpty) {
      return const CsjRewardResult(success: false, message: '广告位未配置');
    }

    final txId = _newTxId();
    final completer = Completer<CsjRewardResult>();
    _pending = completer;
    _pendingTxId = txId;

    try {
      final shown =
          await FlutterPangleAds.showRewardVideoAd(posId, customData: txId);
      if (!shown) {
        _complete(const CsjRewardResult(success: false, message: '暂无广告，请稍后再试'));
      }
      return await completer.future.timeout(
        const Duration(seconds: 150),
        onTimeout: () =>
            const CsjRewardResult(success: false, message: '广告播放超时'),
      );
    } catch (e) {
      return CsjRewardResult(success: false, message: '广告展示异常：$e');
    } finally {
      _pending = null;
      _pendingTxId = null;
    }
  }

  String _newTxId() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final rand = Random().nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0');
    return 'csj_${ts}_$rand';
  }

  static int _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
