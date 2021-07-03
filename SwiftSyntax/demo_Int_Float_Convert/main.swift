//
//  main.swift
//  demo_Int_Float_Convert
//
//  Created by hello on 2020/8/10.
//  Copyright © 2020 TK. All rights reserved.
//  整数和浮点数转换


import Foundation

// 整数和浮点数转换
func test1 () {
    let three = 3
    let point3 = 0.3
    let point5 = 0.5
    let point6 = 0.6
    
    // 整数和浮点数类型的转换必须显式地指定类型
    let result1 = Double(three) + point3
    let result2 = Double(three) + point5
    let result3 = Double(three) + point6
    
    // 在用浮点数初始化一个新的整数类型的时候，数值会被截断，只取整数部分，小数部分舍弃
    // 3.3 变成 3
    // 3.6 变成 3
    // -3.9 变为 -3
    let result4 = Int(result1)
    let result5 = Int(result2)
    let result6 = Int(result3)
    let result7 = Int(-3.9)

    print("result1=\(result1)")
    print("result2=\(result2)")
    print("result3=\(result3)")

    print("result4=\(result4)")
    print("result5=\(result5)")
    print("result6=\(result6)")
    print("result7=\(result7)")
    
    // 向下取整
    print(floor(result1))
    print(floor(result2))
    print(floor(result3))
    print(floor(-3.9))
    
    // 向上取整
    print(ceil(result1))
    print(ceil(result2))
    print(ceil(result3))
    print(ceil(-3.9))
    
    typealias Feet = Int
    let distance: Feet = 100
    print(distance)
}

func testAlias() {
    typealias AudioSample = UInt16
    
    // 等同于调用 UInt16.min
    var maxAmp = AudioSample.min
    
    maxAmp = 100
    
    print(maxAmp)
}


test1()
testAlias()
