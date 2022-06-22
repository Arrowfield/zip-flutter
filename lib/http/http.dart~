import 'package:dio/dio.dart';
import 'http_request.dart';

// 定义一个静态类

class Http {
  // 初始化
  static void init({
    String? baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    HttpRequest().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
      interceptors: interceptors,
    );
  }

  // 设置请求头
  static void setHeaders(Map<String, dynamic> headers) {
    HttpRequest().setHeaders(headers);
  }

  // 取消请求
  static void cancelRequests({CancelToken? token}) {
    HttpRequest().cancelRequests(token: token);
  }

  // get请求
  static Future get(
    String path,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  ) async {
    return await HttpRequest().get(
      path,
      params,
      options,
      cancelToken,
    );
  }

  // post请求
  static Future post(
    String path,
    Map<String, dynamic> params,
    dynamic data,
    Options options,
    CancelToken cancelToken,
  ) async {
    return await HttpRequest().post(
      path,
      params,
      data,
      options,
      cancelToken,
    );
  }

  // formDate
  static Future postForm(
    String path,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  ) async {
    return await HttpRequest().postForm(
      path,
      params,
      options,
      cancelToken,
    );
  }
}
