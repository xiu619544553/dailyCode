//
//  main.swift
//  demo_Tuple
//
//  Created by hello on 2020/8/12.
//  Copyright © 2020 TK. All rights reserved.
//
//  元组

import Foundation

func testTuple() {
    
    // 任何类型的排列都可以被用来创建一个元组
    let http404Error = (404, "Not Found")
    
    // 1、将元组内容分解成单独的常量或变量
    let (statusCode, statusMessage) = http404Error
    
    // 使用拆解后的变量
    print("code is \(statusCode)")
    print("message is \(statusMessage)")
    
    // 2、当你分解元组的时候，如果只需要使用其中的一部分数据，不需要的数据可以用下滑线（ _ ）代替
    let (code, _) = http404Error
    print("2、code is \(code)")
    
    // 3、也可以通过下标获取元组中的单独元素。索引从0开始
    print(http404Error.0)
    print(http404Error.1)
    
    // 4、可以在定义元组的时候给其中的单个元素命名
    let http200Status = (statusCode: 200, desc: "OK")
    print(http200Status.statusCode)
    print(http200Status.desc)
    
    // 元组作为函数返回值时，非常有用
    
    print(http200Status)
}

testTuple()


