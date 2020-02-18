import 'package:flutter/material.dart';
import 'i_lifecycle.dart';

abstract class IMvpView {
  BuildContext getContext();
  /// 显示 progress
  void showProgress();

  /// 关闭进度条
  void closeProgress();

  void showToast(String text);
}

abstract class IPresenter extends ILifeCycle{}