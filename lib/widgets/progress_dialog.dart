import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 加载中的弹出框
class ProgressDialog extends Dialog {
  final String hintText;

  ProgressDialog({Key key, this.hintText: ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88,
          width: 120,
          decoration: ShapeDecoration(
              color: Color(0xFF3A3A3A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: ThemeData(
                    cupertinoOverrideTheme:
                        CupertinoThemeData(brightness: Brightness.dark)),
                child: CupertinoActivityIndicator(radius: 14),
              ),
              SizedBox(height: 8.0),
              Text(
                hintText,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
