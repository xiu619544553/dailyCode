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
