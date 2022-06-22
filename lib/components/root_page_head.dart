// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/app_colors.dart';

class RootPageHead extends StatefulWidget {
  RootPageHead({Key? key}) : super(key: key);

  @override
  State<RootPageHead> createState() => _RootPageHeadState();
}

class _RootPageHeadState extends State<RootPageHead> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/common/logo.png",
          height: 40,
        ),
        Expanded(child: _searchContent()),
        Image.asset(
          "assets/images/icons/msg.png",
          height: 30,
        )
      ],
    );
  }

  Widget _searchContent() {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.page,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6, right: 2),
            child: Icon(
              Icons.search,
              size: 18,
              color: AppColors.un3active,
            ),
          ),
          Text(
            "搜索关键字",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.un3active,
            ),
          ),
        ],
      ),
    );
  }
}
