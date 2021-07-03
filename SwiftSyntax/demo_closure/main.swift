//
//  main.swift
//  demo_closure
//
//  Created by hello on 2021/6/15.
//  Copyright © 2021 TK. All rights reserved.
//  https://www.cnswift.org/closures

/*
 Swift 的闭包表达式拥有简洁的风格，鼓励在常见场景中实现简洁，无累赘的语法。常见的优化包括：
 * 利用上下文推断形式参数和返回值的类型；
 * 简写实际参数名；
 * 尾随闭包语法。？？？？？
 * 单表达式的闭包可以隐式返回；？？？？？
 */

import Foundation

print("====================")

// MARK: sorted 方法
/*
 Swift 的标准库提供了一个叫做 sorted(by:) 的方法，会根据你提供的排序闭包将已知类型的数组的值进行排序。一旦它排序完成， sorted(by:) 方法会返回与原数组类型大小完全相同的一个新数组，该数组的元素是已排序好的。原始数组不会被 sorted(by:) 方法修改。
 */

// 🌰：下面这个闭包表达式的栗子使用 sorted(by:) 方法按字母排序顺序来排序一个 String 类型的数组。这是将被排序的初始数组：
let names1 = ["Z","A","C","D","B"]
let names2 = ["A","B","C","D","E"]

/*
 sorted(by:) 方法接收一个接收两个与数组内容相同类型的实际参数的闭包，然后返回一个 Bool 值来说明第一个值在排序后应该出现在第二个值的前边还是后边。如果第一个值应该出现在第二个值之前，排序闭包需要返回 true ，否则返回 false
 
 这个栗子对一个 String 类型的数组进行排序，因此排序闭包需为一个 (String, String) -> Bool 的类型函数。
 
 提供排序闭包的一个方法是写一个符合其类型需求的普通函数，并将它作为 sorted(by:) 方法的形式参数传入：
 */
func backward(s1: String, s2: String) -> Bool {
    let flag = s1 > s2 // 大于操作符 >，会降序排列
    print("flag:\(flag) s1:\(s1)  s2:\(s2)")
    return flag
}

var reversedNames1 = names1.sorted(by: backward)
print("排序结果1\(reversedNames1)")

print("=======================")
func ascendingOrder(s1: String, s2: String) -> Bool {
    let flag = s1 < s2 // 小于操作符 <，升序
    print("flag:\(flag) s1:\(s1)  s2:\(s2)")
    return flag
}
var reversedNames2 = names2.sorted(by: ascendingOrder)
print("排序结果2\(reversedNames2)")


// MARK: 闭包表达式语法
print("==============\n闭包表达式语法")

/*
 闭包表达式语法有如下的一般形式：
 { (parameters) -> (return type) in
    statements
 }
 */

/*
 闭包表达式语法能够使用常量形式参数、变量形式参数和输入输出形式参数，但不能提供默认值。可变形式参数也能使用，但需要在形式参数列表的最后面使用。元组也可被用来作为形式参数和返回类型。
 
 下面这个栗子展示一个之前 backward(_:_:) 函数的闭包表达版本：
 */
reversedNames1 = names1.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print("\(reversedNames1)")

/*
 需要注意的是行内闭包的形式参数类型和返回类型的声明与 backwards(_:_:) 函数的申明相同。在这两个方式中，都书写成 (s1: String, s2: String) -> Bool。总之对于行内闭包表达式来说，形式参数类型和返回类型都应写在花括号内而不是花括号外面。

 // MARK: in
 闭包的函数整体部分由关键字 in 导入，这个关键字表示闭包的形式参数类型和返回类型定义已经完成，并且闭包的函数体即将开始。
 */

// MARK: in
/*
 闭包的函数整体部分由关键字 in 导入，这个关键字表示闭包的形式参数类型和返回类型定义已经完成，并且闭包的函数体即将开始。
 */

// 闭包的函数体特别短以至于能够只用一行来书写：
reversedNames1 = names1.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
print("闭包的函数体用一行来书写：\(reversedNames1)")
// 示例中 sorted(by:) 方法的整体部分调用保持不变,一对圆括号仍然包裹函数的所有实际参数。然而，这些实际参数中的一个变成了现在的行内闭包。


// MARK: 从语境中推断类型
print("=================\n从语境中推断类型")
/*
 由于排序闭包作为实际参数传递给方法，Swift 就能推断它的形式参数类型和返回类型。 sorted(by:) 方法是在字符串数组上调用的，所以它的形式参数必须是一个 (String, String) -> Bool 类型的函数。这意味着 (String, String)和 Bool 类型不需要写成闭包表达式定义中的一部分。因为所有的类型都能被推断，返回箭头 ( ->) 和围绕在形式参数名周围的括号也能被省略：
 */
reversedNames1 = names1.sorted(by: { s1, s2 in return s1 > s2})
print(reversedNames1)

/*
 当把闭包作为行内闭包表达式传递给函数或方法时，形式参数类型和返回类型都可以被推断出来。所以说，当闭包被用作函数的实际参数时你都不需要用完整格式来书写行内闭包。

 然而，如果你希望的话仍然可以明确类型，并且在读者阅读你的代码时如果它能避免可能存在的歧义的话还是值得的。在这个 sorted(by:) 方法的栗子中，闭包的目的很明确，即排序被替换。对读者来说可以放心的假设闭包可能会使用 String 值，因为它正帮一个字符串数组进行排序。
 */


// MARK: 从单表达式闭包隐式返回
print("=================\n从单表达式闭包隐式返回")

/*
 单表达式闭包能够通过从它们的声明中删掉 return 关键字来隐式返回它们单个表达式的结果，前面的栗子可以写作：
 */
reversedNames1 = names1.sorted(by: { s1, s2 in s1 > s2})
print(reversedNames1)

/*
 这里， sorted(by:) 函数类型的实际参数已经明确必须通过闭包返回一个 Bool 值。因为闭包的结构包含返回 Bool 值的单一表达式 (s1 > s2)，因此没有歧义，  return 关键字可省略。
 */

// MARK: 简写的实际参数名
print("=================\n简写的实际参数名")

/*
 Swift 自动对行内闭包提供简写实际参数名，你也可以通过 $0 , $1 , $2 等名字来引用闭包的实际参数值。

 如果你在闭包表达式中使用这些简写实际参数名，那么你可以在闭包的实际参数列表中忽略对其的定义，并且简写实际参数名的数字和类型将会从期望的函数类型中推断出来。 in  关键字也能被省略，因为闭包表达式完全由它的函数体组成：
 */
reversedNames1 = names1.sorted(by: { $0 > $1})
print(reversedNames1)


// MARK: 运算符函数
print("=================\n运算符函数")

/*
 实际上还有一种更简短的方式来撰写上述闭包表达式。Swift 的 String 类型定义了关于大于号（ >）的特定字符串实现，让其作为一个有两个 String 类型形式参数的函数并返回一个 Bool 类型的值。这正好与  sorted(by:) 方法的第二个形式参数需要的函数相匹配。因此，你能简单地传递一个大于号，并且 Swift 将推断你想使用大于号特殊字符串函数实现：
 */

// MARK: 尾随闭包

