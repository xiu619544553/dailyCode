
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/char_page.dart';
import 'package:wechat_demo/pages/discover_page.dart';
import 'package:wechat_demo/pages/friend_page.dart';
import 'package:wechat_demo/pages/mine_page.dart';


class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _currentIndex = 0;
  List<Widget> _pages = [
    ChatPage(),
    FriendPage(),
    DiscoverPage(),
    MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // onTap 是 bottom 的点击事件，会回调当前点击的下标
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        selectedFontSize: 12.0,              // 设置 BottomNavigationBarItem 的选中时字体大小
        unselectedFontSize: 12.0,            // 设置 BottomNavigationBarItem 的未选中时字体大小
        currentIndex: _currentIndex,         // 设置选中的下标
        fixedColor: Colors.green,            // 选中颜色
        type: BottomNavigationBarType.fixed, // 定义[BottomNavigationBar]的布局和行为。
        items: [
          BottomNavigationBarItem(
            label: '微信',
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: '通讯录',
            icon: Icon(Icons.bookmark),
          ),
          BottomNavigationBarItem(
            label: '发现',
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            label: '我',
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

