import 'package:flutter/material.dart';

import '../../const.dart';

/// 悬浮检索控件
class IndexBar extends StatefulWidget {
  /// 将当前选中的 word，回调给外部
  final void Function(String str) indexBarCallBack;

  /// 初始化
  IndexBar({required this.indexBarCallBack});

  @override
  _IndexBarState createState() => _IndexBarState();
}

/// 获取当前选中的 word
int getIndex(BuildContext context, Offset globalPosition) {
  RenderBox box = context.findRenderObject() as RenderBox;
  box.globalToLocal(globalPosition);

  // 手指所在y坐标
  double y = box.globalToLocal(globalPosition).dy;

  // 计算每一个 word 的高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;

  // 算出当前是第几个 word
  // clamp 函数，给定index范围，防止越界
  int index = (y ~/ itemHeight).clamp(0, INDEX_WORDS.length - 1);

  return index;
}

class _IndexBarState extends State<IndexBar> {
  Color _textColor = Colors.black;
  Color _backgroundColor = Color.fromRGBO(1, 1, 1, 0);

  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {
    /// 悬浮检索控件数据
    List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(fontSize: 10, color: _textColor),
      )));
    }

    return Positioned(
        right: 0,
        height: ScreenHeight(context) / 2,
        top: ScreenHeight(context) / 8,
        width: 120,
        child: Row(
          children: [
            /// 气泡：显示当前选中的word
            Container(
              // 根据 Alignment.y 调整气泡的位置
              alignment: Alignment(0, _indicatorY),
              width: 100,
              child: _indicatorHidden
                  ? null
                  : Stack(
                      // 根据 Alignment.y 调整文字的位置
                      alignment: Alignment(-0.2, 0),
                      children: [
                        Image(
                          image: AssetImage('images/wc_word_bubble.png'),
                          width: 60,
                        ),
                        Text(
                          _indicatorText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        )
                      ],
                    ), // 气泡
            ),

            /// 索引条
            GestureDetector(
              child: Container(
                width: 20,
                color: _backgroundColor,
                child: Column(
                  children: words,
                ),
              ),

              /// 点击进入手势
              onVerticalDragDown: (DragDownDetails details) {
                // print('当前点击的位置：${details.globalPosition}');

                // 当前选中的 word 的索引
                int index = getIndex(context, details.globalPosition);

                setState(() {
                  _backgroundColor = Color.fromRGBO(1, 1, 1, 0.5);
                  _textColor = Colors.white;

                  _indicatorText = INDEX_WORDS[index];
                  // 2.2是 Alignment.y 的变化范围的差值：-1.1 ~ 1.1
                  _indicatorY = 2.2 / INDEX_WORDS.length * index - 1.1;
                  _indicatorHidden = false;
                });

                // 回调给外部
                widget.indexBarCallBack(INDEX_WORDS[index]);
              },

              /// 拖拽手势
              onVerticalDragUpdate: (DragUpdateDetails details) {
                // print('当前手势所在的位置：${details.globalPosition}');

                int index = getIndex(context, details.globalPosition);

                setState(() {
                  _indicatorText = INDEX_WORDS[index];
                  // 2.2是 Alignment.y 的变化范围的差值：-1.1 ~ 1.1
                  _indicatorY = 2.2 / INDEX_WORDS.length * index - 1.1;
                  _indicatorHidden = false;
                });

                // 回调给外部，当前选中的 word
                widget.indexBarCallBack(INDEX_WORDS[index]);

                // print('当前选中的是：${word}');
              },

              /// 手松开
              onVerticalDragEnd: (DragEndDetails details) {
                setState(() {
                  _backgroundColor = Color.fromRGBO(1, 1, 1, 0);
                  _textColor = Colors.black;
                  _indicatorHidden = true;
                });
              },
            )
          ],
        ));
  }
}

/// 悬浮检索控件数据
const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
