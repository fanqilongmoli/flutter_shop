import 'package:fluro/fluro.dart';
import 'package:flutter_shop/moudles/order/page/order_page.dart';
import 'package:flutter_shop/routers/router_init.dart';

class OrderRouter implements IRouterProvider {
  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderTrackPage = '/order/track';

  @override
  void initRouter(Router router) {
    router.define(orderPage,
        handler: Handler(handlerFunc: (context, params) => OrderPage()));
  }
}
