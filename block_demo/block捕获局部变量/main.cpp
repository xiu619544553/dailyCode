
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
