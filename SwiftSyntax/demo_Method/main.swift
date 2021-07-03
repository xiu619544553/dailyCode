//
//  main.swift
//  demo_Method
//
//  Created by hello on 2020/8/14.
//  Copyright © 2020 TK. All rights reserved.
//  方法 https://www.cnswift.org/methods

import Foundation

/*
 Swift 与 OC中方法区别：
 
 在 结构体和枚举中定义方法是 Swift 语言与 C 语言和 Objective-C 的主要区别。在 Objective-C 中，类是唯一能定义方法的类型。但是在 Swift ，你可以选择无论类，结构体还是方法，它们都拥有强大的灵活性来在你创建的类型中定义方法。
 */


// MARK: 实例方法 - 点语法调用

// MARK: self 属性

class Counter {
    var count = 0
    func increment() {
        
        /*
         每一个类的实例都隐含一个叫做 self的属性，它完完全全与实例本身相等。你可以使用 self属性来在当前实例当中调用它自身的方法。
         */
        self.count += 1
        
        /*
         实际上，你不需要经常在代码中写 self。如果你没有显式地写出 self，Swift会在你于方法中使用已知属性或者方法的时候假定你是调用了当前实例中的属性或者方法。
         */
        count += 1
    }
    
    
    func decrement(count: Int) -> Bool {
        /*
         对于这个规则的一个重要例外就是当一个实例方法的形式参数名与实例中某个属性拥有相同的名字的时候。在这种情况下，形式参数名具有优先权，并且调用属性的时候使用更加严谨的方式就很有必要了。你可以使用 self属性来区分形式参数名和属性名。
         这时， self就避免了叫做 x 的方法形式参数还是同样叫做 x 的实例属性这样的歧义。
         
         除去 self 前缀，Swift 将会假定两个 count 都是叫做 count 的方法形式参数。
         */
        return self.count > count
    }
}


// MARK: 在实例方法中修改值类型 - 异变

struct Point {
    var x = 0.0, y = 0.0
//    func moveBy1(x deltaX: Double, y deltaY: Double) {
//        // 报错：Left side of mutating operator isn't mutable: 'self' is immutable左边的变化操作符是不可变的:'self'是不可变的
//        x += deltaX
//    }
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

func testMutatingMethod() {
    
    // 变量结构体
    var point = Point(x: 10.0, y: 10.0)
    point.moveBy(x: 20.0, y: 20.0)
    print("x: \(point.x)；y: \(point.y)")
    
    // 常量结构体
//    let constantPoint = Point(x: 20.0, y: 20.0)
    // 不能再常量结构体里调用异变方法，因为自身属性不能被改变，就算它们是变量属性：
//    constantPoint.moveBy(x: 5.0, y: 5.0)
//    print("x: \(point.x)；y: \(point.y)")
}

// 用 struct 定义资料物件型别
struct Cat {
    var name = ""
}


// MARK: 在异变方法里指定自身

// 同结构体 Point
struct MutatingPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        // 异变方法可以指定整个实例给隐含的 self属性
        self = MutatingPoint(x: x + deltaX, y: y + deltaY)
    }
}

// MARK: 枚举异变 - 枚举的异变方法可以设置隐含的 self属性为相同枚举里的不同成员：
enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
            
        case .low:
            self = .high
            
        case .high:
            self = .off
        }
    }
}

// 枚举异变测试
func testEnumMutating() {
    
    var light = TriStateSwitch.low
    
    light.next()
    print(light)
    
    light.next()
    print(light)
}



// MARK: 类型方法
/*
 类型方法的两种实现方法
 1、在 func关键字之前使用 static关键字来明确一个类型方法。子类不可重写。
 2、使用 class关键字来允许子类重写父类对类型方法的实现。
 */

class SomeClass {
    
    // class 类型方法，子类可重写。
    class func aboutClassMethod() {
        print("class --> 类型方法")
        print(self)
        // 类型方法的函数体中，隐含的 self属性指向了类本身而不是这个类的实例。对于结构体和枚举，这意味着你可以使用 self来消除类型属性和类型方法形式参数之间的歧义，用法和实例属性与实例方法形式参数之间的用法完全相同。
    }
    
    // static 类型方法，子类不可重写。
    static func aboutStaticMethod() {
        print("static --> 类型方法")
    }
}

class SomeSubClass: SomeClass {
    
    override class func aboutClassMethod() {
        
    }
}






// 测试异变关键字
testMutatingMethod()

// 枚举异变测试
testEnumMutating()
