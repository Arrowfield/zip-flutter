// ignore_for_file: unused_element

import 'package:dio/dio.dart';

import 'http_interceptor.dart';
import '../config/http_options.dart';

// 封装http相关的请求
class HttpRequest {
  factory HttpRequest() => _instance;

  static final HttpRequest _instance = HttpRequest._internal();

  Dio? dio;
  // 内部构造方法
  HttpRequest._internal() {
    if (dio == null) {
      BaseOptions baseOptions = BaseOptions(
        baseUrl: HttpOptions.BASE_URL,
        connectTimeout: HttpOptions.CONNECT_TIMEROUT,
        receiveTimeout: HttpOptions.RECEIVE_TIMEOUT,
        headers: {},
      );

      dio = new Dio(baseOptions);

      dio!.interceptors.add(HttpInterceptor());
    }
  }

  void init({
    String? baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio!.options.baseUrl = baseUrl!;
    dio!.options.connectTimeout = connectTimeout!;
    dio!.options.receiveTimeout = receiveTimeout!;
    dio!.options.headers = headers;
    if (interceptors != null && interceptors.isNotEmpty) {
      dio!.interceptors.addAll(interceptors);
    }
  }

  // 设置头请求

  void setHeaders(Map<String, dynamic> headers) {
    dio!.options.headers.addAll(headers);
  }

  CancelToken _cancelToken = new CancelToken();
  // ignore: slash_for_doc_comments
  /**
   * 
   * 取消请求
   * 同一个cancel token 可以用于多个请求
   * 当一个cancel token取消时，可以使用该cancel token的请求都会被取消
   * 
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  // 设置鉴权请求头

  Options setAuthorizationHeader(Options requestOptions) {
    // String _token;
    // // ignore: unnecessary_null_comparison
    // if (_token != null) {
    //   requestOptions.headers!["token"] = _token;
    // }
    return requestOptions;
  }

  // get 事件的封装
  Future get(
    String path,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  ) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());

    print(dio!.options.baseUrl);
    print(path);

    Response response = await dio!.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  // post 传的是json对象
  Future post(
    String path,
    Map<String, dynamic> params,
    dynamic data,
    Options options,
    CancelToken cancelToken,
  ) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());
    Response response = await dio!.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );

    return response.data;
  }

  // post 提交表单操作 比方说文件file对象，就必须使用formData的形式提交，
  Future postForm(
    String path,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  ) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());

    Response response = await dio!.post(
      path,
      data: FormData.fromMap(params),
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }
}
