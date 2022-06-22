import 'package:flutter/cupertino.dart';

// 歌曲列表模型
class UserList {
  // 包含UserItem模型的集合

  final List<UserItem> list;
  UserList(this.list);
  factory UserList.fromJson(List<dynamic> list) {
    return UserList(
      list.map((item) => UserItem.fromJson(item)).toList(),
    );
  }
}

// 用户列表的每一项
class UserItem {
  final int id;
  final String coverPictureUrl;
  final String nickname;
  final String type;
  final int musicCount;
  final int musicPlayCount;

  UserItem({
    required this.id,
    required this.coverPictureUrl,
    required this.nickname,
    required this.type,
    required this.musicCount,
    required this.musicPlayCount,
  });

  factory UserItem.fromJson(dynamic item) {
    return UserItem(
      id: item['id'],
      coverPictureUrl: item['coverPictureUrl'],
      nickname: item['nickname'],
      type: item['type'],
      musicCount: item['musicCount'],
      musicPlayCount: item['musicPlayCount'],
    );
  }
}
