import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/util/theme_utils.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:keyboard_actions/keyboard_action.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// 调起拨号页
  static void launchTelURL(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('拨号失败！');
    }
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
        keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
        nextFocus: true,
        actions: List.generate(
            list.length,
            (i) => KeyboardAction(focusNode: list[i], toolbarButtons: [
                  (node) {
                    return GestureDetector(
                        onTap: () => node.unfocus(),
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text('关闭'),
                        ));
                  }
                ])));
  }

  static String formatPrice(String price, {format: MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(
        NumUtil.getDoubleByValueStr(price), MoneyUnit.YUAN,
        format: format);
  }
}

/// 默认dialog背景色为半透明黑色，这里修改源码改为透明
Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
