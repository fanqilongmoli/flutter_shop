import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/util/number_text_input_formatter.dart';

/// 封装输入框
class TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final FocusNode focusNode;

  TextFieldItem(
      {Key key,
      this.controller,
      @required this.title,
      this.textInputType: TextInputType.text,
      this.hintText: '',
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(title),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              focusNode: focusNode,
              keyboardType: textInputType,
              inputFormatters: _getInputFormatters(),
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, //去掉下划线
              ),
            ),
          ),
          Gaps.hGap16
        ],
      ),
    );
  }

  _getInputFormatters() {
    if (textInputType == TextInputType.numberWithOptions(decimal: true)) {
      return [UsNumberTextInputFormatter()];
    }
    if (textInputType == TextInputType.number ||
        textInputType == TextInputType.phone) {
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
  }
}
