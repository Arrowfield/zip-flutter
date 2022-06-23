import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_duuchin/components/article_card.dart';
import 'package:flutter_duuchin/components/singer_card.dart';
import 'package:flutter_duuchin/components/song_card.dart';
import 'package:flutter_duuchin/components/video_cart.dart';
import 'package:flutter_duuchin/models/article_model.dart';
import 'package:flutter_duuchin/models/recommend_interface.dart';
import 'package:flutter_duuchin/models/song_model.dart';
import 'package:flutter_duuchin/models/user_model.dart';
import 'package:flutter_duuchin/models/video_model.dart';
import 'package:flutter_duuchin/services/article_service.dart';
import 'package:flutter_duuchin/services/recommend_service.dart';
import 'package:flutter_duuchin/services/song_service.dart';
import 'package:flutter_duuchin/services/user_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key? key}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  // 获取数据

  final EasyRefreshController _easyRefreshController = EasyRefreshController();

  List<RecommendInterface?> _recommendList = [];

  int page = 1;
  int limit = 10;

  bool hasMore = true;

  bool error = false;

  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    _getRecommends();
  }

  Future _getRecommends({bool push = false}) async {
    try {
      print("开始发送请求");

      Map<String, dynamic> result = await RecommendService.getRecommends(
        page: page,
      );

      // 数据处理

      List<dynamic> list = result['data'];
      // print("推荐处的数据是1:$list");

      List<RecommendInterface?> recommendList = list.map((item) {
        if (item['songEntity'] != null) {
          return SongItem.fromJson(item['songEntity']);
        } else if (item['articleEntity'] != null) {
          // print("数据打印结果如下：$item,${list.length}");
          return ArticleItem.fromJson(item['articleEntity']);
        } else if (item['videoEntity'] != null) {
          return VideoItem.fromJson(item['videoEntity']);
        }
      }).toList();

      setState(() {
        page++;

        if (push) {
          _recommendList.addAll(recommendList);
        } else {
          _recommendList = recommendList;
        }
      });

      // print("推荐处的数据是2:$recommendList");
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
    await _getRecommends();
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getRecommends(
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
        itemCount: _recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          RecommendInterface? widgetItem = _recommendList![index];
          //print("widgetItem的值是$widgetItem");
          if (widgetItem == null) {
            return SizedBox.shrink();
          } else {
            return getWidgetByInterface(widgetItem!);
          }
        },
      ),
    );
  }

  Widget getWidgetByInterface(RecommendInterface widgetItem) {
    if (widgetItem is SongItem) {
      return _columnBox(SongCard(songItem: widgetItem));
    } else if (widgetItem is ArticleItem) {
      return _columnBox(AritcleCard(articleItem: widgetItem));
    } else if (widgetItem is VideoItem) {
      return _columnBox(VideoCard(videoItem: widgetItem));
    }
    return SizedBox.shrink();
  }

  Widget _columnBox(Widget card) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        card
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
