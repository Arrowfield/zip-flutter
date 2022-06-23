import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar_role_name.dart';
import 'package:flutter_duuchin/components/comment_like_read.dart';
import 'package:flutter_duuchin/config/app_colors.dart';
import 'package:flutter_duuchin/models/article_model.dart';
import 'package:flutter_duuchin/utils/util.dart';

class AritcleCard extends StatefulWidget {
  final ArticleItem articleItem;

  AritcleCard({
    Key? key,
    required this.articleItem,
  }) : super(key: key);

  @override
  State<AritcleCard> createState() => _AritcleCardState();
}

const double paddingSize = 20;
const double spaceSize = 10;

class _AritcleCardState extends State<AritcleCard> {
  late double boxSize;

  @override
  Widget build(BuildContext context) {
    boxSize = MediaQuery.of(context).size.width - paddingSize * 2;
    return Container(
      padding: EdgeInsets.all(paddingSize),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(
            height: paddingSize,
          ),
          _getCoverByType(),
          SizedBox(
            height: paddingSize,
          ),
          _bottom(),
        ],
      ),
    );
  }

  // 一张的话 显示1种

  int _getTypeByLength() {
    int length = widget.articleItem.coverUrlList.length;
    int coverType;
    switch (length) {
      case 2:
        coverType = getRandomRangeInt(2, 3);
        break;
      case 3:
        coverType = getRandomRangeInt(4, 7);
        break;
      case 4:
        coverType = 8;
        break;
      default:
        coverType = 1;
        break;
    }
    return coverType;
  }

  Widget _getCoverByType() {
    int coverType = _getTypeByLength();
    Widget _coverWidget;

    // 1 显示一张的样式
    // 2 3 显示两种不用的2张样式
    // 4 5 6 7 显示3张不同的样式
    // 8 显示4张的样式
    switch (coverType) {
      case 2:
        _coverWidget = _cover2();
        break;
      case 3:
        _coverWidget = _cover3();
        break;
      case 4:
        _coverWidget = _cover4();
        break;
      case 5:
        _coverWidget = _cover5();
        break;
      case 6:
        _coverWidget = _cover6();
        break;
      case 7:
        _coverWidget = _cover7();
        break;
      case 8:
        _coverWidget = _cover8();
        break;
      default:
        _coverWidget = _cover();
    }
    return _coverWidget;
  }

  // 2 张图片 竖着的 样式

  Widget _cover2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  // 3 张图片 竖着的 样式

  Widget _cover3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(
          height: spaceSize,
        ),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  Widget _cover4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(
              height: spaceSize,
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cover5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              height: spaceSize,
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  Widget _cover6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          height: spaceSize,
        ),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  Widget _cover7() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(
          height: spaceSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cover8() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          height: spaceSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      widget.articleItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.active,
      ),
    );
  }

  Widget _cover({int index = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/common/lazy-1.png",
        image: widget.articleItem.coverUrlList[index]
            .replaceFirst("https", "http"), // https握手失败
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvatarRoleName(
            avatar: widget.articleItem.user.coverPictureUrl,
            nickname: widget.articleItem.user.nickname,
            type: widget.articleItem.user.type,
            showType: true,
          ),
        ),
        Expanded(
          child: CommentLikeRead(
            commentCount: widget.articleItem.commentCount,
            thumbUpCount: widget.articleItem.thumbUpCount,
            readCount: widget.articleItem.readCount,
          ),
        ),
      ],
    );
  }
}
