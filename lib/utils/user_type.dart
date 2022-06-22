import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/app_colors.dart';

class UserType {
  static Map enType = {
    'NORMAL_USER': 'NORMAL_USER',
    'DQ_SINGER': 'DQ_SINGER',
    'DQ_OFFICIAL_ACCOUNT': 'DQ_OFFICIAL_ACCOUNT',
    'ADMIN': 'ADMIN',
  };

  static Map cnType = {
    'NORMAL_USER': '普通用户',
    'DQ_SINGER': '读琴歌手',
    'DQ_OFFICIAL_ACCOUNT': '读琴号',
    'ADMIN': '管理员',
  };

  static Map colorType = {
    'NORMAL_USER': AppColors.unactive,
    'DQ_SINGER': AppColors.info,
    'DQ_OFFICIAL_ACCOUNT': AppColors.success,
    'ADMIN': AppColors.danger,
  };

  // 转中文
  static String formEn(String type) {
    return enType[type];
  }

  // 转中文
  static String formCn(String type) {
    return cnType[type] ?? '游客';
  }

  // 转中文
  static Color formColor(String type) {
    return colorType[type] ?? AppColors.unactive;
  }

  // 是否为普通用户
  static bool isNormal(String type) => type == enType['NORMAL_USER'];
  static bool isSinger(String type) => type == enType['DQ_SINGER'];
  static bool isOffcial(String type) => type == enType['DQ_OFFICIAL_ACCOUNT'];
  static bool isAdmin(String type) => type == enType['ADMIN'];
}
