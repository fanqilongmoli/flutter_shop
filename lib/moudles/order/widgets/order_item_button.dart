import 'package:flutter/material.dart';
import 'package:flutter_shop/res/dimens.dart';

class OrderItemButton extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final GestureTapCallback onTap;
  final String text;

  OrderItemButton(
      {Key key, this.bgColor, this.textColor, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(4.0)),
        constraints: BoxConstraints(
          minWidth: 64.0,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),
        ),
      ),
      onTap: onTap,
    );
  }
}
