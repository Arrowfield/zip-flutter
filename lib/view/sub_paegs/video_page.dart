import 'package:flutter/material.dart';

import 'package:flutter_duuchin/components/video_cart.dart';

import 'package:flutter_duuchin/models/video_model.dart';

import 'package:flutter_duuchin/services/video_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin {
  // 获取数据

  final EasyRefreshController _easyRefreshController = EasyRefreshController();

  List<VideoItem> _videoList = VideoList([]).list;

  int page = 1;
  int limit = 10;

  bool hasMore = true;

  bool error = false;

  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    _getVideos();
  }

  Future _getVideos({bool push = false}) async {
    try {
      print("开始发送请求");
      Map<String, dynamic> result = await VideoService.getVideos(
        page: page,
      );

      //print("获取到的数据是$result");

      VideoList VideoListModel = VideoList.fromJson(result['data']);

      setState(() {
        hasMore = page * limit < result['total'];
        page++;

        if (push) {
          _videoList.addAll(VideoListModel.list);
        } else {
          _videoList = VideoListModel.list;
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
    await _getVideos();
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getVideos(
        push: true,
      );
    }
    // 完成加载
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _easyRefreshController,
      footer: ClassicalFooter(),
      header: ClassicalHeader(),
      enableControlFinishRefresh: true, // 手动控制
      enableControlFinishLoad: true, // 手动控制
      onRefresh: _onRefresh,
      onLoad: _onLoad,

      child: ListView.builder(
        itemCount: _videoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 8,
              ),
              VideoCard(videoItem: _videoList[index]),
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
