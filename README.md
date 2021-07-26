# dailyCode

* 第三方源码解析
* UIKit
* Foundation
* GCD
……


# SwiftSyntax
Swift语法

# 数据结构与算法

## 一、数据结构

### 集合结构 线性结构 树形结构 图形结构

1.1 集合结构 说白了就是一个集合，就是一个圆圈中有很多个元素，元素与元素之间没有任何关系 这 个很简单
1.2 线性结构 说白了就是一个条线上站着很多个人。 这条线不一定是直的。也可以是弯的。也可以 是值的 相当于一条线被分成了好几段的样子 (发挥你的想象力)。 线性结构是一对一的关系
1.3 树形结构 说白了 做开发的肯定或多或少的知道 xml 解析 树形结构跟他非常类似。也可以想象
成一个金字塔。树形结构是一对多的关系
1.4 图形结构 这个就比较复杂了。他呢 无穷。无边 无向(没有方向)图形机构 你可以理解为多对
多 类似于我们人的交集关系


### 数据结构的存储

数据结构的存储一般常用的有两种 顺序存储结构 和 链式存储结构

2.1 顺序存储结构
存储是按顺序。举例说明啊。 栈是先进后出 ，后进先出的。比如：hello world 在栈里面从栈底到栈顶的逻辑依次为 h-e-l-l-o-w-o-r-l-d 这就是顺序存储 再比如 队列 ，队列是先进先出的对吧，从头到尾 h-e-l-l-o-w-o-r-l-d 就是这样排对的。

2.2 链式存储结构
比如，数组1-2-3-4-5-6-7-8-9-10 链式存储就不一样了 1(地址)-2(地址)-7(地址)-4(地址)-5(地址)-9(地址)-8(地址)-3(地 址)-6(地址)-10(地址)。每个数字后面跟着一个地址 而且存储形式不再是顺序 ，也就说顺序乱了，1(地址) 1 后面跟着的这个地址指向的是 2，2 后面的地址指向的是 3，3 后面的地址……，以此类推。它执行的时候是 1(地址)-2(地址)-3(地址)-4(地址)-5(地址)-6(地址)-7(地址)-8(地址)-9(地址)-10(地址)，但是存储的时候就是完全随机的。

### 单向链表\双向链表\循环链表

3.1 单向链表
3.2 双向链表
3.3 循环链表


数组和链表区别：
* 数组元素在内存上连续存放，可以通过下标查找元素;插入、删除需要移动大量元素，比较适用元 素很少变化的情况
* 链表中的元素在内存中不是顺序存储的，查找慢，插入、删除只需要对元素指针重新赋值，效率高


### 二叉树/平衡二叉树