# <center> Block

### 目录
- 一、概念
    - 1.`Block`是什么
    - 2.`Block`的几种类型
    - 3.`Block`自动截取变量
- 二、语法
- 三、源码分析
    - 1.`block`捕获局部变量源码分析
    - 2.`__block` 源码分析
    - 3.`block` 捕获全局静态变量
    - 4.`block` 捕获全局变量
    - 5.`block` 捕获局部静态变量
- 四、循环引用
    - 1.`__weak`
    - 2.`__unsafe_unretained`
    - 3.`__block`
    - 4.将造成循环引用的对象作为参数传入`block块`中
- 五、其他
    - 1.`Block`和`函数指针`的区别

### 一、概念

##### 1、`Block`是什么
`Block` 是将函数及其执行上下文封装起来的对象。
* `Block` Apple在线源文件 [链接](https://opensource.apple.com/source/libclosure/libclosure-63/Block_private.h.auto.html)，它的结构体中包含了isa指针，所以我们在Objc下可以认为是对象。
* `Block`拷贝有关的源码 [链接](https://opensource.apple.com/source/libclosure/libclosure-63/runtime.c)

##### 2、`Block` 的几种类型
在 Runtime 中定义了6种关于Block的类型
```
_NSConcreteStackBlock  // 栈上创建的block
_NSConcreteMallocBlock // 堆上创建的block
_NSConcreteGlobalBlock // 作为全局变量的block
_NSConcreteWeakBlockVariable
_NSConcreteAutoBlock
_NSConcreteFinalizingBlock
```
后三种是用于垃圾回收（Garbage Collection）机制下使用的。

##### 3、`Block` 自动截取变量

`Block` 自动截取变量会截取所有权的修饰符，但是对 `全局变量` 以及 `静态全局变量` 是不会截取的。

- 对于基本数据类型可以理解为值得传递。
- 对于指针类型，可以理解为地址的传递。

### 二、语法

局部变量:
```
returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};
```

属性：
```
@property (nonatomic, copy, nullability) returnType (^blockName)(parameterTypes);
```

方法的参数：
```
- (void)someMethodThatTakesABlock:(returnType (^nullability)(parameterTypes))blockName;
```
方法调用的参数:
```
[someObject someMethodThatTakesABlock:^returnType (parameters) {...}];
```

C函数的参数:
```
void SomeFunctionThatTakesABlock(returnType (^blockName)(parameterTypes));
```

起别名：
```
typedef returnType (^TypeName)(parameterTypes);
TypeName blockName = ^returnType(parameters) {...};
```

### 三、源码分析

首先创建一个 macOS/Command Line Tool工程。

研究`Block`，我们需要获取到底层源码
* cd 到 main.m 所在路径
* 使用命令 `clang -rewrite-objc main.m` 生成 `main.cpp`文件

#### 1、`block`捕获局部变量源码分析

Demo地址：[传送门](https://github.com/xiu619544553/dailyCode/blob/master/block_demo)， Target 选择 `block捕获局部变量`。

`main.m` 代码：
```
int main(int argc, const char * argv[]) {
    
    // 声明一个局部变量用于 block的捕获
    int x = 2;
    
    // 声明一个局部变量NSNumber对象用于block捕获
    NSNumber *number = @(3);
    
    // 声明一个名字为bdBlock，无参数，返回值为浮点型的block
    float (^bdBlock)(void) = ^float() {
        return x * number.floatValue;
    };
    
    // 执行block
    float res = bdBlock();
    
    // 打印block返回值
    NSLog(@"res is %.2f", res);
    
    return 0;
}
```

`main.cpp` 源码：
```
// bdBlock数据结构的描述
static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};

// bdBlock中的copy方法
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->number, (void*)src->number, 3/*BLOCK_FIELD_IS_OBJECT*/);}

// bdBlock中的dispose方法
static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->number, 3/*BLOCK_FIELD_IS_OBJECT*/);}

// Block的定义实现
struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

// bdBlock的数据结构的定义
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  int x;
  NSNumber *number;
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _x, NSNumber *_number, int flags=0) : x(_x), number(_number) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};

// bdBlock中的块函数也会被编译器生成一个C函数。执行block就是执行这个块函数。
static float __main_block_func_0(struct __main_block_impl_0 *__cself) {
  int x = __cself->x; // bound by copy 值拷贝
  NSNumber *number = __cself->number; // bound by copy 值拷贝
  return x * ((float (*)(id, SEL))(void *)objc_msgSend_fpret)((id)number, sel_registerName("floatValue"));
}

// main函数
int main(int argc, const char * argv[]) {

    // 声明一个局部变量用于 block的捕获
    // int x = 2;
    int x = 2;

    // 声明一个局部变量NSNumber对象用于block捕获
    // NSNumber *number = @(3);
    NSNumber *number = ((NSNumber *(*)(Class, SEL, int))(void *)objc_msgSend)(objc_getClass("NSNumber"), sel_registerName("numberWithInt:"), (3));

    // 声明一个名字为bdBlock，无参数，返回值为浮点型的block
    // float (^bdBlock)(void) = ^float() {
    //     return x * number.floatValue;
    // };
    // float (*bdBlock)(void) = ((float (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, x, number, 570425344));
    // (void *)__main_block_func_0 block的块函数编译成了一个C函数，即 `{ return x * number.floatValue; };`
    // __main_block_desc_0_DATA：bdBlock数据结构的描述
    float (*bdBlock)(void) = &__main_block_impl_0(
                                                  (void *)__main_block_func_0,
                                                  &__main_block_desc_0_DATA,
                                                  x,
                                                  number,
                                                  570425344);

    // 执行block
    // float res = bdBlock();
    float res = ((float (*)(__block_impl *))((__block_impl *)bdBlock)->FuncPtr)((__block_impl *)bdBlock);

    // 打印block返回值
    // NSLog(@"res is %.2f", res);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_35de0c_mi_0, res);


    return 0;
}
```

通过代码调试、源码分析可以得到的一些结论：
* `block` 本质上是一个结构体
* `block` 初始化完成后在栈上，初始化时传入的是局部变量x的值 `&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, x, ....);`，所以在block块内是无法访问局部变量的。当main函数返回时，函数的栈被销毁，bdBlock的内存也会被清除，如果在函数结束后仍然引用这个Block的时候，就需要将它拷贝到堆上。

**关于Block的Copy**
__main_block_impl_0中我们也不难发现，定义完bdBlock之后Block存储在当前函数的_NSConcreteStackBlock上面，也就是bdBlock中的isa指向的是该Block的Class的类型是_NSConcreteStackBlock

**Block Copy 伪代码：**
```
// 申请跟现有block size一样的内存
struct Block_layout *result = malloc(aBlock->descriptor->size);
// 将现有的block中的数据复制过去
memmove(result, aBlock, aBlock->descriptor->size);
// 更新isa指针指向堆
result->isa = _NSConcreteMallocBlock;
// 向捕获的对象发送retian，增加新的block的引用计数
_Block_call_copy_helper(result, aBlock);
return result; 
```
#### 2、`__block` 源码分析

Demo地址：[传送门](https://github.com/xiu619544553/dailyCode/blob/master/block_demo)， Target 选择 `__block修饰局部变量`。

`main.m` 代码：
```
int main(int argc, const char * argv[]) {
    
    __block int x = 2;
    
    NSLog(@"x1---%d---%p", x, &x);
    void (^tkBlock)(void) = ^void() {
        x = 3;
        NSLog(@"x2---%d---%p", x, &x);
    };
    
    // 执行block
    tkBlock();
    
    // 打印block返回值
    NSLog(@"x3---%d---%p", x, &x);
    
    return 0;
}
```

`main.cpp` 代码：
```
// block 类型
struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

// tkBlock实现
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  __Block_byref_x_0 *x; // by ref。指针引用
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_x_0 *_x, int flags=0) : x(_x->__forwarding) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};

// tkBlock中的块函数也会被编译器生成一个C函数。执行block就是执行这个块函数。
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  __Block_byref_x_0 *x = __cself->x; // bound by ref 拿到结构体指针
  (x->__forwarding->x) = 3; // 修改结构体成员变量的值
  NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_000088_mi_1, (x->__forwarding->x), &(x->__forwarding->x));
}

// tkBlock的拷贝函数
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->x, (void*)src->x, 8/*BLOCK_FIELD_IS_BYREF*/);}

// tkBlock的销毁函数
static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->x, 8/*BLOCK_FIELD_IS_BYREF*/);}

// tkBlock数据结构的描述
static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};

// __block x 的定义
struct __Block_byref_x_0 {
  void *__isa;
__Block_byref_x_0 *__forwarding; // 结构体指针，指向当前结构体的地址 __forwarding = (&x)
 int __flags;
 int __size;
 int x;
};

int main(int argc, const char * argv[]) {

    // ---代码
    // __block int x = 2;
    
    // NSLog(@"x1---%d---%p", x, &x);
    // void (^tkBlock)(void) = ^void() {
    //     x = 3;
    //     NSLog(@"x2---%d---%p", x, &x);
    // };
    
    // // 执行block
    // tkBlock();
    
    // // 打印block返回值
    // NSLog(@"x3---%d---%p", x, &x);


    // ---源码
    // __block int x = 2;
    // __block 把 int 的值处理成了结构体
    __attribute__((__blocks__(byref))) __Block_byref_x_0 x = {(void*)0,
                                                              (__Block_byref_x_0 *)&x, 
                                                              0, 
                                                              sizeof(__Block_byref_x_0), 
                                                              2};
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_000088_mi_0, (x.__forwarding->x), &(x.__forwarding->x));

    // tkBlock初始化
    // void (^tkBlock)(void) = ^void() {
    //     x = 3;
    //     NSLog(@"x2---%d---%p", x, &x);
    // };
    // __main_block_func_0：block块代码，被编译成了一个函数，此处传入的是函数地址（函数名即函数实现地址）
    // __main_block_func_0：block结构体描述，包括拷贝、释放等实现
    // (__Block_byref_x_0 *)&x：传入结构体指针（引用传递：强引用：内部可以修改局部变量的值）。block本身可以当做对象来看待，然后它捕获的变量是显示的，也就是是强引用，如果外部有对该闭包也有一个强引用，那么就会造成引用循环。
    void (*tkBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, 
                                                              &__main_block_desc_0_DATA, 
                                                              (__Block_byref_x_0 *)&x, 
                                                              570425344));


    // tkBlock调用
    // tkBlock();
    ((void (*)(__block_impl *))((__block_impl *)tkBlock)->FuncPtr)((__block_impl *)tkBlock);

    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_000088_mi_2, (x.__forwarding->x), &(x.__forwarding->x));

    return 0;
}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
```

输出日志：
```
2021-11-05 11:59:41.994375+0800 block_demo[10535:130866] x1---2---0x7ffeefbff448
2021-11-05 11:59:41.994889+0800 block_demo[10535:130866] x2---3---0x10060e438
2021-11-05 11:59:41.995013+0800 block_demo[10535:130866] x3---3---0x10060e438
```

分析源码：
* `__block` 修饰的局部变量 x，被处理成了一个结构体 `__Block_byref_x_0`，结构体接收的参数包括该结构体的指针变量 `__forwarding`，`Block`块函数内部就是通过这个指针变量修改变量的值的
* `block` 初始化时传入的是局部变量x的地址 `&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_x_0 *)&x, ....);`。**引申**：既然你传入的是结构体指针(可以理解为OC对象)，那么`block`就持有了该变量，如果外部对该闭包也有一个强引用，就会造成循环引用。
* 从输出日志看出：`__block` 修饰的局部变量从栈拷贝到了堆、`block`也在堆中。


#### 3、`block` 捕获全局静态变量

Demo地址：[传送门](https://github.com/xiu619544553/dailyCode/blob/master/block_demo)， Target 选择 `block捕获变量`。

```
// 1、全局静态变量
static int a = 11;

int main() {
    // 1、全局静态变量
    NSLog(@"a1---%d---%p", a, &a);
    void (^aBlock)(void) = ^void() {
        a = 12;
        NSLog(@"a2---%d---%p", a, &a);
    };
    aBlock();
    NSLog(@"a3---%d---%p", a, &a);
}
```

输出日志：
```
2021-11-05 10:55:25.332753+0800 block捕获变量[7499:94468] a1---11---0x100008028
2021-11-05 10:55:25.333289+0800 block捕获变量[7499:94468] a2---12---0x100008028
2021-11-05 10:55:25.333370+0800 block捕获变量[7499:94468] a3---12---0x100008028
```
**结论：**从代码和打印结果看出变量始终在全局数据区，内存地址不变

#### 4、`block` 捕获全局变量

```
int b = 22;

int main() {
    NSLog(@"b1---%d---%p", b, &b);
    void (^bBlock)(void) = ^void() {
        b = 23;
        NSLog(@"b2---%d---%p", b, &b);
    };
    bBlock();
    NSLog(@"b3---%d---%p", b, &b);
}
```

输入日志：
```
 2021-11-05 10:55:25.333498+0800 block捕获变量[7499:94468] b1---22---0x100008020
 2021-11-05 10:55:25.333547+0800 block捕获变量[7499:94468] b2---23---0x100008020
 2021-11-05 10:55:25.333589+0800 block捕获变量[7499:94468] b3---23---0x100008020
```
**结论：**从代码和打印结果观察和上述一样，也在全局数据区，内存地址不变

#### 5、`block` 捕获局部静态变量

```
int main() {
    NSLog(@"c1---%d---%p", c, &c);
    void (^cBlock)(void) = ^void() {
        c = 34;
        NSLog(@"c2---%d---%p", c, &c);
    };
    cBlock();
    NSLog(@"c3---%d---%p", c, &c);
}
```

输出日志：
```
 2021-11-05 10:55:25.333627+0800 block捕获变量[7499:94468] c1---33---0x100008024
 2021-11-05 10:55:25.333664+0800 block捕获变量[7499:94468] c2---34---0x100008024
 2021-11-05 10:55:25.333699+0800 block捕获变量[7499:94468] c3---34---0x100008024
```
内存地址不变。

### 四、循环引用

引起循环引用的原因，可以参考上述分析中的block源码：正式指针引用，产生了了循环引用。

来看一份存在循环引用问题的代码：
```
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString * (^fetchUserNameHandler)(NSInteger userId);

// 强引用关系：self->fetchUserNameHandler -> self
self.fetchUserNameHandler = ^NSString *(NSInteger userId) {
    NSString *tmp = [NSString stringWithFormat:@"%@%ld", self.userName, userId];
    NSLog(@"userName = %@", tmp);
    return tmp;
};
```

常用解决方式有这么几种。

#### 1、`__weak`
对其中一方的引用循环对象使用__weak修饰，然后__weak就会进行自动管理弱引用，表现为当对象引用计数为0时候的会自动清对象所占内存，具体原理是系统在底层维护了一系列的哈希结构。

```
// 打破循环引用
__weak typeof(self) weakSelf = self;
self.fetchUserNameHandler = ^NSString *(NSInteger userId) {
    NSString *tmp = [NSString stringWithFormat:@"%@%ld", weakSelf.userName, userId];
    NSLog(@"userName = %@", tmp);
    return tmp;
};

// 调用block
self.fetchUserNameHandler(10);
```

#### 2、`__unsafe_unretained`（用的少）

__unsafe_unretained与__weak的作用是一样的，但是__unsafe_unretained指向的对象被释放后，指针不会依然会指向被释放的内存，当在使用该指针时，会出现野指针问题。__unsafe_unretained的性能优于__weak，因为__weak在对象所在内存被释放时，会主动将__weak修饰的指针置为nil，会去遍历weak表。如果你能清晰的把控 __unsafe_unretained修饰的对象的生命周期，可以使用该修饰词。

代码示例：
```
__unsafe_unretained SecondViewController *unsafeSelf = self;
self.fetchUserNameHandler = ^NSString *(NSInteger userId) {
    NSString *tmp = [NSString stringWithFormat:@"%@%ld", unsafeSelf.userName, userId];
    NSLog(@"userName = %@", tmp);
    return tmp;
};

self.fetchUserNameHandler(10);
```

#### 3、`__block`
`__block`这种方式修饰的原理就是把其中一方的引用创建一份到Block的栈，随着Block拷贝到堆上，使用完成之后进行销毁。请参考章节：`三、源码分析 -> 2.__block 修饰局部变量`。

```
// __block 拷贝了一份指针到block的栈（系统控制生命周期），然后跟随block拷贝到堆（程序员控制block的生命周期），使用完成后记得销毁
__block SecondViewController *blockSelf = self;

// blockSelf 与 self 指向相同的内容，但是指针变量不同
NSLog(@"%@ %p", self, &self);
NSLog(@"%@ %p", blockSelf, &blockSelf);

self.fetchUserNameHandler = ^NSString *(NSInteger userId) {
    NSString *tmp = [NSString stringWithFormat:@"%@%ld", blockSelf.userName, userId];
    NSLog(@"userName = %@", tmp);
    blockSelf = nil;
    return tmp;
};

self.fetchUserNameHandler(10);
```

#### 4、将造成循环引用的对象作为参数传入block块中

```
self.fetchUserNameHandler2 = ^NSString *(SecondViewController *vc, NSInteger userId) {
    NSString *tmp = [NSString stringWithFormat:@"%@%ld", vc.userName, userId];
    NSLog(@"userName = %@", tmp);
    return tmp;
};

self.fetchUserNameHandler2(self, 10);
```

### 五、其他

#### 1.`Block`和`函数指针`的区别

①函数指针仅仅是一个地址，不具备函数原型信息，没有类型限制，比如一个指向变量的指针同样可以指向一个函数，但是 block 作为函数对象，是有部分函数信息的，类型限制更明确。
②block 方式便于实现真正的 “函数式” 编程，让函数成为基本的运算元，往更远的方向说，真正的函数式语言可以去掉寄存器(请参考冯诺依曼机器基本架构)，提高程序的执行效率，近段时间的语言都支持 lambda 语法，包括JS、 C++ 、 Python 、 Ruby等，可见各个编程语言为改进冯诺依曼架构做出的努力和准备。
③提高程序的健壮性， 定义函数的代码会位于程序的代码段，如果函数内部出现内存溢出，就会直接导致 crash，因为代码段是不可写的；block 作为函数对象在运行时生成，位于栈内，即使出现内存溢出，一般也不会直接导致 crash。


参考资料：
- [iOS下的闭包上篇-Block](https://mp.weixin.qq.com/s/LdaQxl3ZI1uXN9GvoH2sXg)
- [Block和函数指针的区别](https://blog.csdn.net/dexin5195/article/details/41083323)