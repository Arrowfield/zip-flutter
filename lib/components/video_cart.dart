import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/article_card.dart';
import 'package:flutter_duuchin/components/avatar_role_name.dart';
import 'package:flutter_duuchin/components/comment_like_read.dart';
import 'package:flutter_duuchin/config/app_colors.dart';
import 'package:flutter_duuchin/models/video_model.dart';
import 'package:flutter_duuchin/utils/util.dart';

const double paddingSize = 20;
const double spaceSize = 10;

class VideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const VideoCard({Key? key, required this.videoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(
            height: paddingSize,
          ),
          _cover(),
          SizedBox(
            height: paddingSize,
          ),
          _bottom(),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      videoItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.active,
      ),
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/common/lazy-2.png",
              image: videoItem.coverPictureUrl
                  .replaceFirst("https", "http"), // https握手失败
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/icons/play_plus.png",
              width: 48,
              height: 48,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                secondToTime(videoItem.contentSeconds),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvatarRoleName(
            avatar: videoItem.user.coverPictureUrl,
            nickname: videoItem.user.nickname,
            type: videoItem.user.type,
            showType: true,
          ),
        ),
        Expanded(
          child: CommentLikeRead(
            commentCount: videoItem.commentCount,
            thumbUpCount: videoItem.thumbUpCount,
            readCount: videoItem.readCount,
          ),
        ),
      ],
    );
  }
}
