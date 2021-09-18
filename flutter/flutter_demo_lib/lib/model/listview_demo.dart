import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/car.dart';

class ListViewDemo extends StatelessWidget {
  // Dart中，下划线表示私有。私有属性、私有方法，外部无法访问。
  Widget _cellForRow(BuildContext context, int index) {
    // [类型]? 解包方式 ?? ''
    var name = datas[index].name ?? '';
    var imageUrl = datas[index].imageUrl ?? '';

    return Container(
      color: Colors.greenAccent,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(imageUrl),
          Container(
            height: 10,
          ), // Text 和 Image 的间距
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
              fontStyle: FontStyle.values[1],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: datas.length, // itemCount 返回列表item个数
      itemBuilder: _cellForRow, // 指定回调函数
    );
  }
}
