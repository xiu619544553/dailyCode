//
//  main.swift
//  demo_Constants_Variables
//
//  Created by hello on 2020/8/7.
//  Copyright © 2020 TK. All rights reserved.
//  常量和变量

import Foundation

// MARK: 常量和变量
func constantOrVarSummary() {
    // 常量和变量必须在使用前被声明
    
    // 常量
    // 优点：代码更安全、简洁；常量的值一旦设置好便不能再被更改
    let name = "Tank"
    print(name)
    
    
    // 变量
    var currentIndex = 10
    currentIndex -= 1
    print(currentIndex)
    
    
    // 类型标注
    // 加类型标注的方法是在变量或常量的名字后边加一个冒号，再跟一个空格，最后加上要使用的类型名称。
    let height: Float = 10.05
    print(height)
    
    // 你可以在一行中定义多个相关的变量为相同的类型，用逗号分隔，只要在最后的变量名字后边加上类型标注。
    var red, green, blue: Double
    red = 23.12
    green = 20.26
    blue = 21.17
    print(red, green, blue)
    
    // 注意
    // 实际上，你并不需要经常使用类型标注。如果你在定义一个常量或者变量的时候就给他设定一个初始值，那么 Swift 就像类型安全和类型推断中描述的那样，几乎都可以推断出这个常量或变量的类型。在上面 welcomeMessage 的栗子中，没有提供初始值，所以 welcomeMessage 这个变量使用了类型标注来明确它的类型而不是通过初始值的类型推断出来的。
    
    
    let bank: String = "ACBC"
    print("银行的名字是\(bank)")
}

constantOrVarSummary()


