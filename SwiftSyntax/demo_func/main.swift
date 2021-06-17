//
//  main.swift
//  demo_func
//
//  Created by hello on 2020/8/13.
//  Copyright © 2020 TK. All rights reserved.
//  函数 https://www.cnswift.org/functions

import Foundation

// MARK: 有参数 有返回值
// age: 形式参数，返回值 Int
func test1(age: Int) -> Int {
    return age
}

// MARK: 无参数无返回值
 
func test2() {

    /*
     注意
     严格来讲，函数 greet(person:)还是有一个返回值的，尽管没有定义返回值。没有定义返回类型的函数实际上会返回一个特殊的类型 Void。它其实是一个空的元组，作用相当于没有元素的元组，可以写作 () 。
     */
}

// MARK: 多返回值函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

// 返回的元组是可选的
func minMaxOptionalTuple(array: [Int]) -> (min: Int, max: Int)? {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

// 元组中的某个属性是可选的
func minMaxOptionalElement(array: [Int]) -> (min: Int, max: Int?) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

// MARK: 隐式返回的函数
func greeting(for person: String) -> String {
    "Hellow, " + person + "!"
}

func anotherGreeting(for person: String) -> String {
    return "Hellow, " + person + "!"
}


// MARK: 实际参数 形参
/*
 from to 是实际参数
 place1、place2 是形式参数
 */
func travel(from place1: String, to place2: String) {
    print("从 \(place1)出发，目的地是\(place2)")
}

// MARK: 省略实际参数标签 如果对于函数的形式参数不想使用实际参数标签的话，可以利用下划线（ _ ）来为这个形式参数代替显式的实际参数标签。
func sum(_ firstParamaterNumber: Int, secondParameterNumber: Int) -> Int {
    firstParamaterNumber + secondParameterNumber
}

// MARK: 默认形式参数
func someFunction(parameterWithDefault: Int = 12) -> Int {
    if parameterWithDefault <= 12 {
        return 12
    }
    return parameterWithDefault
}



func testMethod() {
    
    let (min, max) = minMax(array: [2, 4, 1, 7, 6, 8, 3, 10])
    
    print("min = \(min)")
    print("max = \(max)")
    
    
    
    
    
}




testMethod()
