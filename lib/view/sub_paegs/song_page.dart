import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/song_card.dart';
import 'package:flutter_duuchin/models/song_model.dart';
import 'package:flutter_duuchin/services/song_service.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

// EasyLoading

class SongPage extends StatefulWidget {
  SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage>
    with AutomaticKeepAliveClientMixin {
  // ignore: unused_field
  final EasyRefreshController _easyRefreshController = EasyRefreshController();

  List<SongItem> _songList = SongList([]).list;

  int page = 1;
  int limit = 10;

  bool hasMore = true;

  bool error = false;

  String errorMsg = "";

  // 获取数据

  @override
  void initState() {
    super.initState();

    // 初始化下拉刷新

//https://pub.dev/packages/flutter_easyrefresh

    // _easyRefreshController = EasyRefreshController();

    _getSongs();
  }

  Future _getSongs({bool push = false}) async {
    try {
      print("开始发送请求");
      Map<String, dynamic> result = await SongService.getSongs(page: page);

      print("获取到的数据是$result");

      SongList songListModel = SongList.fromJson(result['data']);

      setState(() {
        hasMore = page * limit < result['total'];
        page++;

        if (push) {
          _songList.addAll(songListModel.list);
        } else {
          _songList = songListModel.list;
        }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    }
  }

  // 下拉刷新
  Future _onRefresh() async {
    page = 1;
    await _getSongs();
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getSongs(
        push: true,
      );
    }
    // 完成加载
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: _easyRefreshController,
      footer: ClassicalFooter(),
      header: ClassicalHeader(),
      enableControlFinishRefresh: true, // 手动控制
      enableControlFinishLoad: true, // 手动控制
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        itemCount: _songList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 8,
              ),
              SongCard(songItem: _songList[index]),
            ],
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
