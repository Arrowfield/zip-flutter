import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar_role_name.dart';
import 'package:flutter_duuchin/components/comment_like_read.dart';
import 'package:flutter_duuchin/models/video_model.dart';

class TinyVideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const TinyVideoCard({
    Key? key,
    required this.videoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _cover(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AvatarRoleName(
            avatar: videoItem.user.coverPictureUrl,
            nickname: videoItem.user.nickname,
            showType: true,
            type: videoItem.user.type,
            // avatarSize: 25,
          ),
        ),
        CommentLikeRead(
          commentCount: videoItem.commentCount,
          readCount: videoItem.readCount,
          thumbUpCount: videoItem.thumbUpCount,
        ),
      ],
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/common/lazy-3.png",
              image: videoItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/icons/play_plus.png",
              width: 38,
              height: 38,
            ),
          )
        ],
      ),
    );
  }
}
