import 'package:flutter/material.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/routers/fluro_navigator.dart';
import 'package:flutter_shop/util/theme_utils.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;

  BaseDialog(
      {Key key,
      this.title,
      this.onPressed,
      this.hiddenTitle: false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹起过渡动画
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        duration: Duration(milliseconds: 120),
        curve: Curves.easeOutCirc,
        child: Container(
          decoration: BoxDecoration(
            color: ThemeUtils.getDialogBackgroundColor(context),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 270.0,
          padding: EdgeInsets.only(top: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(
                offstage: hiddenTitle,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    hiddenTitle ? '' : title,
                    style: TextStyles.textBold18,
                  ),
                ),
              ),
              Flexible(child: child),
              Gaps.vGap8,
              Gaps.line,
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: FlatButton(
                        child: const Text(
                          '取消',
                          style: TextStyle(fontSize: Dimens.font_sp18),
                        ),
                        textColor: Colours.text_gray,
                        onPressed: () {
                          NavigatorUtils.goBack(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                    width: 0.6,
                    child: const VerticalDivider(),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: FlatButton(
                        child: const Text(
                          '确定',
                          style: TextStyle(fontSize: Dimens.font_sp18),
                        ),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          onPressed();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
