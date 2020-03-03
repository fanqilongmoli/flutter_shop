import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/moudles/order/widgets/order_item_button.dart';
import 'package:flutter_shop/moudles/order/widgets/pay_type_dialog.dart';
import 'package:flutter_shop/res/dimens.dart';
import 'package:flutter_shop/res/gaps.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/routers/fluro_navigator.dart';
import 'package:flutter_shop/util/theme_utils.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:flutter_shop/util/utils.dart';
import 'package:flutter_shop/widgets/my_card.dart';

import '../order_router.dart';

const List<String> orderLeftButtonText = ['拒单', '拒单', '订单跟踪', '订单跟踪', '订单跟踪'];
const List<String> orderRightButtonText = ['接单', '开始配送', '完成', '', ''];

class OrderItem extends StatelessWidget {
  final int tabIndex;
  final int index;

  OrderItem({Key key, @required this.tabIndex, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: MyCard(
          child: Container(
        padding: EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () => Toast.show('进出订单详情页面'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('18170036523（樊启龙）'),
                  ),
                  Text(
                    '货到付款',
                    style: TextStyle(
                        fontSize: Dimens.font_sp12,
                        color: Theme.of(context).errorColor),
                  )
                ],
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              Text(
                '江西省南昌市东湖区八一桥街道',
                style: Theme.of(context).textTheme.subtitle,
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              RichText(
                text: TextSpan(style: textTextStyle, children: [
                  TextSpan(text: '清凉一度抽纸'),
                  TextSpan(
                      text: '  x1',
                      style: Theme.of(context).textTheme.subtitle),
                ]),
              ),
              Gaps.vGap8,
              RichText(
                  text: TextSpan(
                style: textTextStyle,
                children: <TextSpan>[
                  TextSpan(text: '清凉一度抽纸'),
                  TextSpan(
                      text: '  x2',
                      style: Theme.of(context).textTheme.subtitle),
                ],
              )),
              Gaps.vGap12,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(
                            text: Utils.formatPrice('20.00',
                                format: MoneyFormat.NORMAL)),
                        TextSpan(
                            text: '  共3件商品',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(fontSize: Dimens.font_sp10)),
                      ],
                    )),
                  ),
                  Text(
                    '2020.02.05 10:00',
                    style: TextStyles.textSize12,
                  )
                ],
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              Row(
                children: <Widget>[
                  OrderItemButton(
                    text: '联系客户',
                    textColor: isDark ? Colours.dark_text : Colours.text,
                    bgColor:
                        isDark ? Colours.dark_material_bg : Colours.bg_gray,
                    onTap: () => _showCallPhoneDialog(context, '18170036523'),
                  ),
                  Expanded(
                    child: Gaps.empty,
                  ),
                  OrderItemButton(
                    text: orderLeftButtonText[tabIndex],
                    textColor: isDark ? Colours.dark_text : Colours.text,
                    bgColor:
                        isDark ? Colours.dark_material_bg : Colours.bg_gray,
                    onTap: () {
                      if (tabIndex >= 2) {
                        NavigatorUtils.push(
                            context, OrderRouter.orderTrackPage);
                      }
                    },
                  ),
                  orderRightButtonText[tabIndex].length == 0
                      ? Gaps.empty
                      : Gaps.hGap10,
                  orderRightButtonText[tabIndex].length == 0
                      ? Gaps.empty
                      : OrderItemButton(
                          text: orderRightButtonText[tabIndex],
                          textColor:
                              isDark ? Colours.dark_button_text : Colors.white,
                          bgColor:
                              isDark ? Colours.dark_app_main : Colours.app_main,
                          onTap: () {
                            if (tabIndex == 2) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return PayTypeDialog(
                                        onPressed: (index, type) {
                                      Toast.show('收款类型：$type');
                                    });
                                  });
                            }
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void _showCallPhoneDialog(BuildContext context, String phone) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Theme.of(context).errorColor,
                child: Text('拨打'),
              ),
            ],
          );
        });
  }
}
