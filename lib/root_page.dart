// 快捷导入 importM
import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/app_colors.dart';
import 'package:flutter_duuchin/view/root_pages/home_page.dart';
import 'package:flutter_duuchin/view/root_pages/music_page.dart';
import 'package:flutter_duuchin/view/root_pages/profile.dart';
import 'package:flutter_duuchin/view/root_pages/tiny_video.dart';

// 快速创建组件 state

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

const Map<String, String> _bottomNames = {
  "home": "首页",
  "music": "音乐",
  "create_media": "",
  "tiny_video": "小视频",
  "profile": "我的",
};

class _RootPageState extends State<RootPage> {
  // 导航的索引
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MusicPage(),
    Container(),
    TinyVideoPage(),
    ProfilePage()
  ];

  // 底部导航数组
  final List<BottomNavigationBarItem> _bottomNavBarList = [];

  @override
  void initState() {
    super.initState();
    _bottomNames.forEach((key, value) {
      _bottomNavBarList.add(_bottomNavBatItem(key, value));
    });
  }

  void _onTabClick(int index) {
    if (index == 2) {
      return _onCreateMedia();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 层叠是布局
      body: _pages[_currentIndex], // 这种方式每次都会再次请求，销毁页面 不好
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _createMediaBotton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 点击发布按钮 触发的事件
  void _onCreateMedia() {
    print("_onCreateMedia");
  }

  // 发布按钮 点击可以发布相关事件
  Widget _createMediaBotton() {
    return Container(
      height: 44,
      width: 44,
      margin: EdgeInsets.only(top: 56),
      child: FloatingActionButton(
        backgroundColor: AppColors.nav,
        child: Image.asset(
          "assets/images/icons/create_media.png",
          width: 48,
          height: 48,
        ),
        onPressed: _onCreateMedia,
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBatItem(String key, String value) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        "assets/images/icons/$key.png",
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        "assets/images/icons/${key}_active.png",
        width: 24,
        height: 24,
      ),
      label: value,
      tooltip: '', // 去掉按钮的长按的tips
    );
  }
}
