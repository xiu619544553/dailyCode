import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/base_widget.dart';
import 'package:flutter_demo/model/syntax_demo.dart';
import 'model/car.dart';


/// 笔记
/// Scaffold 类似于 UINavigationController
/// Container 类似于 UIView
/// Column 纵向布局
/// row 横向布局
/// Stack 层级布局
/// Container(height: 10,) 可以用来作为容器 ，也可以用来占位设置间距
/// SizedBox(height: 10) 只是占位置。
/// RichText 富文本

/// Dart 中没有析构函数，它是垃圾回收机制


/// 小部件入口
void main() {
  // 自定义页面
  runApp(MaterialApp(
    title: 'Navigation',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: BaseWidgetDemo(),
    ),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.lime,
    ),
  ));
}


/// 简单的测试入口
// main() => testFunc();