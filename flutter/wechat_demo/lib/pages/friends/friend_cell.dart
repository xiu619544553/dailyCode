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
      } else {
        return AssetImage(imageAsset ?? '');
      }
    }

    return Column(
      children: [
        Container( // 头像+昵称部分
          color: Colors.white,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 34,
                height: 34,
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
          height: 0.5,
          color: WeChatThemeColor,
          margin: EdgeInsets.only(left: 54),
        ),
      ],
    );
  }
}
