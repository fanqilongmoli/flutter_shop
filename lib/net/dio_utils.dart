import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_shop/common/common.dart';
import 'package:flutter_shop/net/base_entity.dart';
import 'package:flutter_shop/net/error_handle.dart';
import 'package:flutter_shop/net/intercept.dart';
import 'package:flutter_shop/util/log_utils.dart';
import 'package:rxdart/rxdart.dart';

class DioUtils {
  /// static final DioUtils _singleton = DioUtils.

  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    var options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          /// 不使用http状态码，使用AdapterInterceptor（适用于标准的REST风格）
          return true;
        },
        baseUrl: 'https://api.github.com/');
    _dio = Dio(options);

    /// 添加统一的请求头
    _dio.interceptors.add(AuthInterceptor());

    /// 刷新token
    _dio.interceptors.add(TokenInterceptor());

    /// 打印Log（生产模式去除）
    if (!Constant.inProduction) {
      _dio.interceptors.add(LoggingInterceptor());
    }

    /// 适配数据（根据自己的数据结构，可以自己选择添加）
    _dio.interceptors.add(AdapterInterceptor());
  }

  //数据返回格式统一，统一处理一异常
  Future<BaseEntity<T>> _request<T>(String method, String url,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    var response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    try {
      ///集成测试无法使用 isolate
      Map<String, dynamic> _map = Constant.isTest
          ? parseData(response.data.toString())
          : await compute(parseData, response.data.toString());
      return BaseEntity.formJson(_map);
    } catch (e) {
      print(e);
      return BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
    }
  }

  Future requestNetwork<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String m = _getRequestMethod(method);
    return _request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((BaseEntity<T> result) {
      if (result.code == 0) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.message, onError);
    });
  }

  /// rxDart 写法
  asyncRequestNetwork<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String m = _getRequestMethod(method);
    Observable.fromFuture(_request(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      if (result.code == 0) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e) {
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.message, onError);
    });
  }

  _onError(int code, String msg, Function(int code, String mag) onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    Log.e('接口请求异常： code: $code, mag: $msg');
    if (onError != null) {
      onError(code, msg);
    }
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消请求接口： $url');
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Map<String, dynamic> parseData(String data) {
    return json.decode(data);
  }

  String _getRequestMethod(Method method) {
    switch (method) {
      case Method.get:
        return 'GET';
      case Method.post:
        return 'POST';
      case Method.put:
        return 'PUT';
      case Method.patch:
        return 'PATCH';
      case Method.delete:
        return 'DELETE';
      case Method.head:
        return 'HEAD';
      default:
        return 'GET';
    }
  }
}

enum Method { get, post, put, patch, delete, head }
