import 'package:flutter/material.dart';

/// StatelessWidget
/// 无状态小部件，在它生命周期内，只会想渲染一次，也就是说 build 只执行一次 。
class StatelessManagerDemo extends StatelessWidget {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateless'),
      ),
      body: Container(
        color: Colors.orange,
        child: Chip(
          label: Text('$count'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          count += 1;
          print(count);
          // count 会自增。但是 页面不会再刷新了
        },
      ),
    );
  }
}

/// StatefulWidget
class StatefulManagerDemo extends StatefulWidget {
  const StatefulManagerDemo({Key? key}) : super(key: key);

  @override
  _StatefulManagerDemoState createState() => _StatefulManagerDemoState();
}

// 状态管理器：专门负责管理 StatefulManagerDemo 的状态。
// 通过泛型 <StatefulManagerDemo> 与 StatefulManagerDemo 类关联起来。
class _StatefulManagerDemoState extends State<StatefulManagerDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateless'),
      ),
      body: Container(
        color: Colors.orange,
        child: Chip(
          label: Text('$count'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          /// 调用该方法，刷新页面
          setState(() {
            // 将要改变的属性等，放到该函数里
            count += 1;
          });
        },
      ),
    );
  }
}
