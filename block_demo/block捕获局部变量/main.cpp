
typedef void (*MyBlock)(void);

// Block的定义实现
struct __block_impl {
    void *isa;     // block的类型：全局、栈、堆
    int Flags;
    int Reserved;
    void *FuncPtr; // 函数的指针！就是通过它调用block的。
};

// Block转换为C函数之后，Block中使用的自动变量会被作为成员变量追加到 __X_block_impl_Y 结构体中，其中 X一般是函数名，Y是第几个Block
struct __main_block_impl_0 {
    struct __block_impl impl;           // block的函数的imp结构体
    struct __main_block_desc_0* Desc;   // block的信息
    int age;                            // 值引用的age值
    
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
        impl.isa = &_NSConcreteStackBlock;  // 栈类型的block
        impl.Flags = flags;
        impl.FuncPtr = fp;                  // 传入了块函数具体的imp指针（函数指针，最终就是通过函数指针调用block）
        Desc = desc;
    }
};

// Block的块函数也会被编译器生成一个C函数。执行block就是执行这个C函数。它就是 `struct __block_impl ->FuncPrt` 函数指针IMPL
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    int age = __cself->age; // bound by copy 值传递
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_ff21bc_mi_0, age);
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};

int main(int argc, const char * argv[]) {
    
    int age = 10;
    MyBlock block = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age));
    age = 18;
    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
    
    return 0;
}

