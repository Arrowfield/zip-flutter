import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_duuchin/components/singer_card.dart';
import 'package:flutter_duuchin/components/song_card.dart';
import 'package:flutter_duuchin/models/article_model.dart';
import 'package:flutter_duuchin/models/song_model.dart';
import 'package:flutter_duuchin/models/user_model.dart';
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

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  List<ArticleItem> _articleList = ArticleList([]).list;

  int page = 1;
  int limit = 10;

  bool hasMore = true;

  bool error = false;

  String errorMsg = "";

  Future _getUsers({bool push = false}) async {
    try {
      print("开始发送请求");
      Map<String, dynamic> result = await UserService.getUsers(
        page: page,
      );

      print("获取到的数据是$result");

      ArticleList userListModel = ArticleList.fromJson(result['data']);

      setState(() {
        hasMore = page * limit < result['total'];
        page++;

        if (push) {
          _singerList.addAll(userListModel.list);
        } else {
          _singerList = userListModel.list;
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
    await _getUsers();
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getUsers(
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

      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    super.build(context);
    return GridView.builder(
      itemCount: _singerList.length,
      itemBuilder: (BuildContext context, int index) {
        bool isEven = index.isEven;
        double pl = isEven ? 18 : 9;
        double pr = isEven ? 9 : 18;
        return Container(
          padding: EdgeInsets.only(top: 18, left: pl, right: pr),
          color: Colors.white,
          child: SingerCard(
            coverPictureUrl: _singerList[index].coverPictureUrl,
            nickname: _singerList[index].nickname,
            musicCount: _singerList[index].musicCount,
            musicPlayCount: _singerList[index].musicPlayCount,
          ),
        );
      },
      padding: EdgeInsets.only(top: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: MediaQuery.of(context).size.width / 1.5,
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 1,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
