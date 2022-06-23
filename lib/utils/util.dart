import 'dart:math';

import 'package:flutter/cupertino.dart';

// 转为rpx
double toRpx(BuildContext context, double size) {
  // 设计稿
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}

formatCharCount(int count) {
  if (count == null || count <= 0 || count.isNaN) {
    return "0";
  }
  String strCount = count.toString();

  if (strCount.length >= 5) {
    // double a = count / 10000;
    // strCount = a.toStringAsFixed(1) + 'w';
    String prefix = strCount.substring(0, strCount.length - 4);

    if (strCount.length == 5) {
      prefix += '.${strCount[1]}';
    }
    if (strCount.length == 6) {
      prefix += '.${strCount[2]}';
    }
    return prefix + 'w';
  }

  return strCount;
}

// 随机数的获取
int getRandomRangeInt(int min, int max) {
  final Random random = Random();
  return min + random.nextInt(max + 1 - min);
}

// 秒数转成 时分秒

String secondToTime(int seconds) {
  if (seconds == null || seconds <= 0 || seconds.isNaN) {
    return "00:00";
  }
  int hours = 0;
  int minutes = 0;
  int remainingSeconds = 0;

  hours = (seconds / 60 / 60).floor();
  minutes = (seconds / 60 % 60).floor();
  remainingSeconds = seconds % 60;
  return '${formatNumber(hours)}:${formatNumber(minutes)}:${formatNumber(remainingSeconds)}';
}

String formatNumber(int count) {
  String strCount = count.toString();
  return strCount.length > 1 ? strCount : '0$strCount';
}
