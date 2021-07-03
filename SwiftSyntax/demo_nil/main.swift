//
//  main.swift
//  demo_nil
//
//  Created by hello on 2020/8/10.
//  Copyright © 2020 TK. All rights reserved.
//

import Foundation

func test() {
    
    /*
     nil 不能用于非可选的常量或者变量，如果你的代码中变量或常量需要作用于特定条件下的值缺失，可以给他声明为相应类型的可选项。
     */
    
    var serverCode: Int? = 404
    // 你可以通过给可选变量赋值一个 nil 来将之设置为没有值：
    serverCode = nil
    if serverCode != nil {
        print(serverCode!)
    }
    
    /*
     注意：如果你定义的可选变量没有提供一个默认值，变量会被自动设置成 nil
     */
    class Person {
        var name: String?
        var age: Int?
    }
    
    let person = Person()
    if person.name != nil {
        print("person.name: \(person.name!)")
    }
    
    print("person.age: \(String(describing: person.age))")
    
    /*
     注意

     Swift 中的 nil 和Objective-C 中的 nil 不同
     * Objective-C 中 nil 是一个指向不存在对象的指针。
     * Swift中，nil 不是指针，他是值缺失的一种特殊类型，任何类型的可选项都可以设置成 nil，而不仅仅是对象类型。
     */
}


test()
