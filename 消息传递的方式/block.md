# <center> Block

### 目录
- 一、概念
    - 1.`Block`是什么
    - 2.`Block`的几种类型
    - 3.`Block`自动截取变量
- 二、语法
- 三、Block的原理
    - 1.`block` 捕获局部变量（自动变量）
    - 2.`__block` 说明符
    - 3.`Block` 存储域
    - 4.`__block`变量存储域
- 四、循环引用
    - 1.`__weak`
    - 2.`__unsafe_unretained`
    - 3.`__block`
    - 4.将造成循环引用的对象作为参数传入`block块`中
- 五、其他
    - 1.`Block`和`函数指针`的区别
- 六、面试题
    - 问题1

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

### 三、Block的原理

首先创建一个 macOS/Command Line Tool工程。

研究`Block`，我们需要获取到底层源码
* cd 到 main.m 所在路径
* 使用命令 `clang -rewrite-objc main.m`  或 `xcrun -sdk iphoneos clang -arch arm64 -w -rewrite-objc main.m` 生成 `main.cpp`文件

#### 1、`block` 捕获局部变量（自动变量）

Demo地址：[传送门](https://github.com/xiu619544553/dailyCode/blob/master/block_demo)， Target 选择 `block捕获局部变量`。

`Block`转换为 `C` 函数之后，`Block` 中使用的自动变量（局部变量）会被作为成员变量追加到 `__X_block_impl_Y` 结构体中，其中 `X`一般是函数名， `Y`是第几个`Block`，比如 main函数中的第0个结构体： `__main_block_impl_0`。

`main.m` 代码：
```
#import <Foundation/Foundation.h>

typedef void (^MyBlock)(void);

int main(int argc, const char * argv[]) {
    
    int age = 10;
    MyBlock block = ^{
        NSLog(@"age = %d", age);
    };
    age = 18;
    block();
    
    return 0;
}
```

`main.cpp` 源码：
```
typedef void (*MyBlock)(void);

// Block的定义实现
struct __block_impl {
  void *isa;     // block的类型：全局、栈、堆
  int Flags;
  int Reserved;
  void *FuncPtr; // 函数的指针！就是通过它调用block的。
};

// Block转换为C函数之后，Block中使用的自动变量会被作为成员变量追加到 __X_block_impl_Y结构体中，其中 X一般是函数名，Y是第几个Block
struct __main_block_impl_0 {
    struct __block_impl impl;           // block的函数的imp结构体
    struct __main_block_desc_0* Desc;   // block的信息
    int age;                            // 值引用的age值
    
    // 构造函数
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
        impl.isa = &_NSConcreteStackBlock; // 栈类型的block
        impl.Flags = flags;
        impl.FuncPtr = fp;                 // 传入了块函数具体的imp指针（函数指针，最终就是通过函数指针调用block）
        Desc = desc;
    }
};

// Block的块函数也会被编译器生成一个C函数。执行block就是执行这个C函数。
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    int age = __cself->age; // 值传递
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_50eeea_mi_0, age);
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};


int main(int argc, const char * argv[]) {
    
    int age = 10;
    MyBlock block = ((void (*)())&__main_block_impl_0(
                                                    (void *)__main_block_func_0,
                                                      &__main_block_desc_0_DATA,
                                                      age));
    age = 18;
    // 通过函数的指针 block->FuncPrt调用block。
    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
    
    return 0;
}
```

通过代码调试、源码分析可以得到的一些结论：
* `block` 本质上是一个结构体
* `block` 初始化时 `impl.isa = &_NSConcreteStackBlock` 在栈上，初始化时传入的是局部变量age的值 `&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age, ....);` ，其中 `(void *)__main_block_func_0`是block块的函数指针，`age`是值传递，所以block块内不能修改局部变量的值。当main函数返回时，函数的栈被销毁，Block的内存也会被清除，如果在函数结束后仍然引用这个Block的时候，就需要将它拷贝到堆上。


#### 2、`__block` 说明符

Demo地址：[传送门](https://github.com/xiu619544553/dailyCode/blob/master/block_demo)， Target 选择 `__block修饰局部变量`。

Block中修改捕获的自动变量有两种方法：
* 使用静态变量、静态全局变量、全局变量。从Block语法转化为C语言函数中访问静态全局变量、全局变量，没有任何不同，可以直接访问。而静态变量使用的是静态变量的指针来进行访问。
    * 自动变量不能采用静态变量的做法进行访问。原因是，自动变量是在存储在栈上的，当超出其作用域时，会被栈释放。而静态变量是存储在堆上的，超出作用域时，静态变量没有被释放，所以还可以访问。
* 添加 __block修饰符。__block存储域类说明符。存储域说明符会指定变量存储的域，如栈auto、堆static、全局extern，寄存器register。

比如，上述代码变量前增加 `__block` 修饰符：
`main.m` 代码：
```
typedef void (^MyBlock)(void);

int main(int argc, const char * argv[]) {
    
    __block int age = 10;
    
    NSLog(@"1---%d---%p", age, &age);
    void (^tkBlock)(void) = ^void() {
        age = 20;
        NSLog(@"2---%d---%p", age, &age);
    };
    
    // 执行block
    tkBlock();
    
    // 打印block返回值
    NSLog(@"3---%d---%p", age, &age);
    
    /*
     输出日志：
     2021-11-15 10:06:31.683336+0800 __block修饰局部变量[14738:85460] 1---10---0x7ffeefbff438
     2021-11-15 10:06:31.684054+0800 __block修饰局部变量[14738:85460] 2---20---0x10076ca98
     2021-11-15 10:06:31.684180+0800 __block修饰局部变量[14738:85460] 3---20---0x10076ca98
     
     结论：变量 age 从栈存储位置移动到了堆。
     */
    
    return 0;
}
```

`main.cpp`代码：
```
typedef void (*MyBlock)(void);

struct __Block_byref_age_0 {
    void *__isa;                       // isa指针
    __Block_byref_age_0 *__forwarding; // 指向自己的指针
    int __flags;                       // 标记
    int __size;                        // 结构体大小
    int age;                           // 成员变量，存储age值
};


// Block的定义实现
struct __block_impl {
    void *isa;        // block的类型：全局、栈、堆
    int Flags;
    int Reserved;
    void *FuncPtr;    // 函数的指针！就是通过它调用block的。
};

// Block转换为C函数之后，Block中使用的自动变量会被作为成员变量追加到 __X_block_impl_Y结构体中，其中 X一般是函数名，Y是第几个Block
struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __Block_byref_age_0 *age; // by ref 引用传递
    
    // 构造函数
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;  // 栈类型的block
        impl.Flags = flags;
        impl.FuncPtr = fp;                  // 传入了块函数具体的imp指针（函数指针，最终就是通过函数指针调用block）
        Desc = desc;
    }
};

// Block的块函数也会被编译器生成一个C函数。执行block就是执行这个C函数。
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_age_0 *age = __cself->age; // 通过结构体的self指针拿到age结构体的指针
    
    (age->__forwarding->age) = 20; // 修改结构体指针成员变量的值
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_b3798d_mi_1, (age->__forwarding->age), &(age->__forwarding->age));
}

// block拷贝函数
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}

// block销毁函数
static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};

// main
int main(int argc, const char * argv[]) {
    
    __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_b3798d_mi_0, (age.__forwarding->age), &(age.__forwarding->age));
    
    void (*tkBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0,
                                                              &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age,
                                                              570425344));
    
    
    // block调用，就是通过调用函数指针 FuncPrt 调用 __main_block_func_0 函数
    ((void (*)(__block_impl *))((__block_impl *)tkBlock)->FuncPtr)((__block_impl *)tkBlock);
    
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_b3798d_mi_2, (age.__forwarding->age), &(age.__forwarding->age));
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

block中是如何修改age对应的值：
```
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_age_0 *age = __cself->age; // 通过结构体的self指针拿到age结构体的指针
    (age->__forwarding->age) = 18; // 通过age结构体指针修改age值
}
```

分析：
* 原来的 age变量：int age = 10;
* 现在的 age 变量：`__Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};`
* `__block` 修饰的局部变量，被处理成了一个结构体 `__Block_byref_age_0`，结构体接收的参数包括该结构体的指针变量 `__forwarding`，`Block`块函数内部就是通过这个指针变量修改变量的值的。
* `block` 初始化时传入的是局部变量的地址 `(__Block_byref_age_0 *)&age`，现在就变成了**指针引用**。**引申**：既然你传入的是结构体指针(可以理解为OC对象)，那么`block`就持有了该变量，如果外部对该闭包也有一个强引用，就会造成循环引用。
* 从输出日志看出：`__block` 修饰的局部变量从栈拷贝到了堆、`block`也在堆中。



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

#### 3、`Block` 存储域

从C代码中我们可以看到Block的是指是Block结构体实例，__block变量实质是栈上__block变量结构体实例。从初始化函数中我们可以看到，`impl.isa = &_NSConcreteStackBlock;`，即之前我们使用的是栈Block。

其实，Block有3中类型：
- `_NSConcreteGlobalBlock` 类对象存储在程序的数据区(.data区)。
- `_NSConcreteStackBlock` 类对象存储在栈上。
- `_NSConcreteMallocBlock` 类对象存储在堆上。

```
// 全局block
void (^block0)(void) = ^{
  NSLog(@"Global Block");
};

int main(int argc, const char * argv[]) {
    block0();
    NSLog(@"%@",[block0 class]); // __NSGlobalBlock__
    return 0;
}
```

全局Block，它的实例存储在全局数据区。但是在**函数栈**上创建的Block，如果没有捕获自动变量，Block的结构体实例还是 `__NSGlobalBlock__`，而不是 `__NSMallocBlock__`。

```
// Block没有截获自动变量，Block的结构体实例还是 __NSGlobalBlock__
void (^block1)(void) = ^{
    NSLog(@"xxx");
};
block1();
NSLog(@"block1.class = %@", [block1 class]); // __NSGlobalBlock__


// Block截获自动变量，Block的结构体实例是 __NSMallocBlock__
int a = 1;
void (^block2)(void) = ^{
    NSLog(@"%d", a);
};
block2();
NSLog(@"block2.class = %@", [block2 class]); // __NSMallocBlock__
```

可以看到没有捕获自动变量的Block打印的类是 `NSGlobalBlock`，表示存储在全局数据区。 但为什么捕获自动变量的Block打印的类却是设置在堆上的 `NSMallocBlock`，而非栈上的`NSStackBlock`？这个问题稍后探讨。

设置在栈上的Block，如果超出作用域，Block就会被释放。若 `__block` 变量也配置在栈上，也会有被释放的问题。所以，copy方法调用时，`__block` 变量也被复制到堆上，同时 `impl.isa = &_NSConcreteMallocBlock;`。复制之后，栈上 `__block` 变量的 `__forwarding` 指针会指向堆上的对象。因此 `__block` 变量无论被分配在栈上还是堆上都能够正确访问。

**编译器如何判断何时需要进行copy操作呢？**

在ARC开启时，自动判断进行 **copy**：
- 手动调用copy。
- 将Block作为函数参数返回值返回时，编译器会自动进行 copy。
- 将Block赋值给 copy修饰的id类或者Block类型成员变量，或者__strong修饰的自动变量。
- 方法名含有 `usingBlock` 的 `Cocoa` 框架方法或 `GCD` 相关API传递Block。

如果不能自动 **copy**，则需要我们手动调用 **copy**方法将其复制到堆上。比如向不包括上面提到的方法或函数的参数中传递Block时。

ARC环境下，返回一个对象时会先将该对象复制给一个临时实例指针，然后进行 `retain` 操作，再返回对象指针。`runtime/objc-arr.mm` 提到，Block的 `retain` 操作`objc_retainBlock` 函数实际上是 `Block_copy` 函数。在实行 `retain` 操作`objc_retainBlock` 后，栈上的Block会被复制到堆上，同时返回堆上的地址作为指针赋值给临时变量。

#### 4、`__block`变量存储域

![__block变量存储域](https://github.com/xiu619544553/dailyCode/blob/master/icons/_block变量存储域.png)

当Block从栈复制到堆上时候，__block变量也被复制到堆上并被Block持有。
- 若此时 __block变量已经在堆上，则被该Block持有。
- 若配置在堆上的Block被释放，则它所持有的 __block变量也会被释放。

```
__block int val = 0;
void (^block)(void) = [^{ ++val; } copy];
++val;
block();
```

源码：
```

__attribute__((__blocks__(byref))) __Block_byref_val_0 val = {(void*)0,(__Block_byref_val_0 *)&val, 0, sizeof(__Block_byref_val_0), 0};

id blk = (id)((void (*)())&__main_block_impl_0((void *)__main_block_func_0,
                                               &__main_block_desc_0_DATA,
                                               (__Block_byref_val_0 *)&val,
                                               570425344));

void (*block)(void) = (void (*)())((id (*)(id, SEL))(void *)objc_msgSend)(blk,
                                                                          sel_registerName("copy"));

++(val.__forwarding->val);

((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
```

利用 `copy` 操作，Block和 `__block`变量都从栈上被复制到了堆上。无论是`{ ++val; }`还是 `++val;`都转换成了 `++(val->__forwarding->val);`。
Block中的变量val为复制到堆上的 `__block`变量结构体实例，而Block外的变量val则为复制前栈上的 `__block`变量结构体实例，但这个结构体的 `__forwarding`成员变量指向堆上的 __block变量结构体实例。所以，无论是是在Block内部还是外部使用 `__block`变量，都可以顺利访问同一个 `__block`变量。

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

### 六、面试题
##### 问题1

以下代码存在内存泄漏吗？
```
- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *__weak center = [NSNotificationCenter defaultCenter];
    id token = [center addObserverForName:UIApplicationDidEnterBackgroundNotification
                                   object:nil
                                    queue:[NSOperationQueue mainQueue]
                               usingBlock:^(NSNotification * _Nonnull note) {
        [self doSomething];
        [center removeObserver:token];
    }];
}

- (void)doSomething {   
}
```

参考资料：
- [iOS下的闭包上篇-Block](https://mp.weixin.qq.com/s/LdaQxl3ZI1uXN9GvoH2sXg)
- [Block和函数指针的区别](https://blog.csdn.net/dexin5195/article/details/41083323)
- [一道Block面试题的深入挖掘](https://juejin.cn/post/6844904145283973127#heading-9)