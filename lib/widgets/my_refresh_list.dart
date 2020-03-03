import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/util/theme_utils.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize);

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final style = ThemeUtils.isDark(context)
        ? TextStyles.textGray14
        : const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          hasMore ? const CupertinoActivityIndicator() : Gaps.empty,
          hasMore ? Gaps.hGap5 : Gaps.empty,

          /// 只有一页的时候，就不显示FooterView了
          Text(hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有了呦~'),
              style: style),
        ],
      ),
    );
  }
}
