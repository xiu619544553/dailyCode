//
//  main.swift
//  demo_String_Substring
//
//  Created by hello on 2020/8/12.
//  Copyright © 2020 TK. All rights reserved.
//  字符串和字符 https://www.cnswift.org/strings-and-characters
//  Unicode 标量值 (Scalar Value) http://www.unicode.org/versions/Unicode13.0.0/ch03.pdf#G7404

import Foundation

// MARK: String
func stringSummary() {
    print("================String================")
    
    // MARK: 字符串字面量
    let something = "some string literal value"
    print("'something' is \(something)")
    
    
    // MARK: 多行字符串字面量
    let quotation = """
    The White Rabbit put on his spectacles.  "Where shall I begin,
    please your Majesty?" he asked.
     
    "Begin at the beginning," the King said gravely, "and go on
    till you come to the end; then stop."
    """
    print(quotation)
    
    // 多行字符串字面量把所有行包括在引号内。字符串包含第一行开始于引号标记（ """ ）并结束于末尾引号标记之前，也就是说下面的字符串的开始或者结束都不会有换行符：
    let signalLine = """
    单行单行
    """
    print(signalLine)
    
    
    
    let multipleLine = """
    离离原上草，一岁一枯荣。
    野火烧不尽，春风吹又生。
    """
    print(multipleLine)
    
    
    // 多行字符串，添加换行的两种方式
    // 方式一：直接回车，添加换行
    // 方式二：\n
    print("开始========")
    let lineBreak = """

    离离原上草，一岁一枯荣。\n
    野火烧不尽，春风吹又生。

    """
    print(lineBreak)
    print("结束========")
    
    
    
    // MARK: 字符串字面量里的特殊字符
    /*
     转义特殊字符 \0 (空字符)， \\ (反斜杠)， \t (水平制表符)， \n (换行符)， \r(回车符)， \" (双引号) 以及 \' (单引号)；
     任意的 Unicode 标量，写作 \u{n}，里边的 n是一个 1-8 个与合法 Unicode 码位相等的16进制数字。
     */
    let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
    // "Imagination is more important than knowledge" - Einstein
    let dollarSign = "\u{24}" // $, Unicode scalar U+0024
    let blackHeart = "\u{2665}" // ♥, Unicode scalar U+2665
    let sparklingHeart = "\u{1F496}" // 💖️, Unicode scalar U+1F496
    
    print("wiseWords is \(wiseWords)")
    print("dollarSign is \(dollarSign)")
    print("blackHeart is \(blackHeart)")
    print("sparklingHeart is \(sparklingHeart)")
    
    
    // 由于多行字符串字面量使用三个双引号而不是一个作为标记，你可以在多行字符串字面量中包含双引号（ " ）而不需转义。要在多行字符串中包含文本 """ ，转义至少一个双引号。比如说：
    let threeDoubleQuotationMarks = """
    Escaping the first quotation mark \"""
    Escaping all three quotation marks \"\"\"
    """
    print("threeDoubleQuotationMarks is \(threeDoubleQuotationMarks)")
    
    
    
    // MARK: 扩展字符串分隔符
    
    // #字符串# --> 字符串中的 \n 不会生效
    let expandString = #"Line1 \n Line2"#
    print("expandString is \(expandString)")
    
    let expandString2 = ###"Line1\###nLine2"###
    print("expandString2 is \(expandString2)")
    
    let threeMoreDoubleQuotationMarks = #"""
    Here are three more double quotes: """
    """#
    print("threeMoreDoubleQuotationMarks is \(threeMoreDoubleQuotationMarks)")
    
    
    // MARK: 初始化一个空字符串
    let emptyString = ""
    if emptyString.isEmpty {
        print("emptyString is empty")
    }
    
    
    // MARK: 字符串可变性
    var varString = "one"
    varString += "two"
    print("varString is \(varString)")
    
    
    // MARK: 字符串是值类型
    var str1 = "str1"
    var str2 = str1
    var str3 = str2
    print("str1变量的地址", Mems.ptr(ofVal: &str1))
    print("str2变量的地址", Mems.ptr(ofVal: &str2))
    print("str3变量的地址", Mems.ptr(ofVal: &str3))
    
    /*
     输出结果：
     str1变量的地址 0x00007ffeefbff210
     str2变量的地址 0x00007ffeefbff200
     str3变量的地址 0x00007ffeefbff1f0
     
     结论：
     Swift 的 String类型是一种值类型。如果你创建了一个新的 String值， String值在传递给方法或者函数的时候会被复制过去，还有赋值给常量或者变量的时候也是一样。每一次赋值和传递，现存的 String值都会被复制一次，传递走的是拷贝而不是原本。
     
     优点：
     Swift 的默认拷贝 String行为保证了当一个方法或者函数传给你一个 String值，你就绝对拥有了这个 String值，无需关心它从哪里来。你可以确定你传走的这个字符串除了你自己就不会有别人改变它。

     另一方面，Swift 编译器优化了字符串使用的资源，实际上拷贝只会在确实需要的时候才进行。这意味着当你把字符串当做值类型来操作的时候总是能够有用很棒的性能。
     */
    
    // MARK: 操作字符串
    for character in "Cat!🐱️" {
        print(character)
    }
    
    // Character数组构造字符串
    let catCharacter: [Character] = ["C", "a", "t", "!", "🐱️"]
    let catString = String.init(catCharacter)
    print(catString)
    
    // UnsafePointer
    
    // 遍历字符串中的字符
    let numbers = [2, 3, 5, 7]
    var numbersIterator = numbers.makeIterator()
    while let num = numbersIterator.next() {
        print(num)
    }
    
    
    // 排序
    var interestingNumbers = [
        "primes" : [2, 3, 4, 11, 13, 19],
        "triangular" : [1, 3, 5, 9, 2]
    ]
    
    for key in interestingNumbers.keys {
        interestingNumbers[key]?.sort(by: >)
    }
    
    print(interestingNumbers["primes"]!)
    
    
    // MARK: 连接字符串和字符
    let appendString1 = "hello"
    let appendString2 = "world"
    let appendString3 = appendString1 + appendString2
    print(appendString3)
    
    
    // MARK: 字符串插值
    let multiple = 3
    let message = "\(multiple) x 2.5 is \(Double(multiple) * 2.5)"
    print(message)
    
    
    
    // MARK: Unicode
    // MARK: Unicode 标量
    // MARK: 访问和修改字符串
    
    
    // MARK: 字符统计
    var word = "cafe"
    print("the number of character in \(word) is \(word.count)")
    
    word += "\u{301}"
    print("the number of character in \(word) is \(word.count)")
    
    let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
    print(regionalIndicatorForUS)
    
    // MARK: 字符串索引
    // 每一个 String值都有相关的索引类型， String.Index，它相当于每个 Character在字符串中的位置。
    // 如上文中提到的那样，不同的字符会获得不同的内存空间来储存，所以为了明确哪个 Character 在哪个特定的位置，你必须从 String的开头或结尾遍历每一个 Unicode 标量。因此，Swift 的字符串不能通过整数值索引。
    
    // endIndex 不一定等于字符串下标脚本的合法实际参数
    
    let indexString = "ABCD EFGH 🐶"
    print("=======indexString=======")
    print(indexString[indexString.startIndex]) // A
    print(indexString[indexString.index(before: indexString.endIndex)])  // 🐶
    print(indexString[indexString.index(after: indexString.startIndex)]) // B
    print(indexString[indexString.index(indexString.startIndex, offsetBy: 7)])  // G
    print(indexString[indexString.index(indexString.startIndex, offsetBy: 10)]) // 🐶
    // print(indexString[indexString.index(indexString.startIndex, offsetBy: 11)]) 越界
    // print(indexString[indexString.endIndex]) 越界
    // print(indexString[indexString.index(after: indexString.endIndex)]) 越界
    print("indexString.count = \(indexString.count)")
    print("=======indexString=======")
    
    
    // MARK: 插入和删除
    var welcome = "hello"
    welcome.insert("!", at: welcome.endIndex)
    print("welcome is \(welcome)")
    
    // 在末尾字符的前面位置插入 `there`
    welcome.insert(contentsOf: "there", at: welcome.index(before: welcome.endIndex))
    print("welcome is \(welcome)")
    
    // 删除末尾字符
    welcome.remove(at: welcome.index(before: welcome.endIndex))
    print("welcome is \(welcome)")
    
    
    
    print("================String================")
}


// MARK: Substring
func substringSummary() {
    
    /*
     与字符串类似，每一个子字符串都有一块内存区域用来保存组成子字符串的字符。字符串与子字符串的不同之处在于，作为性能上的优化，子字符串可以重用一部分用来保存原字符串的内存，或者是用来保存其他子字符串的内存。（字符串也拥有类似的优化，但是如果两个字符串使用相同的内存，他们就是等价的。）这个性能优化意味着在你修改字符串或者子字符串之前都不需要花费拷贝内存的代价。如同上面所说的，子字符串并不适合长期保存——因为它们重用了原字符串的内存，只要这个字符串有子字符串在使用中，那么这个字符串就必须一直保存在内存里。

     在上面的例子中， greeting 是一个字符串，也就是说它拥有一块内存保存着组成这个字符串的字符。由于 beginning 是 greeting 的子字符串，它重用了 greeting 所用的内存。不同的是， newString 是字符串——当它从子字符串创建时，它就有了自己的内存。下面的图例显示了这些关系：
     
     
     注意：
     String 和 Substring 都遵循 StringProtocol 协议，也就是说它基本上能很方便地兼容所有接受 StringProtocol 值的字符串操作函数。你可以无差别使用 String 或 Substring 值来调用这些函数。
     */
    
    print("================Substring================")
    let greeting = "Hi there! It's nice to meet you! 👋"
    let endOfSentence = greeting.firstIndex(of: "!")!
    let firstSentence = greeting[...endOfSentence]
    print("firstSentence ==\(firstSentence)") // firstSentence == "Hi there!"
    
    let shoutingSentence = firstSentence.uppercased()
    print("shoutingSentence ==\(shoutingSentence)")
    
    print("================String================")
}

// MARK: 字符串比较
func compareString() {
    /*
     Swift 提供了三种方法来比较文本值：
     1、字符串和字符相等性
     2、前缀相等性
     3、后缀相等性
     */
    
    // 1、字符串和字符相等性  ==  !=
    
    let str1 = "string"
    let str2 = "string"
    
    if str1 == str2 {
        print("字符串 str1 与 str2 内容相同")
    }
    
    if str1 != str2 {
        print("字符串 str1 与 str2 内容不同")
    }
    
    #warning("注意！！！！！！！")
    /*
     两个 String值（或者两个 Character值）如果它们的扩展字形集群是规范化相等，则被认为是相等的。如果扩展字形集群拥有相同的语言意义和外形，我们就说它规范化相等，就算它们实际上是由不同的 Unicode 标量组合而成。
     比如说， LATIN SMALL LETTER E WITH ACUTE ( U+00E9)是规范化相等于 LATIN SMALL LETTER E( U+0065)加 COMBINING ACUTE ACCENT ( U+0301)的。这两个扩展字形集群都是表示字符é的合法方式，所以它们被看做规范化相等：
     */
    let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
    let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
    
    // Voulez-vous un café?
    print("eAcuteQuestion ==\(eAcuteQuestion)")
    // Voulez-vous un café?
    print("combinedEAcuteQuestion ==\(combinedEAcuteQuestion)")
    
    // eAcuteQuestion == combinedEAcuteQuestion
    if eAcuteQuestion == combinedEAcuteQuestion {
        print("These two strings are considered equal")
    }
    
    
    // 比较 英语中的A 与 俄语中的 A
    /*
     LATIN CAPITAL LETTER A ( U+0041, 或者说 "A")在英语当中是不同于俄语的 CYRILLIC CAPITAL LETTER A ( U+0410,或者说 "А")的。字符看上去差不多，但是它们拥有不同的语言意义
     */
    let latinCapitalLetterA: Character = "\u{41}"
    let cyrillicCapitalLetterA: Character = "\u{0410}"
    print("latinCapitalLetterA ==\(latinCapitalLetterA)")
    print("cyrillicCapitalLetterA ==\(cyrillicCapitalLetterA)")
    
    if latinCapitalLetterA != cyrillicCapitalLetterA {
        print("These two characters are not equivalent")
    }
    
    
    // 2、前缀和后缀相等性  hasPrefix
    // 3、后缀相等性 hasSuffix
    /*
     注意

     如同字符串和字符相等性一节所描述的那样， hasPrefix(_:)和 hasSuffix(_:)方法只对字符串当中的每一个扩展字形集群之间进行了一个逐字符的规范化相等比较。
     */
}


// MARK: 字符串的 Unicode 表示法
func unicodeSummary() {
    
}


stringSummary()

substringSummary()

compareString()

unicodeSummary()
