import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/root_page_head.dart';
import 'package:flutter_duuchin/view/sub_paegs/singer_page.dart';
import 'package:flutter_duuchin/view/sub_paegs/song_page.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

const List<Tab> _tabs = [
  Tab(text: "歌曲"),
  Tab(text: "歌手"),
];

final List<Widget> _tabsContent = [
  SongPage(),
  SingerPage(),
];

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  late TabController _tabController;

  // 生命周期函数
  @override
  void initState() {
    super.initState();

    // 数据的异步加载逻辑

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 0,
    );

    // 监听事件切换
    _tabController.addListener(() {
      _tabController.index;
    });

    //getList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RootPageHead(),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        children: _tabsContent,
        controller: _tabController,
      ),
    );
  }
}
