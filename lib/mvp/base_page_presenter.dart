import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/net/dio_utils.dart';
import 'package:flutter_shop/net/net.dart';
import 'package:meta/meta.dart';
import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends IPresenter {
  V view;

  CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void initState() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidgets<W>(W oldWidget) {}

  @override
  void deactivate() {}

  @override
  void dispose() {
    /// 组件销毁的时候 将请求取消掉
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  /// 返回future 适用于刷新，加载更多
  Future requestNetwork<T>(Method method,
      {@required String url,
      bool isShow: true,
      bool isClose: true,
      Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String mesg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    if (isShow) view.showProgress();
    return DioUtils.instance.requestNetwork(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onSuccessList: (list) {
      if (isClose) view.closeProgress();
      if (onSuccessList != null) {
        onSuccessList(list);
      }
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  void asyncRequestNetwork<T>(Method method,
      {@required String url,
      bool isShow: true,
      bool isClose: true,
      Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    if (isShow) view.showProgress();
    DioUtils.instance.asyncRequestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
        isList: isList, onSuccess: (data) {
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onSuccessList: (data) {
      if (isClose) view.closeProgress();
      if (onSuccessList != null) {
        onSuccessList(data);
      }
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  ///上传图片实现
  Future<String> uploadImage(File image) async {
    String imgPath = '';
    try {
      String path = image.path;
      var name = path.substring(path.lastIndexOf('/') + 1);
      FormData formData = FormData.fromMap(
          {'uploadIcon': await MultipartFile.fromFile(path, filename: name)});
      await requestNetwork(Method.post, url: HttpApi.upload, params: formData,
          onSuccess: (data) {
        imgPath = data;
      });
    } catch (e) {
      view.showToast('图片上传失败！');
    }
    return imgPath;
  }

  _onError(int code, String msg, Function(int code, String msg) onError) {
    /// 发生异常直接关闭 progress
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }

    /// 页面如果dispose，则不回调onError
    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }
}
