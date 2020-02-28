import 'package:flutter/material.dart';
import 'package:flutter_shop/moudles/order/provider/order_page_provider.dart';
import 'package:flutter_shop/res/colors.dart';
import 'package:flutter_shop/res/gaps.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/util/image_utils.dart';
import 'package:flutter_shop/util/theme_utils.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:flutter_shop/widgets/load_image.dart';
import 'package:flutter_shop/widgets/my_card.dart';
import 'package:flutter_shop/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

/// 订单页面
class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with
        AutomaticKeepAliveClientMixin<OrderPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  OrderPageProvider provider = OrderPageProvider();

  bool isDark;

  TabController _tabController;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider(
      create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: isDark
                    ? null
                    : DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF5793FA),
                        Color(0xFF4647FA)
                      ])),
                ),
              ),
            ),
            NestedScrollView(
                key: Key('order_list'),
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    _sliverBuilder(context),
                body: PageView.builder(
                    key: Key('order_list'),
                    itemCount: 5,
                    onPageChanged: (index) async {
                      provider.setIndex(index);
                      _tabController.animateTo(index);
                    },
                    controller: _pageController,
                    itemBuilder: null))
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          brightness: Brightness.dark,
          actions: <Widget>[
            IconButton(
              icon: LoadAssetImage(
                'order/icon_search',
                width: 22.0,
                height: 22.0,
                color: ThemeUtils.getIconColor(context),
              ),
              onPressed: () {
                Toast.show('点击搜索');
                //NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0,
          floating: false,
          // 不随着滑动隐藏标题
          pinned: true,
          // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark
                ? Container(
              height: 113.0,
              color: Colours.dark_bg_color,
            )
                : LoadAssetImage(
              'order/order_bg',
              width: double.infinity,
              height: 113.0,
              fit: BoxFit.fill,
            ),
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text(
              '订单',
              style: TextStyle(color: ThemeUtils.getIconColor(context)),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? Colours.dark_bg_color : null,
                image: isDark
                    ? null
                    : DecorationImage(
                    image: ImageUtils.getAssetImage('order/order_bg1'),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: MyCard(
                  child: Container(
                    height: 80.0,
                    padding: EdgeInsets.only(top: 8.0),
                    child: TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 0),
                        controller: _tabController,
                        labelColor: ThemeUtils.isDark(context)
                            ? Colours.dark_text
                            : Colours.text,
                        unselectedLabelColor: ThemeUtils.isDark(context)
                            ? Colours.dark_text_gray
                            : Colours.text,
                        labelStyle: TextStyles.textBold14,
                        unselectedLabelStyle:
                        TextStyle(fontSize: Dimens.font_sp14),
                        indicatorColor: Colors.transparent,
                        tabs: [
                          _TabView(0, '新订单'),
                          _TabView(1, '待配送'),
                          _TabView(2, '待完成'),
                          _TabView(3, '已完成'),
                          _TabView(4, '已取消'),
                        ]),
                  ),
                ),
              ),
            ),
            80.0),
        pinned: true,
      )
    ];
  }
}

var img = [
  ['order/xdd_s', 'order/xdd_n'],
  ['order/dps_s', 'order/dps_n'],
  ['order/dwc_s', 'order/dwc_n'],
  ['order/ywc_s', 'order/ywc_n'],
  ['order/yqx_s', 'order/yqx_n']
];

var darkImg = [
  ['order/dark/icon_xdd_s', 'order/dark/icon_xdd_n'],
  ['order/dark/icon_dps_s', 'order/dark/icon_dps_n'],
  ['order/dark/icon_dwc_s', 'order/dark/icon_dwc_n'],
  ['order/dark/icon_ywc_s', 'order/dark/icon_ywc_n'],
  ['order/dark/icon_yqx_s', 'order/dark/icon_yqx_n']
];

class _TabView extends StatelessWidget {
  final int index;
  final String text;

  _TabView(this.index, this.text);

  @override
  Widget build(BuildContext context) {
    var imgList = ThemeUtils.isDark(context) ? darkImg : img;
    return Consumer<OrderPageProvider>(
      builder: (_, provider, child) {
        int selectIndex = provider.index;
        return Stack(
          children: <Widget>[
            Container(
              width: 46.0,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoadAssetImage(
                    selectIndex == index
                        ? imgList[index][0]
                        : imgList[index][1],
                    width: 24.0,
                    height: 24.0,
                  ),
                  Gaps.vGap4,
                  Text(text)
                ],
              ),
            ),
            child
          ],
        );
      },
      child: Positioned(
          right: 0.0,
          child: index < 3
              ? DecoratedBox(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .errorColor,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
              child: Text(
                '10',
                style: TextStyle(
                    color: Colors.white, fontSize: Dimens.font_sp12),
              ),
            ),
          )
              : Gaps.empty),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  SliverAppBarDelegate(this.widget, this.height);

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return widget;
  }

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
