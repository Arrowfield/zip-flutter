import 'package:dio/dio.dart';

import 'http_exception.dart';

// 自定义拦截器

class HttpInterceptor extends Interceptor {
  // 请求拦截
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  // 响应拦截
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  // 异常拦截

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    HttpException httpException = HttpException.create(err);

    err.error = httpException;

    super.onError(err, handler);
  }
}
