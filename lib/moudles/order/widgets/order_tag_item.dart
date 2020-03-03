import 'package:flutter/material.dart';
import 'package:flutter_shop/res/gaps.dart';
import 'package:flutter_shop/util/theme_utils.dart';
import 'package:flutter_shop/widgets/load_image.dart';
import 'package:flutter_shop/widgets/my_card.dart';

class OrderTagItem extends StatelessWidget {
  final String date;
  final int orderTotal;

  OrderTagItem({Key key, @required this.date, @required this.orderTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          height: 34.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              ThemeUtils.isDark(context)
                  ? LoadAssetImage('order/icon_calendar_dark',
                      width: 14.0, height: 14.0)
                  : LoadAssetImage('order/icon_calendar',
                      width: 14.0, height: 14.0),
              Gaps.hGap10,
              Text(date),
              Expanded(child: Gaps.empty),
              Text('$orderTotal单')
            ],
          ),
        ),
      ),
    );
  }
}
