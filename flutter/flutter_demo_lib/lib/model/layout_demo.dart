import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Alignment(x, y) 表示x轴、y轴
/// iOS 坐标系的原点在左上角
/// Flutter 坐标系的原点在中心点。Alignment(-1, -1) 左上角。

/// 布局方式有哪些？
/// Center
/// Row      横向布局，x轴
/// Column   纵向布局，y轴
/// Stack    垂直布局，z轴
/// Expanded 填充布局。规则：主轴方向全部填充，不留间隙，小部件会被拉伸。⚠️横向布局包裹在填充布局中，给定宽度就无意义了；纵向布局包裹在填充布局中，给定高度就无意义了。
/// AspectRatio 宽高比布局

/// Row、Column 的主轴和交叉轴讲解
/*
* 关于主轴
* mainAxisAlignment: MainAxisAlignment.x
*
* start       ：将子轴放置在尽可能靠近主轴的位置。
* end         ：将子轴尽可能靠近主轴的末端。
* center      ：让child尽可能靠近主轴的中间位置。
* spaceBetween：子部件左右两边间距为0，把剩余空间均匀地放在子部件之间。
* spaceAround： 在子节点之间均匀地放置空闲空间，并在第一个和最后一个子节点前后分别放置该空间的一半。
* spaceEvenly： 在子节点之间以及第一个和最后一个子节点之前和之后均匀地放置空闲空间。
* */

/*
* 关于交叉轴
* crossAxisAlignment = CrossAxisAlignment.x
*
* start   ：子视图顶部对齐
* end     ：子视图底部对齐
* center  ：子视图中心对齐
* stretch ：要求子结点填充十字轴
* baseline：基线对齐。必须和属性 textBaseline 一起使用。
*
* */

/*
* 文本基线对齐方式 textBaseline
*
* alphabetic  英文字符
* ideographic 中文字符
* */

/// 布局测试入口
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      alignment: Alignment(0.0, 0.0),
      child: AspectDemo(),
    );
  }
}

/// 文字 - 主轴和交叉轴
class TextLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Container(
          color: Colors.red,
          child: Text(
            '测试',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Container(
          color: Colors.blue,
          child: Text(
            '中文',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          color: Colors.purple,
          child: Text(
            '英文',
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

/// 图片 - 主轴
class RowIconLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: Colors.red,
          child: Icon(
            Icons.add,
            size: 120,
          ),
        ),
        Container(
          color: Colors.blue,
          child: Icon(
            Icons.ac_unit,
            size: 60,
          ),
        ),
        Container(
          color: Colors.purple,
          child: Icon(
            Icons.access_alarms,
            size: 30,
          ),
        ),
      ],
    );
  }
}

/// 填充布局
class FillLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            child: Text(
              '测试',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.blue,
          child: Text(
            '中文',
            style: TextStyle(fontSize: 20),
          ),
        )),
        Expanded(
            child: Container(
          color: Colors.purple,
          child: Text(
            '英文',
            style: TextStyle(fontSize: 10),
          ),
        )),
      ],
    );
  }
}

/// Stack布局
/// Stack 没有主轴 和 交叉轴
/// Stack布局中：使用 Positioned 小部件，它专门用来做相对布局。
/// Posotioned布局中的 left/right/top/bottom 是相对于容器 Stack 来说的。内部子部件多大，Stack就有多大。
class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0.0, -1),
      children: [
        Positioned(
          child: Container(
            color: Colors.red,
            width: 200,
            height: 200,
          ),
        ),
        Positioned(
            right: 0,
            child: Container(
              color: Colors.green,
              width: 100,
              height: 100,
            )),
        Positioned(
            left: 0,
            child: Container(
              color: Colors.blue,
              height: 50,
              width: 50,
            )),
      ],
    );
  }
}


/// AspectRatio 宽高比布局
class AspectDemo extends StatelessWidget {
  const AspectDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 300,
      child: AspectRatio(
        aspectRatio: 1/2,
        child: Icon(Icons.add, size:  30),
      ),
    );
  }
}





















