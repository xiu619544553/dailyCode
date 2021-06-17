//
//  main.swift
//  demo_Error
//
//  Created by hello on 2020/8/10.
//  Copyright © 2020 TK. All rights reserved.
/*
 错误处理  https://www.cnswift.org/error-handling
 */

import Foundation


// MARK: 表示和抛出错误
// 在 Swift中，错误表示为遵循 Error 协议类型的值。这个空的协议明确了一个类型可以用于错误处理。
// Swift 枚举是典型的一组相关错误条件建模的完美适配类型，关联值还允许错误通讯携带额外的信息。

/// 比如说，这是你可能会想到的游戏里自动售货机会遇到的错误条件：
enum VendingMachineError: Error {
    /// 无效选项
    case invalidSelection
    /// 资金不足
    case insufficientFunds(coinsNeeded: Int)
    /// 库存不足
    case outOfStock
}


// 抛出一个错误允许你明确某些意外的事情发生了并且正常的执行流不能继续下去。你可以使用 throw 语句来抛出一个错误。比如说，下面的代码通过抛出一个错误来明确自动售货机需要五个额外的金币：
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)


// MARK: 处理错误。在 Swift 中有四种方式来处理错误

func canThrowAndError() throws {
    
}

func test1() {
    do {
        try canThrowAndError()
    } catch {
        
    }
}

struct Item {
    var price: Int
    var count: Int
}

// MARK: VendingMachine
class VendingMachine {
    
    // 存货清单
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels" : Item(price: 7, count: 11)
    ]
    
    // 存款
    var coinsDeposited = 0
    
    // 出售
    func vend(itemNamed name: String) throws {
        // 校验是否有该货品
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        // 校验货品数量
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        // 校验存款是否足够购买
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("条件满足，可以购买 \(name)，花费 \(item.price)。剩余货品 \(newItem.count)个，剩余存款 \(coinsDeposited)")
    }
}

// MARK: 使用抛出函数传递错误

let favoriteSnacks = [
    "Alice" : "Chips",
    "Bob" : "Licorice",
    "Eve" : "Pretzels"
]


func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}


// MARK: 调用测试1
let vending = VendingMachine()
vending.coinsDeposited = 100

/*
buy函数在 try 表达式中调用，因为它会抛出错误。
 * 如果抛出了错误，执行就会立即跳转到 catch 分句，它会决定是向上传递还是继续执行。如果没有模式匹配到，错误就会被最后一个 catch 分句捕获，并且被绑定到本地 error 常量。
 * 如果没有错误抛出，do 分句中剩余的语句就会继续执行。
*/
try buyFavoriteSnack(person: "Eve", vendingMachine: vending)


// MARK: 测试2
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
/*
catch 分句不需要处理 do 分句中所有可能抛出的错误。如果没有 catch 分句处理错误，错误就会向上传递到高层范围。总之，传递的错误必须在某个上层环境中处理掉。在一个不抛出错误的函数中，要么使用 do-catch 语句，要么调用者必须处理错误。如果错误传递到顶层而没有被处理，你就会得到运行时错误。
*/
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}





// MARK: 转换错误为可选项 try?

// MARK: 取消错误传递 try!

// MARK: 指定清理操作 defer
