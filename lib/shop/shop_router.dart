import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_init.dart';
import 'package:flutter_shop/shop/page/address_select_page.dart';

class ShopRouter implements IRouterProvider {
  static String shopPage = '/shop';
  static String shopSettingPage = '/shop/shopSetting';
  static String messagePage = '/shop/message';
  static String freightConfigPage = '/shop/freightConfig';
  static String addressSelectPage = '/shop/addressSelect';

  @override
  void initRouter(Router router) {
    router.define(addressSelectPage,
        handler: Handler(handlerFunc: (_, params) => AddressSelectPage()));
  }
}
