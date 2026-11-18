/**
 *  Copyright (C) 2018-2026
 *  All rights reserved, Designed By syh.hzhero.cn
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maixs_utils/util/utils.dart';
import 'package:sanyinghui/bindCard/addCard.dart';
import 'package:sanyinghui/csj/csj_reward_page.dart';
import 'package:sanyinghui/dy/dy_detail_page.dart';
import 'package:sanyinghui/index/Index.dart';
import 'package:sanyinghui/index/local_page.dart';
import 'package:sanyinghui/jd/jd_details_page.dart';
import 'package:sanyinghui/jd/jd_index_page.dart';
import 'package:sanyinghui/login/login_code.dart';
import 'package:sanyinghui/login/login_first.dart';
import 'package:sanyinghui/login/login_second.dart';
import 'package:sanyinghui/login/login_third.dart';
import 'package:sanyinghui/me/about_us.dart';
import 'package:sanyinghui/me/address_list.dart';
import 'package:sanyinghui/me/auth_page.dart';
import 'package:sanyinghui/me/cash/cash_index_page.dart';
import 'package:sanyinghui/me/cash/cash_record_list_page.dart';
import 'package:sanyinghui/me/cash/money_list.dart';
import 'package:sanyinghui/me/collect_page.dart';
import 'package:sanyinghui/me/create_address.dart';
import 'package:sanyinghui/me/create_order.dart';
import 'package:sanyinghui/me/fans/fans.dart';
import 'package:sanyinghui/me/fans/fans_detail_page.dart';
import 'package:sanyinghui/me/feedback_page.dart';
import 'package:sanyinghui/me/help/ChewieVideoPage.dart';
import 'package:sanyinghui/me/help/help_content_page.dart';
import 'package:sanyinghui/me/myself.dart';
import 'package:sanyinghui/me/nickname_page.dart';
import 'package:sanyinghui/me/personal.dart';
import 'package:sanyinghui/me/phone/phone_page.dart';
import 'package:sanyinghui/me/points_mall_page.dart';
import 'package:sanyinghui/me/realname_page.dart';
import 'package:sanyinghui/me/settings.dart';
import 'package:sanyinghui/me/spread_page.dart';
import 'package:sanyinghui/me/vip/cashier_page.dart';
import 'package:sanyinghui/me/vip/vip.dart';
import 'package:sanyinghui/order/integral_list.dart';
import 'package:sanyinghui/order/order_retrieval.dart';
import 'package:sanyinghui/page/AliRedPage.dart';
import 'package:sanyinghui/page/BlankPage.dart';
import 'package:sanyinghui/page/ElePage.dart';
import 'package:sanyinghui/page/MeiTuanPage.dart';
import 'package:sanyinghui/page/TaoRedPage.dart';
import 'package:sanyinghui/page/WaiMaiPage.dart';
import 'package:sanyinghui/page/big_coupon_page.dart';
import 'package:sanyinghui/page/brand_sale_page.dart';
import 'package:sanyinghui/page/inspect_goods_page.dart';
import 'package:sanyinghui/page/ku_custom_page.dart';
import 'package:sanyinghui/page/mini_page.dart';
import 'package:sanyinghui/page/nine_page.dart';
import 'package:sanyinghui/page/pick_leak_page.dart';
import 'package:sanyinghui/page/product_details.dart';
import 'package:sanyinghui/page/seckill_page.dart';
import 'package:sanyinghui/pay/ios_payment.dart';
import 'package:sanyinghui/pdd/pdd_index_page.dart';
import 'package:sanyinghui/search/search_page.dart';
import 'package:sanyinghui/search/search_result.dart';
import 'package:sanyinghui/shop/shop_auth_page.dart';
import 'package:sanyinghui/shop/shop_contract_page.dart';
import 'package:sanyinghui/shop/shop_signature_page.dart';
import 'package:sanyinghui/tao/tb_index_page.dart';
import 'package:sanyinghui/util/global.dart';
import 'package:sanyinghui/vip/vip_detail_page.dart';
import 'package:sanyinghui/vip/vip_index_page.dart';
import 'package:sanyinghui/webview/alipay_webview.dart';
import 'package:sanyinghui/webview/custom_webview.dart';
import 'package:sanyinghui/webview/pay_webview.dart';
import 'package:sanyinghui/widget/camera/mask_camera.dart';
import 'package:url_strategy/url_strategy.dart';

import 'bindCard/supportBank_list.dart';
import 'bindCard/verify_addCard.dart';
import 'dy/dy_index_page.dart';
import 'energy/energy_list.dart';
import 'energy/energy_page.dart';
import 'generated/l10n.dart';
import 'init/splash_page.dart';
import 'me/cash/cash_page.dart';
import 'me/cash/cash_result_page.dart';
import 'me/fee/fee_page.dart';
import 'me/fee/fee_tab_page.dart';
import 'me/help/help_fanli_page.dart';
import 'me/help/help_page.dart';
import 'me/kouling_page.dart';
import 'me/messageCenter.dart';
import 'me/phone/phone_code_page.dart';
import 'me/points_mall_details.dart';
import 'me/setting/account_cancel.dart';
import 'me/share_page.dart';
import 'me/vip/tab_vip.dart';
import 'order/order_list.dart';
import 'page/sell_page.dart';
import 'page/top_page.dart';
import 'pdd/pdd_detail_page.dart';

class SfbApp extends StatelessWidget {
  // 路由路径匹配
  Route<dynamic>? _getRoute(RouteSettings settings) {
    Map arg = {};
    if (settings.arguments != null) {
      arg = settings.arguments as Map;
    }
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => SplashPage(),
      '/index': (BuildContext context) => Index(),
      '/login': (BuildContext context) => LoginFirst(arg),
      '/loginSecond': (BuildContext context) => LoginSecond(arg),
      '/loginThird': (BuildContext context) => LoginThird(arg),
      '/loginCode': (BuildContext context) => LoginCode(arg),
      '/webview': (BuildContext context) => CustomWebView(arg),
      '/payWebview': (BuildContext context) => PayWebView(arg),
      '/alipayWebview': (BuildContext context) => AlipayWebView(arg),
      '/detail': (BuildContext context) => ProductDetails(arg),
      '/detailJD': (BuildContext context) => JDDetailsPage(arg),
      '/detailPDD': (BuildContext context) => PddDetailPage(arg),
      '/detailDY': (BuildContext context) => DyDetailPage(arg),
      '/detailVIP': (BuildContext context) => VipDetailPage(arg),
      '/top': (BuildContext context) => TopPage(data: arg),
      '/settings': (BuildContext context) => Settings(arg),
      '/me': (BuildContext context) => MySelfPage(),
      '/pointsMall': (BuildContext context) => PointsMallPage(arg),
      '/csjReward': (BuildContext context) => const CsjRewardPage(),
      '/pointsMallDetail': (BuildContext context) => PointsMallDetail(arg),
      '/createOrder': (BuildContext context) => CreateOrder(arg),
      '/addressList': (BuildContext context) => AddressList(data: arg),
      '/createAddress': (BuildContext context) => CreateAddress(arg),
      '/search': (BuildContext context) => SearchPage(data: arg),
      '/orderRetrieval': (BuildContext context) => OrderRetrieval(arg),
      '/orderList': (BuildContext context) => OrderList(arg),
      '/personal': (BuildContext context) => Personal(arg),
      '/feedback': (BuildContext context) => FeedbackPage(),
      '/aboutUs': (BuildContext context) => AboutUs(),
      '/integralList': (BuildContext context) => IntegralList(),
      '/fans': (BuildContext context) => Fans(arg),
      '/nickname': (BuildContext context) => NicknamePage(),
      '/realName': (BuildContext context) => RealNamePage(),
      '/cashIndex': (BuildContext context) => CashIndexPage(arg),
      '/cash': (BuildContext context) => CashPage(arg),
      '/cashResult': (BuildContext context) => CashResultPage(),
      '/cashRecord': (BuildContext context) => CashRecordListPage(),
      '/jdIndex': (BuildContext context) => JdIndexPage(),
      '/pddIndex': (BuildContext context) => PddIndexPage(),
      '/dyIndex': (BuildContext context) => DyIndexPage(),
      '/bigCouponPage': (BuildContext context) => BigCouponPage(data: arg),
      '/ddq': (BuildContext context) => SeckillPage(),
      '/miniPage': (BuildContext context) => MiniPage(),
      '/kuCustomPage': (BuildContext context) => KuCustomPage(arg),
      '/ninePage': (BuildContext context) => NinePage(),
      '/pickLeakPage': (BuildContext context) => PickLeakPage(),
      '/brandSalePage': (BuildContext context) => BrandSalePage(
            data: arg,
          ),
      '/searchResult': (BuildContext context) => SearchResultPage(
            arg,
          ),
      '/inspectGoodsPage': (BuildContext context) => InspectGoodsPage(arg),
      '/vipPage': (BuildContext context) => VipIndexPage(arg),
      '/helpPage': (BuildContext context) => HelpPage2(),
      '/helpContentPage': (BuildContext context) => HelpContentPage(arg),
      '/vip': (BuildContext context) => VipPage(arg),
      '/authPage': (BuildContext context) => AuthPage(arg),
      '/phonePage': (BuildContext context) => PhonePage(arg),
      '/phoneCodePage': (BuildContext context) => PhoneCodePage(arg),
      '/spreadPage': (BuildContext context) => SpreadPage(),
      '/collectPage': (BuildContext context) => CollectPage(),
      '/koulingPage': (BuildContext context) => KoulingPage(arg),
      '/iosPayment': (BuildContext context) => IOSPayment(),
      '/accountCancel': (BuildContext context) => AccountCancel(arg),
      '/helpFanliPage': (BuildContext context) => HelpFanliPage(),
      '/helpVideo': (BuildContext context) => ChewieVideoPage(arg),
      '/aliRed': (BuildContext context) => AliRedPage(arg),
      '/waimai': (BuildContext context) => WaiMaiPage(arg),
      '/moneyList': (BuildContext context) => MoneyList(arg),
      '/tbIndex': (BuildContext context) => TbIndexPage(),
      '/tabVip': (BuildContext context) => TabVip(arg),
      '/feeTabPage': (BuildContext context) => FeeTabPage(arg),
      '/feePage': (BuildContext context) => FeePage(arg),
      '/fansDetailPage': (BuildContext context) => FansDetailPage(arg),
      '/shopAuthPage': (BuildContext context) => ShopAuthPage(),
      '/idCard': (BuildContext context) => MaskOCRCam(
            onCapture: arg['fun'],
          ),
      '/shopContractPage': (BuildContext context) => ShopContractPage(arg),
      '/signaturePage': (BuildContext context) => ShopSignaturePage(),
      '/cashierPage': (BuildContext context) => CashierPage(arg),

      '/addCard': (BuildContext context) => AddCard(arg),
      '/verifyaddCard': (BuildContext context) => VerifyAddCard(arg),
      '/sharePage': (BuildContext context) => SharePage(arg),
      '/energyPage': (BuildContext context) => EnergyPage(arg),
      '/energyList': (BuildContext context) => EnergyList(arg),
      '/messageCenter': (BuildContext context) => MessageCenter(),
      '/sellPage': (BuildContext context) => SellPage(arg),

      '/supportBankList': (BuildContext context) => SupportBankList(),
      '/blankPage': (BuildContext context) => BlankPage(arg),
      '/taoRedPage': (BuildContext context) => TaoRedPage(arg),
      '/meiTuanPage': (BuildContext context) => MeiTuanPage(arg),
      '/elePage': (BuildContext context) => ElePage(arg),
      '/localPage': (BuildContext context) => LocalPage(),
    };
    var widget = routes[settings.name];

    if (widget != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: widget,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations
                .delegate, //一定要配置,否则iphone手机长按编辑框有白屏卡着的bug出现
            S.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: APP_NAME,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: false,
            primarySwatch: Colors.red,
            textTheme: Theme.of(context).textTheme,
            platform: TargetPlatform.iOS,
          ),
          home: child,
          onGenerateRoute: _getRoute,
          navigatorKey: navigatorKey,
        );
      },
      child: Global.isWeb() ? Index() : SplashPage(),
    );
    ;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // initWebview();
  // 强制竖屏
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  setPathUrlStrategy();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(SfbApp());
}

// Future initWebview() async {
//   if (Global.isAndroid()) {
//     await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
//   }
// }
