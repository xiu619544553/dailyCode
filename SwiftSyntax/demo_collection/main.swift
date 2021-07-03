//
//  main.swift
//  demo_collection
//
//  Created by hello on 2020/8/24.
//  Copyright © 2020 TK. All rights reserved.
//  集合类型  https://www.cnswift.org/collection-types#spl-22
//  Swift 的 Array类型被桥接到了基础框架的 NSArray类上。Cocoa 和 Objective-C 一起使用 https://developer.apple.com/documentation/swift#2984801
//  Swift提供的集合类型：数组、字典、合集

import Foundation


/*
 let 集合：不可变集合，它的内容和大小都不可变
 var 集合：可变集合，可以CRUD
 
 在集合不需要改变的情况下创建不可变集合是个不错的选择。这样做可以允许 Swift 编译器优化你创建的集合的性能。


 */


func testArray() {
    print("...数组...")
    
    // Swift 数组 Array是结构体 struct
    
    // Swift 数组的类型完整写法是 Array<Element>
    // 不可变数组
    let someInts = Array<Int>.init()
    print(someInts)
    
    // 推荐写法
    // 可变数组
    var numbers = [Int]()
    numbers.append(10)
    numbers.append(2)
    print("numbers.count = \(numbers.count)")
    
    var strings = [String]()
    strings.append("name")
    strings.append("age")
    print("emptyArray = \(strings)")
    
    
    // MARK: 使用默认值创建数组
    // Swift 的 Array类型提供了初始化器来创建确定大小且元素都设定为相同默认值的数组。你可以传给初始化器对应类型的默认值（叫做 repeating）和新数组元素的数量（叫做 count）：
    var threeDoubles = Array(repeating: 0.0, count: 10)
    print("threeDoubles.count = \(threeDoubles.count)")
    print("threeDoubles = \(threeDoubles)")
    threeDoubles.append(1.1)
    print("threeDoubles.count = \(threeDoubles.count)")
    print("threeDoubles = \(threeDoubles)")

    threeDoubles[0] = 0.9
    print("threeDoubles.count = \(threeDoubles.count)")
    print("threeDoubles = \(threeDoubles)")
    
    let number2s = Array(repeating: 2.6, count: 3)
    
    let newArray = threeDoubles + number2s
    print("\nnewArray:\(newArray.count)   \n数组内元素：\(newArray)")
    
    
    
    // MARK: 数组字面量
    var shopList: [String] = ["Eggs", "Milk"]
    
    
    // MARK: 访问和修改数组
    
    // 数组只读属性：count
    
    // 使用布尔量 isEmpty属性来作为检查 count属性是否等于 0的快捷方式：
    if shopList.isEmpty {
        print("shopList is empty")
    } else {
        print("shopList is not empty")
    }
    
    // 数组末尾添加元素：append
    shopList.append("Cat")
    print("\n append 使用：shopList: \(shopList)")
    
    // +=
    shopList += ["Dog"]
    print("\n +=使用：shopList: \(shopList)")
    
    // 下标脚本语法 取值
    print("shopList[0] = \(shopList[0])")
    
    // 下标脚本 修改值
    shopList[0] = "Eggggg"
    print("\n 修改值: shopList[0] = \(shopList[0])")
    
    #warning("你不能用下标脚本语法来追加一个新元素到数组的末尾!!!")
    
    
    // 插入
    shopList.insert("INSERT", at: 1)
    print("\n insert 使用：shopList: \(shopList)")
    
    // 移除
    shopList.remove(at: 1)
    print("\n remove 使用：shopList: \(shopList)")
    
    
    /*
     注意越界问题：
     
     如果你访问或者修改一个超出数组边界索引的值，你将会触发运行时错误。你可以在使用索引前通过对比数组的 count属性来检查它。除非当 count为 0（就是说数组为空），否则最大的合法索引永远都是 count - 1，因为数组的索引从零开始。
     */
    
    
    // for-in 遍历数组
    for item in shopList {
        print("item: \(item)  ")
    }
    
    print("\n")
    // enumerated() 遍历数组，可以知道每个元素的索引
    for (index, value) in shopList.enumerated() {
        print("Item \(index + 1): \(value)")
    }
    
    print("...数组...\n")
}


/*
 合集将同一类型且不重复的值无序地储存在一个集合当中。
 当元素的顺序不那么重要的时候你就可以使用合集来代替数组，或者你需要确保元素不会重复的时候，可以使用 Set。

 注意：Swift 的 Set类型桥接到了基础框架的 NSSet类上。
 OC 与 Swift使用：https://developer.apple.com/documentation/swift#2984801
 */
func testSet() {
    print("...Set...")
    
    
    /*
    什么类型的数据可以放到 Set 中？
    
     为了能让类型储存在合集当中，它必须是可哈希的——就是说类型必须提供计算它自身哈希值的方法。哈希值是Int值且所有的对比起来相等的对象都相同，比如 a == b，它遵循 a.hashValue == b.hashValue。
     
     所有 Swift 的基础类型（比如 String, Int, Double, 和 Bool）默认都是可哈希的，并且可以用于合集或者字典的键。没有关联值的枚举成员值（如同枚举当中描述的那样）同样默认可哈希。
     
     */
    
    // 创建空合集
    var letter = Set<Character>()
    print("letter.count = \(letter.count)")
    
    // 插入
    letter.insert("a")
    print("letter = \(letter)")
    
    // 语法糖
    letter = []
    print("letter = \(letter)")
    
    // 数组字面量
    var favs: Set<String> = ["A", "B", "20"]
    print("favs = \(favs)")
    
    
    // 编译器根据类型推断
    var ages: Set = [10, 20, 30, 6, 90, 1]
    print("ages = \(ages)")
    
    
    // 访问和修改
    // 数量 count
    // 使用 isEmpty 属性作为检查 count 属性是否为 0的快捷方式
    if ages.isEmpty {
        print("age is emtpy")
    } else {
        print("age is not empty")
    }
    
    // 插入
    ages.insert(100)
    print("insert 使用：ages = \(ages)")
    
    // 删
    let removeEle = ages.remove(11)
    if let temp = removeEle {
        print("要删除的元素存在，element = \(temp)")
    } else {
        print("要删除的元素不存在，返回返回 nil")
    }
    
    // 删除 Set中所有元素
//    ages.removeAll()
    
    // 校验 Set是否包含某元素
    if ages.contains(5) {
        print("age 有 5这个元素")
    } else {
        print("age 没有 5这个元素")
    }
    
    
    
    // 遍历
    for num in ages {
        print("num = \(num)")
    }
    
    // Swift 的 Set类型是无序的。要以特定的顺序遍历合集的值，使用 sorted()方法，它把合集的元素作为使用 < 运算符排序了的数组返回。
    for num in ages.sorted() {
        print("num = \(num)")
    }
    
    
    /*
     使用 intersection(_:)方法来创建一个只包含两个合集共有值的新合集；
     使用 symmetricDifference(_:)方法来创建一个只包含两个合集各自有的非共有值的新合集；
     使用 union(_:)方法来创建一个包含两个合集所有值的新合集；
     使用 subtracting(_:)方法来创建一个两个合集当中不包含某个合集值的新合集。
     */
    
    let oddDigits: Set = [1, 3, 5, 7, 9]
    let evenDigits: Set = [0, 2, 4, 6, 8]
    let sigleDigitPrimeNumbers: Set = [2, 3, 5, 7]
    
    print("并集 + 排序 = \(oddDigits.union(evenDigits).sorted())")
    print("共有 + 排序 = \(oddDigits.intersection(evenDigits).sorted())")
    print("A集合 - AB共有的 + 排序 = \(oddDigits.subtracting(sigleDigitPrimeNumbers).sorted())")
    
    print("A集合+B集合-AB共有 + 排序")
    
    
    /*
     使用“相等”运算符 ( == )来判断两个合集是否包含有相同的值；
     使用 isSubset(of:) 方法来确定一个合集的所有值是被某合集包含；
     使用 isSuperset(of:)方法来确定一个合集是否包含某个合集的所有值；
     使用 isStrictSubset(of:) 或者 isStrictSuperset(of:)方法来确定是个合集是否为某一个合集的子集或者超集，但并不相等；
     使用 isDisjoint(with:)方法来判断两个合集是否拥有完全不同的值。
     let houseAnimals: Set = ["🐶", "🐱"]
     let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
     let cityAnimals: Set = ["🐦", "🐭"]
      
     houseAnimals.isSubset(of: farmAnimals) // true
     farmAnimals.isSuperset(of: houseAnimals) // true
     farmAnimals.isDisjoint(with: cityAnimals) // true
     */
    
    print("...Set...\n")
}


// MARK: 字典
func testDictionary() {
    print("...字典...")

    /*
     Swift 的字典类型写全了是这样的： Dictionary<Key, Value>，其中的 Key是用来作为字典键的值类型， Value就是字典为这些键储存的值的类型。
     简写：[Key: Value]
     
     注意：Swift 的 Dictionary桥接到了基础框架的 NSDictionary类。
     
     注意：字典的 Key类型必须遵循 Hashable协议，就像合集的值类型。
     所有 Swift 的基础类型（比如 String, Int, Double, 和 Bool）默认都是可哈希的，并且可以用于合集或者字典的键。没有关联值的枚举成员值（如同枚举当中描述的那样）同样默认可哈希。
     */
    
    // MARK: 初始化器创建字典
    var simpleDict = [Int : String]()
    
    // 添加
    simpleDict[1] = "One"
    print("simpleDict = \(simpleDict)")
    
    // 清空字典
    simpleDict = [:]
    print("simpleDict = \(simpleDict)")
    
    
    // MARK: 字典字面量创建字典
    // 使用 var 声明为可变字典，方便后续操作
    var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    print("airports = \(airports)")
    
    
    // MARK: 访问和修改
    
    print("airports.count = \(airports.count)")
    
    // isEmpty 检查字典 count 是否等于0的一种快捷方式
    if airports.isEmpty {
        print("airports is empty")
    } else {
        print("airports is not empty")
    }
    
    // 增
    airports["One"] = "Number"
    
    // 改
    airports["One"] = "SINGLE"
    
    // updateValue(_:forKey:)方法会在键没有值的时候设置一个值，或者在键已经存在的时候更新它。总之，不同于下标脚本
    // updateValue(_:forKey:)方法在执行更新之后返回旧的值。这允许你检查更新是否成功。如果没有旧值，则返回nil。
    let oldValue = airports.updateValue("VVVVVV", forKey: "KKKK")
    print("airports = \(airports)")
    print("oldValue = \(String(describing: oldValue))") // oldValue = nil
    
    
    // updateValue(_:forKey:)方法返回一个字典值类型的可选项值。比如对于储存 String值的字典来说，方法会返回 String?类型的值，或者说“可选的 String”。这个可选项包含了键的旧值如果更新前存在的话，否则就是 nil：
    if let oldValue = airports.updateValue("OOOOO", forKey: "WWWW") {
        print("The old value was \(oldValue)")
    } else {
        print("old value was nil")
    }
    
    
    // 可以使用下标脚本语法来从字典的特点键中取回值。由于可能请求的键没有值，字典的下标脚本返回可选的字典值类型。如果字典包含了请求的键的值，下标脚本就返回一个包含这个键的值的可选项。否则，下标脚本返回 nil ：
    if let airportName = airports["WWWW"] {
        print("airport name is \(airportName)")
    } else {
        print("airport name is nil")
    }
    
    // 删 一：可以使用下标脚本语法给一个键赋值 nil来从字典当中移除一个键值对：
    airports["APL"] = "Apple International"
    airports["APL"] = nil
    
    // 删 二：使用 removeValue(forKey:)来从字典里移除键值对。这个方法移除键值对如果他们存在的话，并且返回移除的值，如果值不存在则返回 nil：
    if let removedValue = airports.removeValue(forKey: "WWWW") {
        print("removed value was \(removedValue)")
    } else {
        print("要删除的 key，没有对应的 value")
    }
    
    
    // 遍历字典
    for (key, value) in airports {
        print("\(key) : \(value)")
    }
    
    
    // 可以通过访问字典的 keys和 values属性来取回可遍历的字典的键或值的集合
    for airportCode in airports.keys {
        print("Airport code: \(airportCode)")
    }
     
    for airportName in airports.values {
        print("Airport name: \(airportName)")
    }
    
    
    // 如果你需要和接收 Array实例的 API 一起使用字典的键或值，就用 keys或 values属性来初始化一个新数组：
    let airportKeys = [String](airports.keys)
    let airportValue = [String](airports.values)
    
    
    
    print("=======================")
    // Swift 的 Dictionary类型是无序的。要以特定的顺序遍历字典的键或值，使用键或值的 sorted()方法。
    for key in airports.keys.sorted() {
        
        if let value = airports[key] {
            print("\(key) : \(value)")
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    print("...字典...\n")
}


testArray()
testSet()
testDictionary()
