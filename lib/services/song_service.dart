import 'package:dio/dio.dart';
import 'package:flutter_duuchin/http/http.dart';

class SongService {
  static const String rootPath = '/api/song';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 列表数据的获取
  static Future getSongs({int page = 1, int limit = 10}) async {
    final response = await Http.post(
      listPath,
      {},
      {'page': page, 'pageSize': limit},
      Options(),
      CancelToken(),
    );
    // print("response的值是$response");
    //Map<String, dynamic> result = response['page'];
    return response;
  }
}
