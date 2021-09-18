

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 测试 push、pop 跳转

// void main() {
//   // runApp(MyApp());
//
//   // 自定义页面
//   runApp(MaterialApp(
//     title: 'Navigation',
//     home: FirstScreen(),
//   ));
// }

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar( // 导航条
          title: Text('First Screen'),
        ),
        body: Center(
          child: Text('Launch new Screen'),
        ),
      ),
    );
  }

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('First Screen'),
  //     ),
  //     body: Center(
  //       child: ElevatedButton(
  //         child: Text('Launch new screen'),
  //         onPressed: () {
  //           // 跳转到第二个页面
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => SecondScreen())
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}


class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go back~"),
          onPressed: () {
            // 返回第一页面
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}