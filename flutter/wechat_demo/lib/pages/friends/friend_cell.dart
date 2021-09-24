import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';

class FriendCell extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? groupTitle;
  final String? imageAsset;

  const FriendCell(
      {this.imageUrl, this.name, this.groupTitle, this.imageAsset});

  @override
  Widget build(BuildContext context) {

    // 头像
    ImageProvider _getAvatar() {

      if (imageUrl != null) {
        return NetworkImage(imageUrl ?? '');
      }
      return AssetImage(imageAsset ?? '');
    }

    // 索引部分的高度
    double _groupTitleHeight() {
      if (groupTitle == null) {
        return 0;
      }
      return FriendIndexBarHeight;
    }

    // 布局
    return Column(
      children: [
        Container( // 索引部分
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: _groupTitleHeight(),
          color: WeChatThemeColor,
          child: Text(groupTitle ?? ''),
        ),
        Container( // 头像+昵称部分
          color: Colors.white,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(FriendAvatarMargin),
                width: FriendAvatarHeight,
                height: FriendAvatarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: _getAvatar()),
                ),
              ), // 头像
              Container(
                child: Text(
                  name ?? '',
                  style: TextStyle(fontSize: 17),
                ),
              ), // 昵称
            ],
          ),
        ),
        Container( // 分割线
          child: Row(
            children: [
              Container(
                height: FriendCellLineHeight,
                width: 54,
                color: Colors.white,
              ),
              Container(
                height: FriendCellLineHeight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
