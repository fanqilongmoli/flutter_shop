import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/moudles/home/home_page.dart';
import 'package:flutter_shop/moudles/home/webview_page.dart';
import 'package:flutter_shop/moudles/login/login_router.dart';
import 'package:flutter_shop/moudles/shop/shop_router.dart';
import 'package:flutter_shop/moudles/store/store_router.dart';
import 'package:flutter_shop/routers/router_init.dart';
import 'package:flutter_shop/routers/404.dart';

class Routes {
  static String home = '/home';
  static String webView = '/webview';

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    // 指定路由跳转错误返回的页面
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      debugPrint("未找到目标页");
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(handlerFunc: (context, parameters) => Home()));

    router.define(webView, handler: Handler(handlerFunc: (context, parameters) {
      String title = parameters['title']?.first;
      String url = parameters['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();

    /// 各自路由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(StoreRouter());
    _listRouter.add(ShopRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
