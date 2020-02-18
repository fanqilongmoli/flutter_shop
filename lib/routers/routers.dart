import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
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
  }
}
