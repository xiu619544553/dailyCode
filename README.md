

## Swift


## 数据结构与算法

#### 数据结构
1. 数组
2. 链表
    * [单向链表](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/线性表_单链表/main.c)
    * [单向循环链表](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/线性表_单向循环链表/main.c)
    * [双向链表](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/线性表_双向链表/main.c)
    * [双向循环链表](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/线性表_双向循环链表/main.c)
3. [栈](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/栈/main.c)
4. 队列
    * [循环队列](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/循环队列/main.c)
    * [链式循环队列](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/链式循环队列/main.c)
5. 哈希表
    * [哈希表1](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/哈希表/main.c)
    * [哈希表2](https://github.com/xiu619544553/dailyCode/blob/master/数据结构与算法/哈希表2/main.c)
- 7.树
    - 二叉树

## iOS 内存管理
- 1.讲一下 iOS 内存管理的理解？(三种方案的结合) 
- 2.使用自动引用计（`ARC`）数应该遵循的原则? [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/2.使用ARC应该遵守的原则.md)
- 3.`ARC`自动内管管理的原则？
- 4.访问 __weak 修饰的变量，是否已经被注册在了 @autoreleasePool 中？为什么？
- 5.`ARC` 的 `retainCount` 怎么存储的？
- 6.简要说一下 `@autoreleasePool` 的数据结构？
- 7.`__weak` 和 `__unsafe_unretained` 的区别？ [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/7.__weak和__unsafe_unretained的区别.md)
- 8.为什么已经有了 `ARC` ,但还是需要 `@AutoreleasePool` 的存在？
- 9.`__weak` 属性修饰的变量，如何实现在变量没有强引用后自动置为 `nil`？ [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/9.__weak.md)
- 10.`__strong`原理
- 11.说一下对 `retain`,`copy`,`assign`,`weak`,`_Unsafe_Unretain` 关键字的理解。
- 12.`ARC` 在编译时做了哪些工作？
- 13.`ARC` 在运行时做了哪些工作？
- 14.函数返回一个对象时，会对对象 `autorelease` 么？为什么？
- 15.野指针和悬垂指针的区别？ [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/15.野指针和悬垂指针的区别.md)
- 16.内存管理默认的关键字是什么？
- 17.内存中的5大区分别是什么？
- 18.是否了解 `深拷贝` 和 `浅拷贝` 的概念，集合类深拷贝如何实现？ [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/18.深拷贝和浅拷贝.md)
- 19.`BAD_ACCESS` 在什么情况下出现? [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/19.BAD_ACCESS.md)
- 20.`@dynamic` 与 `@synthesize` 区别？ [链接](https://github.com/xiu619544553/dailyCode/blob/master/内存管理/20.@dynamic与@synthesize区别.md)
- 21.`@autoreleasrPool` 的释放时机？
- 22.`retain`、`release` 的实现机制？
- 23.简述 `Dealloc` 的实现机制？
- 24.在 `Obj-C` 中，如何检测内存泄漏？你知道哪些方式？


## Runtime

## Runloop
- 1.`Runloop` 和线程的关系？ - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/1.第一题.md)
- 2.讲一下 `Runloop` 的 `Mode`?(越详细越好)  - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/2.第二题.md)
- 3.讲一下 `Observer` ？（Mode中的重点） - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/3.第三题.md)
- 4.讲一下 `Runloop` 的内部实现逻辑？（运行过程） - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/4.第四题.md)
- 5.你所知的哪些三方框架使用了 `Runloop`?（AFNetworking、Texture 等）
- 6.`autoreleasePool` 在何时被释放？ - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/6.第六题.md)
- 7.解释一下 `事件响应` 的过程？ - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/7.第七题.md)
- 8.解释一下 `手势识别` 的过程？ - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/8.第八题.md)
- 9.解释一下 `GCD` 在 `Runloop` 中的使用？ - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/9.第九题.md)
- 10.解释一下 `NSTimer`，以及 `NSTimer` 的循环引用。 - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/10.第十题.md)
- 11.`AFNetworking` 中如何运用 `Runloop`? - [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/11.第十一题.md)
- 12.`PerformSelector` 的实现原理？- [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/12.第十二题.md)
- 13.利用 `runloop` 解释一下页面的渲染的过程？- [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/13.第十三题.md)
- 14.如何使用 `Runloop` 实现一个常驻线程？这种线程一般有什么作用？- [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/14.第十四题.md)
- 15.为什么 `NSTimer` 有时候不好使？（不同类型的Mode）- [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/15.第十五题.md)
- 16.`PerformSelector:afterDelay:`这个方法在子线程中是否起作用？为什么？怎么解决？- [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/16.第十六题.md)
- 17.什么是异步绘制？- [链接](https://github.com/liberalisman/iOS-InterviewQuestion-collection/blob/master/Runloop/17.第十七题.md)
- 18.如何检测 `App` 运行过程中是否卡顿？
- 19.NSTimer 和 CADisplayLink 存在的问题？替代方案？ - [链接](https://github.com/xiu619544553/dailyCode/blob/master/RunLoop/19.NSTimer 和 CADisplayLink 存在的问题.md)

## UIKit
## Foundation
## 网络
## 多线程
- 1.锁

## 消息传递的方式

#### Block
- 1.`Block`是什么？ [链接](https://github.com/xiu619544553/dailyCode/blob/master/消息传递的方式/block.md)
- 2.`Block` 的内存管理。[链接](https://github.com/xiu619544553/dailyCode/blob/master/消息传递的方式/block.md)
- 3.`Block` 自动截取变量。[链接](https://github.com/xiu619544553/dailyCode/blob/master/消息传递的方式/block.md)
- 4.`Block` 处理循环引用。[链接](https://github.com/xiu619544553/dailyCode/blob/master/消息传递的方式/block.md)
- 5.`Block` 有几种类型？分别是什么？[链接](https://github.com/xiu619544553/dailyCode/blob/master/消息传递的方式/block.md)
- 6.`Block` 和 `函数指针` 的区别? [链接](https://github.com/xiu619544553/dailyCode/blob/master/消息传递的方式/block.md)

#### KVO
- 1.`KVO`的实现机制。

## 项目架构

