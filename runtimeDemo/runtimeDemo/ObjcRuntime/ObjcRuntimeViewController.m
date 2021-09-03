//
//  ObjcRuntimeViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/6/17.
//

#import "ObjcRuntimeViewController.h"
#import <objc/runtime.h>

#import "Test.h"
#import "MyClass.h"

@interface ObjcRuntimeViewController ()

@end

@implementation ObjcRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // MARK: 动态注册一个类
    [[Test new] ex_registerClassPair];
    
    
    // Class 是结构体指针 typedef objc_class *Class
    /*
     struct objc_class {
         Class _Nonnull isa  OBJC_ISA_AVAILABILITY;

     #if !__OBJC2__
         Class _Nullable super_class                              OBJC2_UNAVAILABLE;
         const char * _Nonnull name                               OBJC2_UNAVAILABLE;
         long version                                             OBJC2_UNAVAILABLE;
         long info                                                OBJC2_UNAVAILABLE;
         long instance_size                                       OBJC2_UNAVAILABLE;
         struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE;
         struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;
         struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE;
         struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
     #endif

     } OBJC2_UNAVAILABLE;
     */
    
    // MARK: 类相关操作函数
    NSLog(@"===========类相关操作函数=============");
    
    Class cls = [self class];
    
    // class_getName 获取类名
    NSLog(@"class_getName: %s", class_getName(cls));  // ViewController
    NSLog(@"class_getName: %s", class_getName(nil));  // nil
    NSLog(@"objc_getMetaClass: %@", objc_getMetaClass(NSStringFromClass([self class]).UTF8String));
    
    // 获取父类，一般通过 self.superclass 获取
    NSLog(@"class_getSuperclass: %@", class_getSuperclass([self class]));
    
    
    // 实例变量大小，单位/字节
    NSLog(@"class_getInstanceSize: %zu", class_getInstanceSize(cls));
    
    // MARK: 成员变量(ivars)
    /*
     struct objc_ivar {
         char * _Nullable ivar_name                               OBJC2_UNAVAILABLE;
         char * _Nullable ivar_type                               OBJC2_UNAVAILABLE;
         int ivar_offset                                          OBJC2_UNAVAILABLE;
     #ifdef __LP64__
         int space                                                OBJC2_UNAVAILABLE;
     #endif
     }
     */
    Ivar var1 = class_getInstanceVariable([self class], "");
    
    
    // MARK: 属性
    
    
    // MARK: 方法
    
//    class_copyMethodList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
//    method_setImplementation(<#Method  _Nonnull m#>, <#IMP  _Nonnull imp#>)
//    class_replaceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
    
    [self test];
    
    [self dynamicCreateClass];
}

#pragma mark - 输出
- (void)test {
    NSLog(@"=================类与对象操作函数====================");
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    
    // 类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"==========================================================");
    
    // 父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    
    // 是否是元类
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    NSLog(@"==========================================================");
    
    // 这里需要注意的是：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已。
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
    NSLog(@"==========================================================");
    
    // 变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
    }
    NSLog(@"==========================================================");
    
    // 属性操作
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    NSLog(@"==========================================================");
    
    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", method_getName(classMethod));
    }
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"==========================================================");
    
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"==========================================================");
}

#pragma mark - 动态创建类

void imp_submethod1(id self, SEL _cmd) {
    NSLog(@"%@ %s", self, __func__);
}

- (void)dynamicCreateClass {
    
    Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
}

#pragma mark - AFN

+ (void)swizzleResumeAndSuspendMethodForClass:(Class)theClass {
    Method afResumeMethod = class_getInstanceMethod(self, @selector(af_resume));
    Method afSuspendMethod = class_getInstanceMethod(self, @selector(af_suspend));

    if (af_addMethod(theClass, @selector(af_resume), afResumeMethod)) {
        af_swizzleSelector(theClass, @selector(resume), @selector(af_resume));
    }

    if (af_addMethod(theClass, @selector(af_suspend), afSuspendMethod)) {
        af_swizzleSelector(theClass, @selector(suspend), @selector(af_suspend));
    }
}

static inline void af_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

static inline BOOL af_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

#pragma mark - YYKit

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

@end
