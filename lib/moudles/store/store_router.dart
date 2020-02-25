import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_init.dart';

import 'page/store_audit_page.dart';
import 'page/store_audit_result_page.dart';

class StoreRouter implements IRouterProvider {
  //店铺审核页面
  static String auditPage = '/store/audit';

  //店铺审核结果页面
  static String auditResultPage = '/store/auditResult';

  @override
  void initRouter(Router router) {
    router.define(auditPage,
        handler: Handler(handlerFunc: (context, params) => StoreAuditPage()));
    router.define(auditResultPage,
        handler:
            Handler(handlerFunc: (context, params) => StoreAuditResultPage()));
  }
}
