import 'package:flutter/material.dart';
import 'package:sanyinghui/csj/csj_ad_manager.dart';
import 'package:sanyinghui/service.dart';
import 'package:sanyinghui/util/global.dart';
import 'package:sanyinghui/util/toast_utils.dart';

/// 看视频赚积分
///
/// 流程：拉配置 → 展示激励视频 → SDK 回调奖励 → 服务端发积分 → 刷新余额
class CsjRewardPage extends StatefulWidget {
  const CsjRewardPage({Key? key}) : super(key: key);

  @override
  State<CsjRewardPage> createState() => _CsjRewardPageState();
}

class _CsjRewardPageState extends State<CsjRewardPage> {
  bool _loading = true;
  bool _playing = false;
  bool _enabled = false;
  bool _knowToday = false;
  int _balance = 0;
  int _todayCount = 0;
  int _dailyLimit = 0;
  int _rewardIntegral = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final cfg = await CsjAdManager.instance.loadConfig(force: true);
    int balance = 0;
    if (Global.login) {
      try {
        final info = await BService.userinfo();
        balance = _toInt(info['integral']);
      } catch (_) {
        // 取不到余额不影响主流程
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _enabled = cfg['enabled'] == true;
      _rewardIntegral = CsjAdManager.instance.rewardIntegral;
      _dailyLimit = CsjAdManager.instance.dailyLimit;
      _balance = balance;
      _loading = false;
    });
  }

  Future<void> _onWatch() async {
    if (_playing) {
      return;
    }
    if (!Global.login) {
      ToastUtils.showToast('请先登录');
      return;
    }
    setState(() => _playing = true);
    try {
      final result = await CsjAdManager.instance.showRewardAd();
      if (!result.success) {
        ToastUtils.showToast(result.message ?? '未获得奖励');
        return;
      }
      final data = await BService.csjReward(
        transactionId: result.transactionId!,
      );
      final granted = _toInt(data['granted']);
      if (!mounted) {
        return;
      }
      setState(() {
        _balance = _toInt(data['balance']);
        _todayCount = _toInt(data['todayCount']);
        _knowToday = true;
      });
      ToastUtils.showToast(granted > 0 ? '获得 $granted 积分' : '奖励已发放');
    } catch (e) {
      ToastUtils.showToast('领取失败，请稍后再试');
    } finally {
      if (mounted) {
        setState(() => _playing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('看视频赚积分'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _enabled ? _buildEnabled() : _buildDisabled(),
            ),
    );
  }

  Widget _buildDisabled() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: const [
          Icon(Icons.ondemand_video_outlined, size: 56, color: Color(0xFFBDBDBD)),
          SizedBox(height: 16),
          Text('广告功能暂未开启', style: TextStyle(fontSize: 16, color: Color(0xFF757575))),
          SizedBox(height: 8),
          Text('请稍后再来', style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget _buildEnabled() {
    final reached = _knowToday && _dailyLimit > 0 && _todayCount >= _dailyLimit;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_circle_fill,
                    size: 40, color: Color(0xFFFF9800)),
              ),
              const SizedBox(height: 16),
              const Text('看视频赚积分',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(
                _rewardIntegral > 0
                    ? '完整观看一次视频，可获得 $_rewardIntegral 积分'
                    : '完整观看一次视频即可获得积分',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
              ),
              const SizedBox(height: 4),
              Text(
                _dailyLimit > 0 ? '每日最多 $_dailyLimit 次' : '每日不限次数',
                style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem('当前积分', '$_balance'),
                  _statItem(
                    '今日已看',
                    _knowToday ? '$_todayCount' : '--',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: (_playing || reached) ? null : _onWatch,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5000),
              disabledBackgroundColor: const Color(0xFFBDBDBD),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              _playing
                  ? '加载中...'
                  : reached
                      ? '今日次数已用完'
                      : '立即观看',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '观看过程中请勿关闭页面，广告播放完毕后积分自动到账',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
        ),
      ],
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
      ],
    );
  }

  static int _toInt(dynamic value) {
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
