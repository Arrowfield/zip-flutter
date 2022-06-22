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
