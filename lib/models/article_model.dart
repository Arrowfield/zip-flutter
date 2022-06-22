import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_duuchin/models/user_model.dart';

// 歌曲列表模型
class ArticleList {
  // 包含UserItem模型的集合

  final List<ArticleItem> list;
  ArticleList(this.list);
  factory ArticleList.fromJson(List<dynamic> list) {
    return ArticleList(
      list.map((item) => ArticleItem.fromJson(item)).toList(),
    );
  }
}

// 歌曲每一项的详情模型
class ArticleItem {
  // song
  final int id;
  final int userId;
  final String coverUrlList;
  final String title;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final UserItem user;

  // 构造函数
  ArticleItem({
    required this.id,
    required this.userId,
    required this.coverUrlList,
    required this.title,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.user,
  });

  // ignore: empty_constructor_bodies
  factory ArticleItem.fromJson(dynamic item) {
    return ArticleItem(
      id: item['id'],
      userId: item['userId'],
      coverUrlList: item['coverUrlList'],
      title: item['title'],
      commentCount: item['commentCount'],
      thumbUpCount: item['thumbUpCount'],
      readCount: item['readCount'],
      user: UserItem.fromJson(item['user']),
    );
  }
}
