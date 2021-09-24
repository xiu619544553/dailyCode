import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/pages/discover/discover_child_page.dart';
import 'package:wechat_demo/pages/friends/friend_cell.dart';
import 'package:wechat_demo/pages/friends/index_bar.dart';
import 'friend_data.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {

  /// 字典放 word 和高度的对应数据
  final Map _groupOffSetMap = {
    INDEX_WORDS[0] : 0.0,
    INDEX_WORDS[1] : 0.0,
  };

  /// ListView 的滚动，依赖 ScrollController
  final ScrollController _scrollController = ScrollController();

  /// 用户数据
  final List<Friends> _listDatas = [];

  /// 该方法相当于 init 方法，在这里面处理网络返回的数据
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _listDatas.addAll(friendDatas);
    // _listDatas.addAll(friendDatas);
    // 等同于下面 .. 语法
    // 往数组重复添加，可以使用语法 ..，..表示又拿到了 _listDatas。addAll没有返回值，..能够便于我们操作。
    _listDatas..addAll(friendDatas)..addAll(friendDatas);

    // 排序
    _listDatas.sort((Friends a, Friends b) {
      // String? 不能直接调用 compare，需要借用中间变量
      String as = a.indexLetter ?? '';
      String bs = b.indexLetter ?? '';
      return as.compareTo(bs);
    });

    // 计算每一个分组头部cell 对应的偏移量
    var _groupOffset = 54.5 * 4;
    for (int i = 0; i < _listDatas.length; i ++) {
      String indexLetter = _listDatas[i].indexLetter ?? '';
      if (i < 1) {
        _groupOffSetMap.addAll({indexLetter : _groupOffset});
        _groupOffset += FriendHeaderCellHeight;
      } else {
        String currentIndexLetter = _listDatas[i].indexLetter ?? '';
        String previousIndexLetter = _listDatas[i - 1].indexLetter ?? '';

        if (currentIndexLetter == previousIndexLetter) {
          // 累加没有头部cell的高
          _groupOffset += FriendNoHeaderCellHeight;
        } else {
          _groupOffSetMap.addAll({indexLetter : _groupOffset});
          // 累加有头部cell的高
          _groupOffset += FriendHeaderCellHeight;
        }
      }
    }
  }

  /// 系统cell需要的数据
  final List<Friends> _headerData = [
    Friends(imageUrl: 'images/wc_new_friend.png', name: '新的朋友'),
    Friends(imageUrl: 'images/wc_group_chat_friend.png', name: '群聊'),
    Friends(imageUrl: 'images/wc_tag.png', name: '标签'),
    Friends(imageUrl: 'images/wc_public.png', name: '公众号'),
  ];

  /// 返回cell
  Widget _itemForIndex(BuildContext context, int index) {
    // 系统图标的cell
    if (index < _headerData.length) {
      Friends fd = _headerData[index];
      return FriendCell(imageAsset: fd.imageUrl ?? '', name: fd.name ?? '');
    }

    // 用户样式的cell
    Friends currentFd = _listDatas[index - 4];

    if (index - 4 > 0) {
      // 从 _listDatas 第二个元素开始判断是否需要显示 gruopTitle
      Friends previousFd = _listDatas[index - 5];
      String previousGroupTitle = previousFd.indexLetter ?? '';
      String currentGroupTitle = currentFd.indexLetter ?? '';

      // 如果当前cell的 indexLetter 和上一个cell的indexLetter一样，就不显示groupTitle
      if (previousGroupTitle == currentGroupTitle) {
        return FriendCell(
          imageUrl: currentFd.imageUrl ?? '',
          name: currentFd.name ?? '',
        );
      } else {
        return FriendCell(
          imageUrl: currentFd.imageUrl ?? '',
          name: currentFd.name ?? '',
          groupTitle: currentFd.indexLetter ?? '',
        );
      }
    } else {
      return FriendCell(
        imageUrl: currentFd.imageUrl ?? '',
        name: currentFd.name ?? '',
        groupTitle: currentFd.indexLetter ?? '',
      );
    }
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
      body: Container(
        color: WeChatThemeColor,
        /// 整个页面结构：使用 Stack布局，使得 ListView、悬浮检索控件纵向分布
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              itemBuilder: _itemForIndex, // 返回指定位置的cell
              itemCount: _headerData.length + _listDatas.length, // 指定cell的数量
            ),
            IndexBar(
              indexBarCallBack: (String str) {
                print(str);
                if (_groupOffSetMap[str] != null) {
                  _scrollController.animateTo(_groupOffSetMap[str], duration: Duration(milliseconds: 1), curve: Curves.easeIn);
                }
              },
            ), // 悬浮检索控件
          ],
        ),
      ),
    );
  }
}
