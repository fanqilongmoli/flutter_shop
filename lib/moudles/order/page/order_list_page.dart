import 'package:flutter/material.dart';
import 'package:flutter_shop/moudles/order/provider/order_page_provider.dart';
import 'package:flutter_shop/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  final int index;

  OrderListPage({Key key, @required this.index}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();
  List _list = [];

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        displacement: 120.0, // 默认40 多添加的80为Header的高度
        onRefresh: _onRefresh,
        child: Consumer<OrderPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              //这里指定的controller可以与外层NestedScrollView的滚动分离，避免一处滚动，5个tab中的列表同步滚动
              // 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>('$_index'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                child
              ],
            );
          },
          child: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: _list.isEmpty
                ? SliverFillRemaining(
                    child: StateLayout(
                      type: _stateType,
                    ),
                  )
                : SliverList(delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                  return index < _list.length?(index % 5==0?)
            })),
          ),
        ),
      ),
    );
  }

  void _onRefresh() {}

  void _loadMore() {}

  @override
  bool get wantKeepAlive => true;
}
