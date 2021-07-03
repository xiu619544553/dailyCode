//
//  main.swift
//  demo_Class_Struct
//
//  Created by hello on 2020/8/7.
//  Copyright © 2020 TK. All rights reserved.
//  类和结构体 https://www.cnswift.org/classes-and-structures#spl-6

import Foundation

// MARK: class 与 struct
func clsOrStructSummary() {
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x = 3
        var y = 4
    }
    
    var size = Size()
    print("size变量的地址", Mems.ptr(ofVal: &size))
    print("size变量的内容", Mems.memStr(ofVal: &size))
    
    var point = Point(x: 3, y: 5)
    print("point变量的地址", Mems.ptr(ofVal: &point))
    print("point变量的内容", Mems.memStr(ofVal: &point))
    
    
    let s = MemoryLayout.stride(ofValue: size)
    print("s: \(s)")
}

// MARK: - MemoryLayout 一种类型的内存布局，描述其大小、步长和对齐方式
func memoryLayoutSummary() {
    struct Coordinates {
        let x: Double
        let y: Double
        let isFilled: Bool
    }
    
    let coor = Coordinates(x: 2.0, y:3.0 , isFilled: true)
    
    let coorSize = MemoryLayout.size(ofValue: coor) // 返回给定实例的连续内存占用
    let coorStride = MemoryLayout.stride(ofValue: coor) // T 所占的内存
    let coorAlignment = MemoryLayout.alignment(ofValue: coor) // T 默认内存对齐方式
    
    print("coorSize: \(coorSize)")
    print("coorStride: \(coorStride)")
    print("coorAlignment: \(coorAlignment)")
}
