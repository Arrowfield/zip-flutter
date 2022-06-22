import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/root_page_head.dart';
import 'package:flutter_duuchin/http/http.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<Tab> _tabs = [
  Tab(text: "歌曲"),
  Tab(text: "推荐"),
  Tab(text: "歌手"),
  Tab(text: "小视频"),
  Tab(text: "文章"),
  Tab(text: "视频"),
];

final List<Widget> _tabsContent = [
  Text("1111111"),
  Text("1111111"),
  Text("1111111"),
  Text("1111111"),
  Text("1111111"),
  Text("1111111"),
];

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  // 生命周期函数
  @override
  void initState() {
    super.initState();

    // 数据的异步加载逻辑

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 1,
    );

    // 监听事件切换
    _tabController.addListener(() {
      _tabController.index;
    });

    getList();
  }

  Future getList() async {
    print(" 开始发送请求 ");
    final result = await Http.get(
      "/api/song/info/2",
      {},
      Options(),
      CancelToken(),
    );
    print(result);
    print(" 发送请求结束 ");
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
