//
//  main.swift
//  demo_Array
//
//  Created by hello on 2020/8/12.
//  Copyright © 2020 TK. All rights reserved.
//

import Foundation

func test() {
    let numbers = [2, 3, 5, 7]
    var numbersIterator = numbers.makeIterator()
    while let num = numbersIterator.next() {
        print(num)
    }
}



test()

