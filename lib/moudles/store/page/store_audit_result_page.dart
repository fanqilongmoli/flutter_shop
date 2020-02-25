import 'package:flutter/material.dart';
import 'package:flutter_shop/res/gaps.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/routers/fluro_navigator.dart';
import 'package:flutter_shop/routers/routers.dart';
import 'package:flutter_shop/widgets/app_bar.dart';
import 'package:flutter_shop/widgets/load_image.dart';
import 'package:flutter_shop/widgets/my_button.dart';

class StoreAuditResultPage extends StatefulWidget {
  @override
  _StoreAuditResultPageState createState() => _StoreAuditResultPageState();
}

class _StoreAuditResultPageState extends State<StoreAuditResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '审核结果',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Gaps.vGap50,
            LoadAssetImage(
              'store/icon_success',
              width: 80,
              height: 80,
            ),
            Gaps.vGap12,
            Text(
              '恭喜，店铺资料审核成功',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2019-02-21 15:20:10',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap8,
            Text(
              '预计完成时间：02月28日',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap12,
            Gaps.vGap12,
            MyButton(
              onPressed: () {
                NavigatorUtils.push(context, Routes.home, cleanStack: true);
              },
              text: '进入',
            )
          ],
        ),
      ),
    );
  }
}
