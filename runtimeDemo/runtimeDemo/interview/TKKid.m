//
//  TKKid.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/6.
//

#import "TKKid.h"

@implementation TKKid

/*
 命令行：
 clang -rewrite-objc -fobjc-arc -stdlib=libc++ -mmacosx-version-min=10.7 -fobjc-runtime=macosx-10.7 -Wno-deprecated-declarations Kid.m
 
 static instancetype _I_Kid_init(Kid * self, SEL _cmd) {
     self = ((Kid *(*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("TKKid"))}, sel_registerName("init"));
     if (self) {
         NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_Kid_559e82_mi_0, ((Class (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("class")));
         NSLog((NSString *)&__NSConstantStringImpl__var_folders_w6_rqg0sssn073dr4gcpk36rvh80000gn_T_Kid_559e82_mi_1, ((Class (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("TKKid"))}, sel_registerName("class")));
     }
     return self;
 }
 
 */


/*
 struct __rw_objc_super {
     struct objc_object *object;
     struct objc_object *superClass;
     __rw_objc_super(struct objc_object *o, struct objc_object *s) : object(o), superClass(s) {}
 };
 
 
 /// Specifies the superclass of an instance.
 struct objc_super {
     __unsafe_unretained _Nonnull id receiver; // 消息接受者
     __unsafe_unretained _Nonnull Class super_class; // 消息接受者的父类
 };
 
 
 // NSLog(@"%@", [self class]);
 ((Class (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("class"));
 
 // NSLog(@"%@", [super class]);
 ((Class (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("TKKid"))}, sel_registerName("class"));
 
 
 分析：
 [self class]、[super class] 调用的是 NSObject 协议中的 `- (Class)class` 方法。
 
 查看源码：
 - (Class)class {
     return object_getClass(self);
 }
 

 // 获取当前对象的类对象
 Class object_getClass(id obj) {
     if (obj) return obj->getIsa();
     else return Nil;
 }
 
 */


- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%@", [self class]);
        NSLog(@"%@", [super class]);
        NSLog(@"%@", [super superclass]);
    }
    return self;
}

@end
