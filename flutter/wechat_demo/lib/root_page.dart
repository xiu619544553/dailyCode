
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/char_page.dart';
import 'package:wechat_demo/pages/discover/discover_page.dart';
import 'package:wechat_demo/pages/friends/friend_page.dart';
import 'package:wechat_demo/pages/mine_page.dart';


class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _currentIndex = 1;
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
            icon: Image.asset('images/tabbar_chat.png', height: 20, width: 20),          // 未选中状态icon
            activeIcon: Image.asset('images/tabbar_chat_hl.png', height: 20, width: 20), // 选中状态的icon
          ),
          BottomNavigationBarItem(
            label: '通讯录',
            icon: Image.asset('images/tabbar_friends.png', height: 20, width: 20),
            activeIcon: Image.asset('images/tabbar_friends_hl.png', height: 20, width: 20),
          ),
          BottomNavigationBarItem(
            label: '发现',
            icon: Image.asset('images/tabbar_discover.png', height: 20, width: 20),
            activeIcon: Image.asset('images/tabbar_discover_hl.png', height: 20, width: 20),
          ),
          BottomNavigationBarItem(
            label: '我',
            icon: Image.asset('images/tabbar_mine.png', height: 20, width: 20),
            activeIcon: Image.asset('images/tabbar_mine_hl.png', height: 20, width: 20),
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

