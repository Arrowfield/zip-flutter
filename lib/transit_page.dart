// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_duuchin/root_page.dart';

// 创建动态的组件

class TransitPage extends StatefulWidget {
  TransitPage({Key? key}) : super(key: key);

  @override
  State<TransitPage> createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  int _currentTime = 6;
  late Timer _timer;
  // 生命周期
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        _timer.cancel();
        _jumpRootPage();
      }
    });
  }

  // 跳到首页，并且销毁当前页面
  void _jumpRootPage() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return RootPage();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // 层叠布局
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/common/page.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: InkWell(
              child: _ClipButton(),
              onTap: _jumpRootPage,
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  // 跳过按钮
  Widget _ClipButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50), // 圆角的显示
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black.withOpacity(0.5), // 透明度的设置
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("跳过", style: TextStyle(color: Colors.white, fontSize: 12)),
            Text("${_currentTime}s",
                style: TextStyle(color: Colors.white, fontSize: 12))
          ],
        ),
      ),
    );
  }
}
