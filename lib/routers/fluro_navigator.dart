import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/routers/application.dart';

import 'routers.dart';

class NavigatorUtils {
  /// 跳转
  static push(BuildContext context, String path,
      {bool replace: false, bool cleanStack: false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: cleanStack,
        transition: TransitionType.native);
  }

  /// 跳转并返回数据
  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((result) {
      // 页面返回会
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('pushResult错误 $error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  ///带参数返回
  static goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  /// 跳到WebView页
  static goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.webView}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }
}
