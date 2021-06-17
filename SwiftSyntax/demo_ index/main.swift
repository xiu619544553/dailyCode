//
//  main.swift
//  demo_ index
//
//  Created by hello on 2020/8/20.
//  Copyright © 2020 TK. All rights reserved.
//  下标  https://www.cnswift.org/subscripts

/*
 类、结构体和枚举可以定义下标，它可以作为访问集合、列表或序列成员元素的快捷方式。你可使用下标通过索引值来设置或检索值而不需要为设置和检索分别使用实例方法。比如说，用 someArray[index] 来访问 Array 实例中的元素以及用 someDictionary[key] 访问 Dictionary 实例中的元素。

 你可以为一个类型定义多个下标，并且下标会基于传入的索引值的类型选择合适的下标重载使用。下标没有限制单个维度，你可以使用多个输入形参来定义下标以满足自定义类型的需求。
 */

import Foundation

// MARK: 下标的语法
// someArray[index]
// someDictionary[key]

struct TimesTable {
    let multiplier: Int
    
    // 只读
    subscript(index: Int) -> Int {
        return multiplier * index
    }
    
    // 读写：类似于存储属性
    subscript(ele idx: Int) -> Int {
        get {
            return multiplier * idx / 2
        }
        set {
            print("newValue =\(newValue)")
        }
    }
}





func testSubScript() {
    print("...下标")
    
    let times = TimesTable(multiplier: 3)
    print("subscript index = \(times[6])")
    
    print("subscript index = \(times[ele: 6])")
    
    
    print("通过下标语法，访问字典value\n")
    var numberOfLegs = ["spider" : 8, "ant" : 6, "cat" : 5]
    if let temp = numberOfLegs["ant"] {
        print("numberOfLegs[\"ant\"] = \(temp)")
    }
    // 赋值
    numberOfLegs["cat"] = 1000
    if let temp = numberOfLegs["cat"] {
        print("numberOfLegs[\"cat\"] = \(temp)")
    }
    

    print("...下标\n")
}




testSubScript()
