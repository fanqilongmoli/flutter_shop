import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/util/theme_utils.dart';

/// 自定义appBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  MyAppBar(
      {Key key,
      this.backgroundColor,
      this.title: '',
      this.centerTitle: '',
      this.actionName: '',
      this.backImg: 'assets/images/ic_back_black.png',
      this.onPressed,
      this.isBack: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Semantics(
                namesRoute: true,
                header: true,
                child: Container(
                  alignment: centerTitle.isEmpty
                      ? Alignment.centerLeft
                      : Alignment.center,
                  width: double.infinity,
                  child: Text(
                    title.isEmpty ? centerTitle : title,
                    style: TextStyle(fontSize: Dimens.font_sp18),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 48.0),
                ),
              ),
              isBack
                  ? IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.maybePop(context);
                      },
                      tooltip: 'Back',
                      padding: EdgeInsets.all(12),
                      icon: Image.asset(
                        backImg,
                        color: ThemeUtils.getIconColor(context),
                      ),
                    )
                  : Gaps.empty,
              Positioned(
                right: 0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    minWidth: 60,
                  )),
                  child: actionName.isEmpty
                      ? Container()
                      : FlatButton(
                          child: Text(
                            actionName,
                            key: Key("actionName"),
                          ),
                          textColor: ThemeUtils.isDark(context)
                              ? Colours.dark_text
                              : Colours.text,
                          highlightColor: Colors.transparent,
                          onPressed: onPressed,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
