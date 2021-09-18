


class Person {
  // final修饰属性，属性赋值后不可变了。节约性能。
  // final String? name;

  // [类型]? 将其声明为可选类型，否则编译报错
  // String? name;

  // 用 const修饰构造函数，能够节约性能
  // 使用条件：成员变量都是 final修饰的，构造函数才可以使用 const 修饰
  // const Person(this.age, {this.name});

  // {this.name} 使用花括号包裹成员变量 name，标识该成员变量是可选参数


  String? name;
  String? nickName;

  /// 构造函数
  Person(this.name, {this.nickName});


  /// 命名构造函数
  Person.fromList(List<dynamic> list) {
    name = list[0];
    nickName = list[1];
  }

  /// 重定向构造函数。this() 表示重定向到 Person(this.name, {this.nickName});。
  Person.defaults(String name, String nickName): this(name, nickName: nickName);
}


/// 测试
testFunc() {

  // 使用构造函数
  // 注意⚠️：必传参数可以不写形参，可选参数必须写形参
  Person p1 = Person('Alex', nickName: '坦克');
  print('\nname: ${p1.name ?? ''}、\nnickName: ${p1.nickName ?? ''}');

  // 使用命名构造函数
  Person p2 = Person.fromList(['Tank', 'Alex']);


  // 重定向构造函数
  Person p3 = Person.defaults('alex', '坦克');

}