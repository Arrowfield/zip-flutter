import 'package:dio/dio.dart';
import 'package:flutter_duuchin/http/http.dart';

class UserService {
  static const String rootPath = '/api/user';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 用户数据的获取
  static Future getUsers({
    int page = 1,
    int limit = 10,
    String? type,
  }) async {
    final response = await Http.post(
      listPath,
      {},
      {'page': page, 'pageSize': limit, 'type': type},
      Options(),
      CancelToken(),
    );
    // print("response的值是$response");
    //Map<String, dynamic> result = response['page'];
    return response;
  }
}
