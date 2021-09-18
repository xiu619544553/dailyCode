

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// MyApp，用于展示
class TextDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RichTextDemo();
  }

}

///==========================================================================================
/// 富文本小部件
class RichTextDemo extends StatelessWidget {
  const RichTextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '《静夜思》',
        style: TextStyle(
            fontSize: 30,
            color: Colors.black
        ),
        children: [
          TextSpan(
            text: '床前明月光，疑是地上霜。举头望明月，低头思故乡。',
            style: TextStyle(
              fontSize: 17,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}

/// Text小部件 - 相当于 UILabel
class TextDemo2 extends StatelessWidget {

  // 文字样式
  final TextStyle _style = TextStyle(
    fontSize: 18,
  );

  final String _title = '静夜思';
  final String _lector = '李白';

  @override
  Widget build(BuildContext context) {
    return Text(
      '《${_title}》———— ${_lector}\n床前明月光，疑是地上霜。举头望明月，低头思故乡。床前明月光，疑是地上霜。举头望明月，低头思故乡。床前明月光，疑是地上霜。举头望明月，低头思故乡。',
      textAlign: TextAlign.center,
      style: _style,
      maxLines: 4, // 设置最多显示行数
      overflow: TextOverflow.ellipsis, // 多余的显示省略号
    );
  }
}

///==========================================================================================


class BaseWidgetDemo extends StatelessWidget {
  const BaseWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            color: Colors.red,
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
































