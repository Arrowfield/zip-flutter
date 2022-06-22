import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/app_colors.dart';
import 'package:flutter_duuchin/utils/user_type.dart';

class AvatarRoleName extends StatelessWidget {
  final String avatar;
  final String nickname;

  final bool showType;
  final String? type;

  final double? avatarSize;

  const AvatarRoleName({
    Key? key,
    required this.avatar,
    required this.nickname,
    required this.showType,
    this.type,
    this.avatarSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _avatar(),
        Offstage(
          offstage: !showType,
          child: _role(),
        ),
        _nickname(),
      ],
    );
  }

  Widget _avatar() {
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/common/lazy-1.png',
          image: avatar,
        ),
      ),
    );
  }

  Widget _role() {
    return Container(
      margin: EdgeInsets.only(left: 6),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: UserType.formColor(type.toString()),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        UserType.formCn(type.toString()),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _nickname() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 6),
        child: Text(
          nickname,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.un3active,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
