import 'package:flutter/material.dart';

class StoreSelectTextItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;

  StoreSelectTextItem(
      {Key key,
      this.onTap,
      @required this.title,
      this.content: '',
      this.textAlign: TextAlign.start,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
