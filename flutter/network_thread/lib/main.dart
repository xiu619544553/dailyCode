

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 异步不一定是多线程。

/*
Dart中的异步编程——Future、async和await
https://mp.weixin.qq.com/s/Tb0yyT2xPXizDUu1KjsiOA
*/

String _str = '';

void main() {

  // 1、Future使用
  // getData();

  // 2、多Future
  // testFuture1();

  // 3、3、多Future。then 比 Future默认的队列优先级高。通过 then 解决任务互相依赖的问题。
  // testFuture2();

  // print('做其他事情');

  // 4、多任务，依赖关系
  // testFuture3();

  // 5、事件循环队列
  // testFuture4();

  // 6、面试题：优先级测试
  // testFuture5();

  // 7、面试题：事件循环
  // testFuture6();

  // 8、Isolate
  // testFuture7();

  // 9、Compute
  testFuture8();
}


/// 1、Future 使用
void getData() async {

  print('开始');

  /// 1、后面的操作必须是异步的，会可以用 wait

  /// 方式一
  // // Future 回调中的函数，会异步执行
  // Future future = Future(() {
  //   // 耗时函数
  //   for (int i = 0; i < 1000000; i ++) {
  //     _str = i.toString();
  //     // return '这是耗时操作返回的数据'; // 此处必须 return 或者 使用箭头函数
  //     throw Exception('网络异常');
  //   }
  //
  //   print('结束：$_str');
  // });
  //
  // // 使用 then 接收数据
  // future.then((value) {
  //   print('future返回数据：${value}');
  // }, onError: (e) {
  //   print(e.toString());
  // });
  //
  // // 处理错误
  // future.catchError((error) {
  //   print('捕获到了异常：${error}');
  // });


  /// 方式二【推荐】
  // 先 them，后catchError
  Future(() {

    // 耗时函数
    for (int i = 0; i < 1000000; i ++) {
      _str = i.toString();
      // return '这是耗时操作返回的数据'; // 此处必须 return 或者 使用箭头函数
      throw Exception('网络异常');
    }

    print('结束：$_str');
  }).then((value) { // 处理数据
    print('future返回数据：${value}');
  }).catchError((error) { // 捕获异常
    print('捕获到了异常：${error}');
  }).whenComplete(() {
    print('结束了');
  });
}


/// 2、多Future
void testFuture1() {

  Future(() {
    sleep(Duration(seconds: 2));
    return '任务1';
  }).then((value) => print('value: ${value}'));

  Future(() => '任务2').then((value) => print('value: ${value}'));
  Future(() => '任务3').then((value) => print('value: ${value}'));

  print('任务添加完毕');

  /*
  输出日志如下：
  flutter: 任务添加完毕
  flutter: 做其他事情
  flutter: value: 任务1
  flutter: value: 任务2
  flutter: value: 任务3
  */
  // 结论：Future任务执行完毕的顺序，与添加顺序是一致的
}


/// 3、多Future。then 比 Future默认的队列优先级高。通过 then 解决任务互相依赖的问题。
void testFuture2() {
  Future(() => '任务1').then((value) {
    print('value: ${value}');
    return '任务4'; // then 比 Future默认的队列优先级高。通过 then 解决任务互相依赖的问题。then返回值也是 Future
  }).then((value) => print('value: ${value}'));

  Future(() => '任务2').then((value) => print('value: ${value}'));
  Future(() => '任务3').then((value) => print('value: ${value}'));

  print('任务添加完毕');

  /*
  输出日志：
  flutter: 任务添加完毕
  flutter: 做其他事情
  flutter: value: 任务1
  flutter: value: 任务4
  flutter: value: 任务2
  flutter: value: 任务3
  * */
}

/// 4、依赖关系
void testFuture3() {

  List<Future> futures = [
    Future(() => '任务1'),
    Future(() => '任务2')
  ];
  
  // then 会在 任务1、2执行完后，再执行。
  Future.wait(futures).then((value) {
    print(value[0] + value[1]);
  });
}

/// 5、事件循环队列
void testFuture4() {
  print('外部代码1');

  // Future在事件循环队列
  Future(() => print('A')).then((value) => print('A结束'));
  Future(() => print('B')).then((value) => print('B结束'));

  // 微任务队列
  scheduleMicrotask(() {
    print('微任务');
  });
  
  print('外部代码2'); // 外部代码优先级最高，比队列中任务优先级高
}

/// 6、面试题：优先级
void testFuture5() {

  Future x = Future(() => print('1'));  // 事件队列
  Future(() => print('2'));             // 事件队列

  scheduleMicrotask(() => print('3'));  // 微任务队列
  x.then((value) => print(4));          // then

  print('5');                           // 外部代码

  /*
  输出结果如下：
  5、外部任务，优先级最高
  3、微任务队列，优先级高于Future
  1、Future事件循环队列，按照加入的顺序执行，1先执行
  4、then 任务优先级高于 Future默认队列优先级
  2、最后执行最后加入的Future
  * */
}

/// 7、面试题：事件循环
void testFuture6() {

  Future x = Future(() {
    print('1');
    scheduleMicrotask(() {
      print('2');
    });
  }).then((value) {
    print('3');
  });
  Future(() => print('4'));

  scheduleMicrotask(() => print('5'));
  x.then((value) => print('6'));

  print('7');

  /*
  输出结果如下：
  7、外部任务，优先级最高
  5、微任务队列，优先级高于Future
  1、事件循环到此处，输出1，然后创建微任务；
  3、立即执行 then
  6、立即执行 then
  2、下一个事件循环，先查看是否有微任务，如果有，先执行微任务
  4、最后执行最后加入的 Future
  */
}


/// 8、Isolate，用来处理数据
/// 参考：https://blog.csdn.net/rd_w_csdn/article/details/103735205
/// Isolate 与线程不同，Isolate 不共享内存，不需要考虑多线程资源抢夺的问题
/*
每个 Isolate 都有自己的事件循环
每个「Isolate」都拥有自己的「事件循环」及队列（MicroTask 和 Event）。
这意味着在一个 Isolate 中运行的代码与另外一个 Isolate 不存在任何关联。

多亏了这一点，我们可以获得并行处理的能力。
* */
void testFuture7() {
  print("main isolate start");

  create_isolate();

  print("main isolate end");
}


// 创建一个新的 isolate
void create_isolate() async {
  ReceivePort rp = new ReceivePort();
  SendPort port1 = rp.sendPort;

  Isolate newIsolate = await Isolate.spawn(doWork, port1);

  SendPort? port2;
  rp.listen((message){
    print("main isolate message: $message");
    if (message[0] == 0) {
      port2 = message[1];
    } else {
      port2?.send([1,"这条信息是 main isolate 发送的"]);
    }
  });
}

// 处理耗时任务
void doWork(SendPort port1){
  print("new isolate start");
  ReceivePort rp2 = new ReceivePort();
  SendPort port2 = rp2.sendPort;

  rp2.listen((message){
    print("doWork message: $message");
  });

  // 将新isolate中创建的SendPort发送到主isolate中用于通信
  port1.send([0, port2]);

  // 模拟耗时5秒
  sleep(Duration(seconds:5));
  port1.send([1, "doWork 任务完成"]);

  print("new isolate end");
}


/// 9、Compute
/// 专门做多线程，Isolate上层封装
void testFuture8() async {
  print("外部代码1");

  int result = await compute(testFuture8_1, 10);
  print('result = $result');

  // 模拟耗时5秒
  sleep(Duration(seconds:2));

  print("外部代码2");
}

int testFuture8_1(int count) {
  print('count = $count');
  return 666;
}