
import 'package:flutter/cupertino.dart';

/// 函数
/// Dart 是一门真正面向对象的语言， 甚至其中的函数也是对象，并且有它的类型 Function 。
/// 这也意味着函数可以被赋值给变量或者作为参数传递给其他函数。 也可以把 Dart 类的实例当做方法来调用。


List<String> colors =  ['red', 'green'];
bool isRedColor(int index) {
  if (colors.length <= index)  {
    return false;
  }
  return colors[index] != null;
}

/// 省略了函数返回值类型，函数依旧可以正常使用：
isRedColor2(int index) {
  if (colors.length <= index)  {
    return false;
  }
  return colors[index] != null;
}


/// 函数只有一句表达式，可以使用 => 语法
// => expr 语法是 { return expr; } 的简写。=> 符号，有时也被称为 `箭头` 语法
// 提示⚠️： 在箭头 (=>) 和分号 (;) 之间只能使用一个 表达式 ，不能是 语句 。 例如：不能使用 if 语句 ，但是可以是用 条件表达式.
// 函数有两种参数类型: required 和 optional。 required 类型参数在参数最前面， 随后是 optional 类型参数。 命名的可选参数也可以标记为 “@ required” 。


/// 可选参数
// 可选参数可以是命名参数或者位置参数，但一个参数只能选择其中一种方式修饰。

/// 命名可选参数

// const Scrollbar({Key key, @required Widget child})
// 此时 Scrollbar 是一个构造函数， 当 child 参数缺少时，分析器会提示错误。




