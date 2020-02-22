import 'package:flutter/material.dart';
import 'package:flutter_shop/res/resources.dart';

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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: EdgeInsets.only(right: 8.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(title),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0, left: 16.0),
                child: Text(
                  content,
                  maxLines: 2,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
              ),
            ),
            Images.arrowRight
          ],
        ),
      ),
    );
  }
}
