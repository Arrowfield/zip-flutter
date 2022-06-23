import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_duuchin/components/article_card.dart';
import 'package:flutter_duuchin/components/singer_card.dart';
import 'package:flutter_duuchin/components/song_card.dart';
import 'package:flutter_duuchin/models/article_model.dart';
import 'package:flutter_duuchin/models/song_model.dart';
import 'package:flutter_duuchin/models/user_model.dart';
import 'package:flutter_duuchin/services/article_service.dart';
import 'package:flutter_duuchin/services/song_service.dart';
import 'package:flutter_duuchin/services/user_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with AutomaticKeepAliveClientMixin {
  // 获取数据

  final EasyRefreshController _easyRefreshController = EasyRefreshController();

  List<ArticleItem> _articleList = ArticleList([]).list;

  int page = 1;
  int limit = 10;

  bool hasMore = true;

  bool error = false;

  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    _getArticles();
  }

  Future _getArticles({bool push = false}) async {
    try {
      print("开始发送请求");
      Map<String, dynamic> result = await ArticleService.getArticles(
        page: page,
      );

      //print("获取到的数据是$result");

      ArticleList articleListModel = ArticleList.fromJson(result['data']);

      setState(() {
        hasMore = page * limit < result['total'];
        page++;

        if (push) {
          _articleList.addAll(articleListModel.list);
        } else {
          _articleList = articleListModel.list;
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
    await _getArticles();
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getArticles(
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
        itemCount: _articleList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 8,
              ),
              AritcleCard(articleItem: _articleList[index]),
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
