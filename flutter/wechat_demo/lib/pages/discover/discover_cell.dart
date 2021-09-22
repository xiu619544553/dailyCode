import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_child_page.dart';


class DiscoverCell extends StatefulWidget {

  /// 声明属性
  final String? title;
  final String? subTitle;
  final String? imageName;
  final String? subImageName;

  /// 构造函数。此处 this 是赋值的含义。
  DiscoverCell({
    this.title,
    this.subTitle,
    this.imageName,
    this.subImageName
  });

  @override
  _State createState() => _State();
}

class _State extends State<DiscoverCell> {

  Color _currentColor = Colors.white;

  /// 渲染函数
  @override
  Widget build(BuildContext context) {
    /// 给 cell 添加点击事件，用 GestureDetector 包裹住cell视图后，cell 就具备点击事件了
    return GestureDetector(
      /// 点击事件
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  DiscoverChildPage(title: widget.title ?? '')));
        setState(() {
          _currentColor = Colors.white;
        });
      },

      /// 手指按下屏幕
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey;
        });
      },

      /// 取消触摸事件
      onTapCancel: (){
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Container(
        color: _currentColor,
        height: 54.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // left
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image(image: AssetImage(widget.imageName ?? ''), width: 20),
                  SizedBox(width: 15),
                  Text(widget.title ?? ''),
                ],
              ),
            ),

            // right
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(widget.subTitle ?? ''),
                  widget.subImageName != null
                      ? Image(
                    image: AssetImage(widget.subImageName ?? ''),
                    width: 10,
                    height: 10,
                  )
                      : Container(),
                  Image(
                    image: AssetImage('images/wc_right.png'),
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

