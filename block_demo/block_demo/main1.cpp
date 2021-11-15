

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __block0_block_impl_0 {
    struct __block_impl impl;
    struct __block0_block_desc_0* Desc;
    __block0_block_impl_0(void *fp, struct __block0_block_desc_0 *desc, int flags=0) {
        impl.isa = &_NSConcreteGlobalBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __block0_block_func_0(struct __block0_block_impl_0 *__cself) {
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_main_8096fb_mi_0);
}

static struct __block0_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __block0_block_desc_0_DATA = { 0, sizeof(struct __block0_block_impl_0)};
static __block0_block_impl_0 __global_block0_block_impl_0((void *)__block0_block_func_0, &__block0_block_desc_0_DATA);
void (*block0)(void) = ((void (*)())&__global_block0_block_impl_0);

struct __Block_byref_val_0 {
    void *__isa;
    __Block_byref_val_0 *__forwarding;
    int __flags;
    int __size;
    int val;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __Block_byref_val_0 *val; // by ref
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_val_0 *_val, int flags=0) : val(_val->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_val_0 *val = __cself->val; // bound by ref
    ++(val->__forwarding->val); }
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->val, (void*)src->val, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->val, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};


int main(int argc, const char * argv[]) {
    
    /*
     __block int val = 0;
     void (^block)(void) = [^{ ++val; } copy];
     ++val;
     block();
     */

__attribute__((__blocks__(byref))) __Block_byref_val_0 val = {(void*)0,(__Block_byref_val_0 *)&val, 0, sizeof(__Block_byref_val_0), 0};

id blk = (id)((void (*)())&__main_block_impl_0((void *)__main_block_func_0,
                                               &__main_block_desc_0_DATA,
                                               (__Block_byref_val_0 *)&val,
                                               570425344));

void (*block)(void) = (void (*)())((id (*)(id, SEL))(void *)objc_msgSend)(blk,
                                                                          sel_registerName("copy"));

++(val.__forwarding->val);

((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
    
    return 0;
}
