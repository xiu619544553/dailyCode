import 'package:flutter/material.dart';

main() {
  /// 参考：https://zhuanlan.zhihu.com/p/88728224

  ///----------------------------- 二、数据类型

  // 1、布尔类型
  boolDemo();

  // 2、数字类型
  numDemo();

  // 3、字符串类型
  stringQuotes();
  stringUsage();

  // 4、类型检查
  typeChecking();

  // 5、Runes和Symbols类型
  rsDemo();

  // 6、Object类型
  objcDemo();

  // 7、dynamic类型
  dynamicDemo();

  ///----------------------------- 三、变量和常量

  // 1、var关键字
  varDemo();

  // 2、常量（final 和 const）
  finalConstDemo();

  ///----------------------------- 四、集合(List、Set、Map)

  // 1、集合List
  listDemo();
}

///----------------------------- 一、hello world

/// 标准写法
// void main() {
//   runApp(MyApp());
// }

/// 如果函数内部只有一个表达式，可以省略大括号，使用"=>"箭头函数;
// void main() => MyApp());

/// dart中void类型，作为函数返回值类型可以省略
// main() {
//   print('Hello World!');
// }

/// 最简写法
// main() => print('hello world');

/// 第一个冒号是继承。既然是继承，第二个冒号前面的super就是父类，(key:key)就是把子类的key传给父类，冒号表示参数赋值，super构造函数里可能有很多参数，指定参数的意思
/// MyHomePage({Key key, this.title}) : super(key: key);有谁知道这个表达式里的冒号":"是啥意思？

///----------------------------- 二、数据类型

/// 概述
// 在dart中的一切皆是对象，包括数字、布尔值、函数等，它们和Java一样都继承于Object, 所以它们的默认值也就是null.
//  在dart主要有:
//  布尔类型bool、
//  数字类型num（数字类型又分为int，double，并且两者父类都是num）、
//  字符串类型String、
//  集合类型(List, Set, Map)、
//  Runes类和Symbols类型 —— 这两个用的并不多
//  注意⚠️，在dart中没有float, short, long类型

/// 1、布尔类型 bool

boolDemo() {
  print('-----------------------1、布尔类型 bool');
  // dart 声明变量的格式： [类型][变量名]
  bool isClosed = true;
  bool isOpened = false;

  print(isClosed);
  print(isOpened);

  // 输出内容如下
  // flutter: true
  // flutter: false
}

/// 2、数字类型（num、int、double）
// 在dart中num、int、double都是类,然后int、double都继承num抽象类，
numDemo() {
  print('-----------------------2、数字类型（num、int、double）');
  double pi = 3.1415926;
  int width = 100;
  int height = 200;

  print(width / height); // 注意⚠️：两个int类型相除是double类型小数，而不是整除后的整数。
  print(width ~/ height); // 注意⚠️：这才是 dart 整除的正确姿势

  // 常用的函数
  print(pi.toStringAsFixed(3)); // 保留有效数字
  print(6.6.floor()); // 向下取整
  print(-6.6.ceil()); // 向上取整
  print(9.9.ceil()); // 向上取整
  print(666.6.round()); // 四舍五入
  print(666.6.toInt()); // 转换成 int
  print(6.toDouble()); // 转换成 double
  print(666.6.toString()); // 转换成字符串
  print(666.isEven); // 是否是偶数
  print(666.isOdd); // 是否是奇数
  print(666.isNaN); // 是否是数字
}

///  3、字符串类型（String）
// 在Dart中支持单引号、双引号、三引号以及$字符串模板用法

/// 字符串引号使用
stringQuotes() {
  print('-----------------------字符串引号使用');
  String name = 'hello world'; // 单引号
  String title = "Home page"; // 双引号
  String desc = """
    hello dart! hello dart!
    hello dart!
    hello dart? hello dart?
  """; // 三引号

  num val = 2;
  String result = 'The resule is $val';
  num width = 100;
  num height = 200;
  String square = 'The square is ${width * height}'; // 表达式的值引用

  print(name);
  print(title);
  print(desc);
  print(square);
}

/// 字符串常用操作
void stringUsage() {
  print('-----------------------字符串常用操作');
  String url = 'https://mrale.ph/dartvm/';
  print(url.split('://')[0]); // 字符串分割方法，split返回的是字符串数组
  print(url.substring(1, 5)); // 字符串截取
  print(url.codeUnitAt(0)); // 取当前索引位置字符的 UTF-16码

  print(url.startsWith('https')); // 当前字符串是否以指定字符开头
  print(url.endsWith('/')); // 当前字符串是否以指定字符结尾

  print(url.toUpperCase()); // 转大写
  print(url.toLowerCase()); // 转小写

  print(url.indexOf('ph')); // 获取指定字符的索引位置
  print(url.contains('http')); // 字符串是否包含指定字符
  print(url.trim()); // 去除字符串的首尾空格
  print(url.length); // 获取字符串长度
  print(url.replaceFirst('t', 'A')); // 替换第一次出现t字符位置的字符
  print(url.replaceAll('m', 'M')); // 全部替换成指定的字符
}

/// 4、类型检查（is 和 is!）、强制类型转换（as）
// dart是通过 is 关键字来对类型进行检查；如果判断不是某个类型dart中使用 is!
// 使用 as 关键字对类型进行强制转换；

typeChecking() {
  print('-----------------------4、类型检查');
  int number = 100;
  double dis = 10.5;
  num age = 31;

  print(number is num); // true
  print(dis is! int); // true
  print(age as int); // 31
}

/// 5、Runes 和 Symbols 类型
/*
* 在Dart中的Runes和Symbols类型使用并不多，这里做个简单的介绍：
* Runes类型是UTF-32字节单元定义的Unicode字符串，Unicode可以使用数字表示字母、数字和符号，
* 然而在dart中String是一系列的UTF-16的字节单元，所以想要表示32位的Unicode的值，就需要用到Runes类型。
* 我们一般使用\uxxxx这种形式来表示一个Unicode码，xxxx 表示4个十六进制值。
* 当十六进制数据多余或者少于4位时，将十六进制数放入到花括号中，例如，微笑表情（ ）是\u{1f600}。
* 而Symbols类型则用得很少，一般用于Dart中的反射，但是注意在Flutter中禁止使用反射。
* */
rsDemo() {
  var clapping = '\u{1f44f}';
  print(clapping);
  print(clapping.codeUnits); //返回十六位的字符单元数组
  print(clapping.runes.toList());

  Runes input = new Runes(
      '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(new String.fromCharCodes(input));
}

/// 6、Object类型
objcDemo() {
  Object color = 'black';
  color = 0xff000000;
}

/// 7、dynamic类型
/*
* 在Dart中还有一个和Object类型非常类似的类型那就是dynamic类型，下面讲到的var声明的变量未赋值的时候就是dynamic类型， 它可以像Object一样可以改变类型。
* dynamic类型一般用于无法确定具体类型, 注意⚠️: 建议不要滥用dynamic，一般尽量使用Object。
* 如果你对Flutter和Native原生通信PlatformChannel代码熟悉的话，你会发现里面大量使用了dynamic, 因为可能native数据类型无法对应dart中的数据类型,此时dart接收一般就会使用dynamic.
*
* Object和dynamic区别在于: Object会在编译阶段检查类型，而dynamic不会在编译阶段检查类型。
* */

dynamicDemo() {
  print('-----------------------7、dynamic类型');
  dynamic color = 'black';
  color = 0xff000000; // //运行正常，0xff000000类型是int, int也继承于Object
}

///----------------------------- 三、变量和常量

/// 1、var关键字
/*
* 在dart中可以使用var来替代具体类型的声明，会自动推导变量的类型，这是因为var并不是直接存储值，而是存储值的对象引用，所以var可以声明任何变量。
* 注意⚠️: 在Flutter开发一般会经常使用var声明变量，以便于可以自动推导变量的类型。
* */
varDemo() {
  print('-----------------------1、var关键字');

  varBasicUsage();

  varAttention();
}

//  基础用法
varBasicUsage() {
  int colorValue = 0xff000000;
  var colorKey = 'black'; // var声明变量，自动根据赋值的类型，推导出String类型
  print(colorKey is String);

  // 使用 var 声明集合变量
  var colorList = ['red', 'yellow', 'blue', 'green', 'red'];
  print(colorList);

  // set中不可以出现重复元素
  var colorSet = {'red', 'yellow', 'blue'};
  print(colorSet);

  // 类似oc中的字典
  var colorMap = {'white': 0xffffffff, 'black': 0xff000000};
  print(colorMap);
}

// var 注意事项
// 使用var声明变量的时候，需要注意的是: 如果var声明的变量开始不初始化，不仅值可以改变它的类型也是可以被修改的，但是一旦开始初始化赋值后，它的类型就确定了，后续不能被改变。
varAttention() {
  var color; // 仅有声明未赋值 ，变量color的类型是 dynamic，所以它的类型是可变的
  color = 'red';
  print(color is String); // true

  color = 0xffff0000;
  print(color is int); // true

  var colorValue =
      0xffff0000; // var 修饰的变量声明且赋值了，则 colorValue 的类型已经推导出为 int，即确定了类型
  // colorValue = 'red'; // ❌报错，抛出编译异常。
  print(colorValue is int);
}

/// 2、常量（final 和 const）
/*
* 在dart中声明常量可以使用const或final 两个关键字
* 这两者的区别在于：
* 如果常量是编译期就能初始化的就用const
* 如果常量是运行时期初始化的就用final(有点类似Kotlin中的val)
* */

finalConstDemo() {
  print('-----------------------2、常量（final 和 const）');
  const PI = 3.14;
  final nowTime = DateTime.now();
  print(nowTime);
}

///----------------------------- 四、集合(List、Set、Map)

/// 1、集合List
// Dart整个集合类型系统，没有区分可变集合和不变集合，在使用方式上它更像是数组，可以随意对元素增删改查。

listDemo() {
  print('-----------------------1、集合List');

  // List 初始化方式
  listInitStyle();

  // List 常用函数
  listCommonFunction();

  // List 的遍历方式
  listTraverse();
}

// List 初始化方式
listInitStyle() {
  List<String> colorList1 = ['red', 'green', 'blue'];
  var colorList2 = <String>['red', 'green', 'blue'];

  print(colorList1);
  print(colorList2);
}

// List 常用函数
listCommonFunction() {
  List<String> colorList = ['red', 'green', 'blue'];
  colorList.add('white'); // 添加元素
  print(colorList[0]); // 直接使用数组下标形式访问元素
  print(colorList.length); // 获取集成的元素个数

  colorList.insert(1, 'purple'); // 在集合指定位置插入元素
  colorList.removeAt(2); // 移除集成指定位置的元素
  print(colorList.sublist(0, 1)); // 截图子集合
  print(colorList.getRange(1, 2)); // 获取集合中某个范围的元素
  print(colorList
      .join('-->')); // 每个元素之间添加特定字符，并转为字符串。输出结果：red-->purple-->blue-->white
  print(colorList.isEmpty); // 集合是否为空
  colorList.clear(); // 清空集成
  print(colorList); // 输出内容：[]
}

// List 的遍历方式
listTraverse() {
  // for-i 遍历
  print('=======for-i 遍历');
  List<String> colorList = ['red', 'green', 'blue'];
  for(int i = 0; i < colorList.length; i++) {
    print(colorList[i]);
  }

  // for-each 遍历
  print('=======for-each 遍历');
  colorList.forEach((element) => print(element));

  // for-in 遍历
  for(var color in colorList) {
    print(color);
  }

  // while + iterator 迭代器遍历
  // print('=======while + iterator 迭代器');
  // while(colorList.iterator.moveNext()) {
  //   print(colorList.iterator.current);
  // }
}
