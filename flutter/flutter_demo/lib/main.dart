import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/test_push_pop.dart';

void main() {

  // 自定义页面
  runApp(MaterialApp(
    title: 'Navigation',
    home: FirstScreen(),
  ));
}



// 自定义 Widget
class EACustomButton extends StatelessWidget {
  final String label;

  EACustomButton(this.label);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}


