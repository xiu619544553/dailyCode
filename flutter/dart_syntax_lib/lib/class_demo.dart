
import 'package:flutter/rendering.dart';

/// 九、面向对象

/// 1、类的基本定义和使用
class Person {
  String name;
  int age;
  double height;

  // dart 初始化方法，不需要写实现，它会自动帮我们实现赋值操作。
  Person(this.name, this.age, this.height);
}

// 继承父类
class Student extends Person {

  // 注意️⚠️：构造函数不被继承。子类不会继承父类的构造函数。 子类不声明构造函数，那么它就只有默认构造函数 (匿名，没有参数) 。

  // 在 Dart里：类名(变量，变量,...) 是构造函数的写法, :super()表示该构造调用父类，这里构造时传入三个参数
  Student(String name, int age, double height, double grade): super(name, age, height);
}

/// 2、类中属性的getter和setter访问器
class Kid {
  String _name;    // 在dart中没有访问权限, 默认_下划线开头变量表示私有权限，外部文件无法访问
  final int _age;  // final修饰的变量只有getter访问器

  // 初始化
  Kid(this._name, this._age);

  // setter
  set name(String name) => _name = name;

  // getter
  bool get isKid => _age <= 6;
}



