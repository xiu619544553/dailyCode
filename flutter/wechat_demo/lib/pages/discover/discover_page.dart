
import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_cell.dart';

class DiscoverPage extends StatefulWidget {

  Color _themeColor = Color.fromRGBO(220, 220, 220, 1.0);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget._themeColor,  // widget 代表 DiscoverPage 对象。如果该变量不会发生变化，也可以在该对象中声明。
        // 以下三个属性，是为了适配Android
        centerTitle: true,
        title: Text(
            '发现',
            style: TextStyle(
                color: Colors.black
            )
        ),
        elevation: 0.0, // 没有底部的边栏
      ),
      body: Container(
        color: widget._themeColor,
        child: ListView(
          children: [
            DiscoverCell(
              imageName: 'images/wc_session.png',
              title: '朋友圈',
            ),
            SizedBox(height: 10), // 间距
            DiscoverCell(
              imageName: 'images/wc_scan_blue.png',
              title: '扫一扫',
            ),
            Row( // 分割线
              children: [
                Container(
                  width: 40,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                )
              ],
            ),
            DiscoverCell(
              imageName: 'images/wc_shake.png',
              title: '摇一摇',
            ),
            SizedBox(height: 10),
            DiscoverCell(
              imageName: 'images/wc_look_look.png',
              title: '看一看',
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                )
              ],
            ),
            DiscoverCell(
              imageName: 'images/wc_search_search.png',
              title: '搜一搜',
            ),
            SizedBox(height: 10),
            DiscoverCell(
              imageName: 'images/wc_near_person.png',
              title: '附近的人',
            ),
            SizedBox(height: 10),
            DiscoverCell(
              imageName: 'images/wc_buy.png',
              title: '购物',
              subTitle: '618限时特价',
              subImageName: 'images/wc_badge.png',
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                )
              ],
            ),
            DiscoverCell(
              imageName: 'images/wc_games.png',
              title: '游戏',
            ),
            SizedBox(height: 10),
            DiscoverCell(
              imageName: 'images/wc_mini_app.png',
              title: '小程序',
            ),
          ],
        ),
      ),
    );
  }
}
