//
//  main.swift
//  demo_Property
//
//  Created by hello on 2020/8/12.
//  Copyright © 2020 TK. All rights reserved.
//  属性 https://www.cnswift.org/properties

import Foundation



/*
 
 作用：属性可以将值与特定的类、结构体、枚举联系起来
 
 属性类型：
 1、存储属性：存储属性会存储常量或变量作为实例的一部分；存储属性只能由类和结构体定义
    * 变量存储属性
    * 常量存储属性  https://www.cnswift.org/initialization#spl-9
 2、计算属性：计算属性会计算（而不是存储）值；计算属性可以由类、结构体和枚举定义
 
 存储属性和计算属性通常和特定类型的实例相关联。总之，属性也可以与类型本身相关联。这种属性就是所谓的类型属性。
 
 属性观察器：可以定义属性观察器来检查属性中值的变化，这样就可以用自定义的行为来响应。属性观察器可以被添加到你自己定义的存储属性中，也可以添加到子类从他的父类那里所继承来的属性中。
 
 */

class LifeQuestion {
    let text: String
    var request: String?
    
    init(text: String) {
        // 在初始化的任意时刻，你都可以给常量属性赋值，只要它在初始化结束时设置了确定的值即可。一旦为常量属性被赋值，它就不能再被修改了
        // 对于类实例来说，常量属性在初始化中只能通过引用的类来修改。它不能被子类修改
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

struct FixedLengthRange {
    var firstValue: Int
    // 在初始化时刻可以赋值；当新的值域创建时 length已经被创建并且不能再修改，因为它是一个常量 let
    let length: Int
}

class Person {
    var age: Int
    let weight: Double
    
    init(weight: Double, age: Int) {
        self.age    = age
        self.weight = weight
    }
}

// MARK: 存储属性
func storePropertySummary() {
    print("========存储属性========")
    
    // 1.1 变量结构体实例的存储属性
    var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
    rangeOfThreeItems.firstValue = 6
    // rangeOfThreeItems.length = 5 报错：Cannot assign to property: 'length' is a 'let' constant
    print("rangeOfThreeItems.firstValue=\(rangeOfThreeItems.firstValue)")
    
    // 1.2 常量结构体实例的存储属性
    // 如果创建了结构体的实例并且把这个实例赋给常量，你不能修改这个实例的属性，即使是声明为变量的属性：
    #warning("这是由于结构体是值类型。当一个值类型的实例被标记为常量时，该实例的其他属性也均为常量。")
    let rangeOfFourItems = FixedLengthRange(firstValue: 1, length: 5)
    // rangeOfFourItems.firstValue = 2 报错：Cannot assign to property: 'rangeOfFourItems' is a 'let' constant。因为 rangeOfFourItems 是 let 修饰的，不可修改
    print(rangeOfFourItems.firstValue)
    
    
    
    // 2.1 常量类实例的存储属性
    #warning("对于类来说则不同，它是引用类型。如果你给一个常量赋值引用类型实例，你仍然可以修改那个实例的变量属性。")
    let person = Person(weight: 85.0, age: 25)
    person.age = 26
    // person.weight = 90.0 报错：类常量属性只能在初始化时赋值，新的值域创建后就不允许创建了
    print("person.age = \(person.age)")
    
    
    print("========存储属性========\n")
}

// MARK: 常量存储属性
func constantSummary() {
    print("========常量存储属性========")
    let lq = LifeQuestion(text: "Life is beautiful")
    lq.ask()
    print("========常量存储属性========\n")
}


// MARK: 延迟存储属性

class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    // 延迟存储属性的初始值在其第一次使用时才进行计算。你可以通过在其声明前标注 lazy 修饰
    var data = [String]() // 数组初始化
}

func lazyPropertySummary() {
    print("========延迟存储属性========")
    
    /*
     延迟存储属性的初始值在其第一次使用时才进行计算。你可以通过在其声明前标注 lazy 修饰
     
     Swift 把这些概念都统一到了属性声明里。Swift 属性没有与之相对应的实例变量，并且属性的后备存储不能被直接访问。这避免了不同环境中对值的访问的混淆并且将属性的声明简化为一条单一的、限定的语句。所有关于属性的信息——包括它的名字，类型和内存管理特征——都作为类的定义放在了同一个地方。
     */
    
    let manager = DataManager()
    manager.data.append("some data")
    manager.data.append("some more data")
    print(manager.data)
    print("manager.importer.fileName=\(manager.importer.fileName)")
    
    
    print("========延迟存储属性========\n")
}

// MARK: 存储属性与实例变量
// Swift 属性没有与之相对应的实例变量，并且属性的后备存储不能被直接访问。这避免了不同环境中对值的访问的混淆并且将属性的声明简化为一条单一的、限定的语句。所有关于属性的信息——包括它的名字，类型和内存管理特征——都作为类的定义放在了同一个地方。



// MARK: 计算属性

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size   = Size()
    var center: Point {
        get {
            let centerX = origin.x + size.width / 2.0
            let centerY = origin.y + size.height / 2.0
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - size.width / 2.0
            origin.y = newCenter.y - size.height / 2.0
        }
    }
}

func calculateProperty() {

    var square = Rect(origin: Point(x: 10.0, y: 10.0), size: Size(width: 100.0, height: 100.0))
    
    let originalCenter = square.center
    square.center = Point(x: 15.0, y: 15.0)
    
    print("originalCenter=\(originalCenter)；current center=\(square.center)")
}


// MARK: 简写设置器 - setter - newValue
// 如果一个计算属性的设置器没有为将要被设置的值定义一个名字，那么他将被默认命名为 newValue

struct AlternativeRect {
    var origin = Point()
    var size   = Size()
    var center: Point {
        get {
            let centerX = origin.x + size.width/2.0
            let centerY = origin.y + size.height/2.0
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - size.width/2.0
            origin.y = newValue.y - size.height/2.0
        }
    }
}

// MARK: 缩写读取器声明 - getter
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            // 隐式返回，隐藏 return
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


// MARK: 只读计算属性
// 一个有读取器但是没有设置器的计算属性就是所谓的只读计算属性。只读计算属性返回一个值，也可以通过点语法访问，但是不能被修改为另一个值。
// 注意：你必须用 var 关键字定义计算属性——包括只读计算属性——为变量属性，因为它们的值不是固定的。 let 关键字只用于常量属性，用于明确那些值一旦作为实例初始化就不能更改。

// 你可以通过去掉 get 关键字和他的大扩号来简化只读计算属性的声明：

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
//    var volume: Double { // 隐式返回函数
//        width * height * depth
//    }
}

func readOnlyProperty() {
    print("========只读计算属性========")
    
    let fourByFiveTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
    // 错误：Cannot assign to property: 'volume' is a get-only property
    // fourByFiveTwo.volume = 20.0
    print("fourByFiveTwo=\(fourByFiveTwo)   volume=\(fourByFiveTwo.volume)")
    
    print("========只读计算属性========\n")
}


// MARK: 属性观察者
// 属性观察者会观察并对属性值的变化做出回应。每当一个属性的值被设置时，属性观察者都会被调用，即使这个值与该属性当前的值相同。
/*
 你可以在如下地方添加属性观察者：

 * 你定义的存储属性；
 * 你继承的存储属性；
 * 你继承的计算属性。
 
 对于继承的属性，你可以通过在子类里重写属性来添加属性观察者。对于你定义的计算属性，使用属性的设置其来观察和响应值变化，而不是创建观察者。属性重载将会在重写中详细描述。
 
 你可以选择将这些观察者或其中之一定义在属性上：
 * willSet 会在该值被存储之前被调用。
 * didSet 会在一个新值被存储后被调用。
 
 * 如果你实现了一个 willSet 观察者，新的属性值会以常量形式参数传递。你可以在你的 willSet 实现中为这个参数定义名字。如果你没有为它命名，那么它会使用默认的名字 newValue。
 
 * 如果你实现了一个 didSet观察者，一个包含旧属性值的常量形式参数将会被传递。你可以为它命名，也可以使用默认的形式参数名 oldValue 。如果你在属性自己的 didSet 观察者里给自己赋值，你赋值的新值就会取代刚刚设置的值。
 
 注意
 父类属性的 willSet 和 didSet 观察者会在子类初始化器中设置时被调用。它们不会在类的父类初始化器调用中设置其自身属性时被调用。
 
 
 注意
 如果你以输入输出形式参数传一个拥有观察者的属性给函数， willSet 和 didSet 观察者一定会被调用。这是由于输入输出形式参数的拷贝入拷贝出存储模型导致的：值一定会在函数结束后写回属性。更多关于输入输出形式参数行为的讨论，参见输入输出形式参数。
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("willSet.totalSteps =\(newValue)")
        }
        didSet {
            print("didSet.totalSteps=\(totalSteps)")
            print("didSet.oldValue=\(oldValue)")
        }
    }
}

func observerProperty() {
    print("========属性观察者========")
    
    let counter = StepCounter()
    counter.totalSteps = 100
    
    print("111")
    
    counter.totalSteps = 200
    print("========属性观察者========\n")
}

// MARK: 输入输出形式参数 https://www.cnswift.org/functions#spl-13
func swap(a: inout Int, b: inout Int) {

    print("swap.前.a=\(a), b=\(b)")
    
    let temp = a
    a = b
    b = temp
    
    print("swap.后.a=\(a), b=\(b)")
}

func test1() {
    var a = 10
    var b = 3
    swap(&a, &b) // 直接在它前边添加一个和符号 ( &) 来明确可以被函数修改
    
    print("=======test1======")
    print("test1.a=\(a), b=\(b)")
}


// MARK: 属性包装
//@propertyWrapper
//struct TwelveOrLess {
//    private var number = 0
//    var wrappedValue: Int {
//        get { return number }
//        set { number = min(newValue, 12) }
//    }
//}

// MARK: 设定包装属性的初始值
// MARK: 通过属性包装映射值

@propertyWrapper
struct TwelveOrLess {
    var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

// SmallRectangle 等同于下面的代码，显示地包装了自己的属性
struct SmallRectangleVisible {
    
    // _height 和 _width 属性存储了一个属性包装的实例，TwelveOrLess
    // 存储属性
    private var _height = TwelveOrLess()
    private var _width  = TwelveOrLess()
    
    // height 和 width 的 getter 和 setter 包装了 wrappedValue 属性的访问
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}


// MARK: 设定包装属性的初始值

@propertyWrapper
struct SmallNumber {
    
    private var max: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, max) }
    }
    
    /*
     SmallNumber 的定义包含了三个初始化器—— init() 、 init(wrappedValue:) 、以及 init(wrappedValue:maximum:) ——也就是下面例子中用来设置包装值和最大值的初始化器。
     */
    init() {
        max = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        max = 12
        // 报错：'self' used before all stored properties are initialized
        // 在创建类或结构的实例时，类和结构必须将其所有存储属性设置为适当的初始值
        // self.wrappedValue = wrappedValue
        number = min(max, wrappedValue)
        // 用在这里不会报错：因为 Swift要求：“self”在所有存储属性初始化之前使用
        self.wrappedValue = wrappedValue
    }
    
    init(wrappedValue: Int, max: Int) {
        self.max = max
        number = min(wrappedValue, max)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

// 给定初始化值（一）
struct UnitRectangle {
    // 当你在应用了包装的属性上使用 = 1 时，它被翻译成调用 init(wrappedValue:) 初始化器。包装了 height 和 width 的实例 SmallNumber 通过调用 SmallNumber(wrappedValue: 1) 生成。初始化器使用这里指定的包装值，也就是使用默认 12 最大值。
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

// 给定初始化值（二）
struct NarrowRectangle {
    // 当你在自定义特性后的括号中写实际参数时，Swift 使用接受那些实际参数的初始化器来设置包装。比如说，如果你提供初始值和最大值，Swift 使用 init(wrappedValue:maximum:) 初始化器：
    
    // 包装了 height 的 SmallNumber 实例通过调用 SmallNumber(wrappedValue: 2, maximum: 5) 生成
    @SmallNumber(wrappedValue: 2, max: 5) var height: Int
    // 包装 width 的实例通过调用 SmallNumber(wrappedValue: 3, maximum: 4) 生成
    @SmallNumber(wrappedValue: 3, max: 6) var width: Int
    
    // 上述语法：通过为属性包装添加实际参数，你可以为包装设置初始状态或者在包装创建后传递其他选项。这个语法是使用属性包装最通用的方式。
}

// 给定初始化值（三）
struct MixedRectangle {
    
    // 包装 height 的 SmallNumber 实例通过调用 SmallNumber(wrappedValue: 1) 生成，它使用默认的最大值 12.包装
    @SmallNumber var height: Int = 1
    
    // 包装 width 的实例通过调用 SmallNumber(wrappedValue: 2, maximum: 9) 生成
    @SmallNumber(max: 9) var width: Int = 2
}


// MARK: 通过属性包装映射
@propertyWrapper
struct SmallNumberMap {
    var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}

struct SomeStructureMap {
    @SmallNumberMap var someNumber: Int
}

// 测试 属性包装
func testPropertyWrapper() {
    print("=========属性包装=======")
    
    var rectangle = SmallRectangle()
    print(rectangle.height)
    
    rectangle.height = 10
    rectangle.width = 20
    // 10  12
    print("rectangle.height = \(rectangle.height)...rectangle.width = \(rectangle.width)")
    
    rectangle.height = 20
    // 12  12
    print("rectangle.height = \(rectangle.height)...rectangle.width = \(rectangle.width)")
    
    
    
    var zeroRectangle = ZeroRectangle()
    print("zeroRectangle.height=\(zeroRectangle.height)...zeroRectangle.width=\(zeroRectangle.width)")
    
    
    var unitRectangle = UnitRectangle()
    print("unitRectangle.height=\(unitRectangle.height)...unitRectangle.width=\(unitRectangle.width)")
    
    
    // 测试属性包装映射值
    
    var someStructure = SomeStructureMap()
    someStructure.someNumber = 4
    print("SomeStructure.$someNumber = \(someStructure.$someNumber)")
    
    someStructure.someNumber = 13
    print("SomeStructure.$someNumber = \(someStructure.$someNumber)")
    
    print("=========属性包装=======\n")
}



// MARK: 全局和局部变量
// MARK: 类型属性
/*
 * 属性分为两种
 * 1、类的实例对象的属性，叫做 实例属性
 * 2、类本身的属性，叫做 类型属性
 
 
 存储类型属性可以是变量或者常量。计算类型属性总要被声明为变量属性，与计算实例属性一致。
 
 
 注意
 * 不同于存储实例属性，你必须总是给存储类型属性一个默认值。这是因为类型本身不能拥有能够在初始化时给存储类型属性赋值的初始化器。
 * 存储类型属性是在它们第一次访问时延迟初始化的。它们保证只会初始化一次，就算被多个线程同时访问，他们也不需要使用 lazy 修饰符标记。
 */


// MARK: 类型属性语法
/*
 在 C 和  Objective-C 中，你使用全局静态变量来定义一个与类型关联的静态常量和变量。在 Swift 中，总之，类型属性是写在类型的定义之中的，在类型的花括号里，并且每一个类型属性都显式地放在它支持的类型范围内。
 
 使用 static 关键字来声明类型属性。对于类类型的计算类型属性，你可以使用 class 关键字来允许子类重写父类的实现。下面的栗子展示了存储和计算类型属性的语法：
 */
struct SomeStructure {
    // 存储类型 类型属性
    static var storedTypeProperty = "old value"
    // 计算类型 类型属性
    static var computedTypePreperty: Int {
        return 0
    }
}

enum SomeEnumeration {
    // 存储类型 类型属性
    static var storedTypeProperty = "old value"
    // 计算类型 类型属性
    static var computedTypeProperty: Int {
        return 0
    }
}

// 父类
class SomeClass {
    // 存储类型 类型属性
    static var storedTypeProperty = "old value"
    
    
    // 计算类型 类型属性。子类不能重写。如果允许子类重写，需要添加 class，如下
    static var computedTypeProperty: Int { // 只读
        return 0
    }
    
    // 计算类型 类型属性。子类不能重写。如果允许子类重写，需要添加 class，如下
    static var computedTypeReadWriteProperty: Int { // 可读可写
        get { return 0 }
        set { print("computedTypeReadWriteProperty: \(newValue)") }
    }
    
    // class 关键字允许子类重写该类型属性的实现。
    class var overideableComputedTypeProperty: Int { // 只读
        return 0
    }
    
    class var overideableReadWriteComputedTypeProperty: Int { // 可读可写
        get { return 0 }
        set { print("overideableReadWriteComputedTypeProperty:\(newValue)")}
    }
}

// 子类
class SubSomeClass: SomeClass {
    // 重写父类 类型属性的实现
    override class var overideableComputedTypeProperty: Int {
        return 9
    }
}


// MARK: 查询和设置类型属性
func queryAndSetClassProperty() {
    print("=========查询和设置类型属性=======")
    
    print(SomeStructure.storedTypeProperty)

    SomeStructure.storedTypeProperty = "new value"
    print(SomeStructure.storedTypeProperty)
    
    print(SomeClass.overideableReadWriteComputedTypeProperty)
    SomeClass.overideableReadWriteComputedTypeProperty = 123
    print("获取计算属性新值: \(SomeClass.overideableReadWriteComputedTypeProperty)")
    
    print(SubSomeClass.overideableReadWriteComputedTypeProperty)
    SubSomeClass.overideableReadWriteComputedTypeProperty = 456
    print("设置子类计算属性新值: \(SubSomeClass.overideableReadWriteComputedTypeProperty)")
    
    print("=========查询和设置类型属性=======\n")
}

func queryAndSetClassProperty2() {
    print("=========测试类型属性变化情况=======")
    
    // 类存储属性 被其他函数修改了，则后续其他地方调用的值就是最后修改的值
    print(SomeStructure.storedTypeProperty)
    print(SomeStructure.storedTypeProperty)
    
    // 类计算属性，不受其他函数调用影响
    print(SomeClass.overideableReadWriteComputedTypeProperty)
    print(SubSomeClass.overideableReadWriteComputedTypeProperty)
    
    print("=========测试类型属性变化情况=======\n")
}


constantSummary()
storePropertySummary()
lazyPropertySummary()
calculateProperty()
readOnlyProperty()
observerProperty()
test1()

queryAndSetClassProperty()
queryAndSetClassProperty2()

testPropertyWrapper()
