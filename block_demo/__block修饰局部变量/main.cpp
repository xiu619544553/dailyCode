

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

