import 'package:flutter/material.dart';
import 'package:flutter_shop/mvp/base_page_presenter.dart';
import 'package:flutter_shop/mvp/mvps.dart';
import 'package:flutter_shop/routers/fluro_navigator.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:flutter_shop/util/utils.dart';
import 'package:flutter_shop/widgets/progress_dialog.dart';

abstract class BasePageState<T extends StatefulWidget,
    V extends BasePagePresenter> extends State<T> implements IMvpView {
  V presenter;

  BasePageState() {
    presenter = createPresenter();
    presenter.view = this;
  }

  V createPresenter();

  @override
  BuildContext getContext() {
    return context;
  }

  bool _isShowDialog = false;

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  @override
  void showProgress() {
    // 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showTransparentDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return WillPopScope(
                onWillPop: () async {
                  // 拦截到返回键，证明dialog被手动关闭
                  _isShowDialog = false;
                  return Future.value(true);
                },
                child: ProgressDialog(hintText: '正在加载...'),
              );
            });
      } catch (e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showToast(String text) {
    Toast.show(text);
  }

  @override
  void initState() {
    super.initState();
    presenter?.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter?.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  void didUpdateWidgets<W>(W oldWidget) {
    presenter?.didUpdateWidgets<W>(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
    presenter?.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    presenter?.dispose();
  }
}
