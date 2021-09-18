import 'package:flutter/material.dart';
import 'package:wechat_demo/root_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        highlightColor: Color.fromARGB(1, 0, 0, 0), // 高亮颜色，设置为透明色，否则长按 BottomNavigationBarItem 会变色
        splashColor: Color.fromARGB(1, 0, 0, 0),    // BottomNavigationBarItem 点击水波纹效果的颜色，设置为透明色，就可以去掉了
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

