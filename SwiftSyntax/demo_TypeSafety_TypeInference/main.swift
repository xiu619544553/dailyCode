//
//  main.swift
//  demo_TypeSafety_TypeInference
//
//  Created by hello on 2020/8/7.
//  Copyright © 2020 TK. All rights reserved.
//
/*
 类型安全和类型推断
 
 Swift 是一门类型安全的语言。类型安全的语言可以让你清楚地知道代码可以处理的值的类型。如果你的一部分代码期望获得 String ，你就不能错误的传给它一个 Int 。
 */

import Foundation

func testMethod() {
    // 常量设定一个 10 的字面量，Swift 会推断这个常量类型是 Int
    let meaningOfLife = 10
    print(type(of: meaningOfLife)) // 推断类型：Int
    
    // 如果你没有为一个浮点值的字面量设定类型，Swift 会推断你想创建一个 Double
    // Swift 在推断浮点值的时候始终会选择 Double （而不是 Float ）。
    let pi = 3.14159
    print(type(of: pi)) // 推断类型：Double
    
    let anotherPi = 3 + 0.14159
    print(type(of: anotherPi))
}

