//
//  main.swift
//  demo_Optional
//
//  Created by hello on 2020/8/12.
//  Copyright © 2020 TK. All rights reserved.
//  可选项

import Foundation

/*
 可以利用可选项来处理值可能缺失的情况。可选项意味着：
 1、这里有一个值，他等于x
 2、这里根本没有值
 
 注意
 * C 和 Objective-C 中，没有可选项的概念。在 Objective-C 中有一个近似的特性，一个方法可以返回一个对象或者返回 nil 。 nil 的意思是“缺少一个可用对象”。然而，他只能用在对象上，却不能作用在结构体，基础的 C 类型和枚举值上。对于这些类型，Objective-C 会返回一个特殊的值（例如 NSNotFound ）来表示值的缺失。这种方法是建立在假设调用者知道这个特殊的值并记得去检查他。
 * Swift 中的可选项就可以让你知道任何类型的值的缺失，他并不需要一个特殊的值。
 */

func testOptional() {
    
    let possibleNumber = "123"
    let convertedNumber = Int(possibleNumber)
    // 注意：如果 convertedNumber 为 nil，解包会 crash
    // 使用 ! 来获取一个不存在的可选值会导致运行错误，在使用!强制展开之前必须确保可选项中包含一个非 nil 的值。
    print("将 String 转换为 Int：\(convertedNumber!)")
    
    // 字符串 转换为 Int
    let str1 = "a123"
    let strToNumber = Int(str1)
    // 如果字符串不是数字类型，强制解包，会造成 crash
//    print(strToNumber!)
    // 使用 if let，避免 crash
    if let tempStr = strToNumber {
        print(tempStr)
    } else {
        print("strToNumber 为 nil")
    }
    
    
    // 如果一个可选有值，他就 ≠ nil
    if strToNumber != nil {
        // 确保可选值不为 nil，则可以强制展开
        print(strToNumber!)
    }
}


func optionalHasValue() {
 
    /*
     判断可选值是否有值的几种方式
     
     1、判断 可选值 != nil
     2、使用 if let
     */
    let possibleNumber = "123"
    let convertedNumber = Int(possibleNumber)
    
    // 1、
    if convertedNumber != nil {
        print(convertedNumber!)
    }
    
    // 2、可选项绑定
    if let actualNumber = convertedNumber {
        // 早已被可选内部的值进行了初始化，所以这时就没有必要用 ! 后缀来获取里边的值。在这个栗子中 actualNumber 被用来输出转换后的值。
        print(actualNumber)
    }
    
    // 3、可选项绑定。如果你想操作 if 语句中第一个分支的 changeValue 的值，你可以写 if var actualNumber 来代替，可选项内部包含的值就会被设置为一个变量而不是常量
    if var changeValue = convertedNumber {
        print(changeValue)
        print("if var un changeValue: \(changeValue)")
        changeValue = 100
        print("if var changeValue: \(changeValue)")
    }
    
    // 4、可选绑定条件也可以是多个，用逗号分隔
    if let num = convertedNumber, num > 100 {
        print("num > 100")
    }
}

// 隐式展开可选项
func testOptional2() {
    
    let assumeString: String! = "An implicitly unwrapped optional string"
    
    // 不要在一个变量将来会变为 nil 的情况下使用隐式展开可选项。如果你需要检查一个变量在生存期内是否会变为 nil ，就使用普通的可选项。


}


testOptional()
optionalHasValue()


