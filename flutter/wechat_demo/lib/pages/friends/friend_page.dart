import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/pages/discover/discover_child_page.dart';
import 'package:wechat_demo/pages/friends/friend_cell.dart';
import 'friend_data.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final List<Friends> _headerData = [
    Friends(imageUrl: 'images/wc_new_friend.png', name: '新的朋友'),
    Friends(imageUrl: 'images/wc_group_chat_friend.png', name: '群聊'),
    Friends(imageUrl: 'images/wc_tag.png', name: '标签'),
    Friends(imageUrl: 'images/wc_public.png', name: '公众号'),
  ];

  Widget _itemForIndex(BuildContext context, int index) {
    // 系统图标的cell
    if (index < _headerData.length) {
      Friends fd = _headerData[index];
      return FriendCell(imageAsset: fd.imageUrl ?? '', name: fd.name ?? '');
    }

    // 用户样式的cell
    Friends fd = friendDatas[index - 4];
    return FriendCell(imageUrl: fd.imageUrl ?? '', name: fd.name ?? '',);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 导航栏背景色
        backgroundColor: WeChatThemeColor,

        /// 设置导航栏文字
        title: Text(
          '通讯录',
          style: TextStyle(color: Colors.black),
        ),

        /// 给导航栏添加按钮
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(
                  image: AssetImage('images/wc_add_friend.png'), width: 30),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverChildPage(
                        title: '添加好友',
                      )));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: _itemForIndex, // 返回指定位置的cell
        itemCount: _headerData.length + friendDatas.length, // 指定cell的数量
      ),
    );
  }
}
