//
//  ObjcRuntimeViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/6/17.
//

/*
 typedef objc_class *Class;
 struct objc_class {
     Class _Nonnull isa;           // 指向 metaClass-元类
     Class _Nullable super_class;  // 父类
     const char * _Nonnull name;   // 缓存最近使用过的方法
     long version;                 // 版本信息
     long info;
     long instance_size;
     struct objc_ivar_list * _Nullable ivars;
     struct objc_method_list * _Nullable * _Nullable methodLists;
     struct objc_cache * _Nonnull cache;
     struct objc_protocol_list * _Nullable protocols;
 }
 
 struct objc_cache {
    unsigned int mask;      // total = mask + 1。
    unsigned int occupied;  // 实际占用的缓存bucket的总数
    Method buckets[1];      // 指向Method数据结构指针的数组
 };
 
 关于 mask：一个整数，指定分配的缓存bucket的总数。在方法查找过程中，Objective-C runtime使用这个字段来确定开始线性查找数组的索引位置。指向方法selector的指针与该字段做一个AND位操作(index = (mask & selector))。这可以作为一个简单的hash散列算法。
 
 */

#import "ObjcRuntimeViewController.h"
#import <objc/runtime.h>

#import "Test.h"
#import "MyClass.h"

typedef NS_ENUM(NSInteger, ObjcRuntimeBtnTag) {
    ObjcRuntimeBtnTagRuntimeAPI = 1,
    ObjcRuntimeBtnTagDynamicRegisterClass1,
    ObjcRuntimeBtnTagDynamicRegisterClass2,
    ObjcRuntimeBtnTagDynamicCreateInstance,
    ObjcRuntimeBtnTagInstanceOperation,
    ObjcRuntimeBtnTagGetClassList
};

@interface ObjcRuntimeViewController ()

@end

@implementation ObjcRuntimeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 1. runtime api
    CGRect btn1Rect = CGRectMake(20.f, 20.f, self.view.bounds.size.width - 40.f, 35.f);
    [self btnWithTag:ObjcRuntimeBtnTagRuntimeAPI title:@"1. runtime api" frame:btn1Rect];
    
    // 2. 动态创建类（一）
    CGRect btn2Rect = CGRectMake(CGRectGetMinX(btn1Rect), CGRectGetMaxY(btn1Rect) + 15.f, CGRectGetWidth(btn1Rect), CGRectGetHeight(btn1Rect));
    [self btnWithTag:ObjcRuntimeBtnTagDynamicRegisterClass1 title:@"2. 动态创建类（一）" frame:btn2Rect];
    
    // 3. 动态创建类（二）
    CGRect btn3Rect = CGRectMake(CGRectGetMinX(btn2Rect), CGRectGetMaxY(btn2Rect) + 15.f, CGRectGetWidth(btn2Rect), CGRectGetHeight(btn2Rect));
    [self btnWithTag:ObjcRuntimeBtnTagDynamicRegisterClass2 title:@"3. 动态创建类（二）" frame:btn3Rect];
    
    // 4. 动态创建对象
    CGRect btn4Rect = CGRectMake(CGRectGetMinX(btn3Rect), CGRectGetMaxY(btn3Rect) + 15.f, CGRectGetWidth(btn3Rect), CGRectGetHeight(btn3Rect));
    [self btnWithTag:ObjcRuntimeBtnTagDynamicCreateInstance title:@"4. 动态创建对象" frame:btn4Rect];
    
    // 5.实例操作函数
    CGRect btn5Rect = CGRectMake(CGRectGetMinX(btn4Rect), CGRectGetMaxY(btn4Rect) + 15.f, CGRectGetWidth(btn4Rect), CGRectGetHeight(btn4Rect));
    [self btnWithTag:ObjcRuntimeBtnTagInstanceOperation title:@"5.实例操作函数" frame:btn5Rect];
    
    // 6.获取类定义
    CGRect btn6Rect = CGRectMake(CGRectGetMinX(btn5Rect), CGRectGetMaxY(btn5Rect) + 15.f, CGRectGetWidth(btn5Rect), CGRectGetHeight(btn5Rect));
    [self btnWithTag:ObjcRuntimeBtnTagGetClassList title:@"6.获取类定义" frame:btn6Rect];
    
}

- (void)btnAction:(UIButton *)sender {
    
    ObjcRuntimeBtnTag tag = sender.tag;
    
    switch (tag) {
        case ObjcRuntimeBtnTagRuntimeAPI:
            [self runtimeAPI];
            break;
            
        case ObjcRuntimeBtnTagDynamicRegisterClass1:
            [self dynamicCreateClass1];
            break;
            
        case ObjcRuntimeBtnTagDynamicRegisterClass2:
            [self dynamicCreateClass2];
            break;
            
        case ObjcRuntimeBtnTagDynamicCreateInstance:
            [self dynamicCreateInstance];
            break;
            
        case ObjcRuntimeBtnTagInstanceOperation:
            [self instanceOperation];
            break;
            
        case ObjcRuntimeBtnTagGetClassList:
            [self getClassList];
            break;
            
        default:
            break;
    }
}

#pragma mark - 输出
- (void)runtimeAPI {
    NSLog(@"=====================类与对象操作函数========================");
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0; // 数组长度
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
    NSLog(@"%s's meta-class is %s❌", class_getName(cls), class_getName(meta_class));
    NSLog(@"==========================================================");
    
    // 变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    
    // MARK: 成员变量
    /*
     typedef struct objc_ivar *Ivar;
     struct objc_ivar {
         char * _Nullable ivar_name;
         char * _Nullable ivar_type;
         int ivar_offset;
     }
     
     // 获取类中指定名称实例成员变量的信息
     Ivar class_getInstanceVariable ( Class cls, const char *name );
     // 获取类成员变量的信息
     Ivar class_getClassVariable ( Class cls, const char *name );
     // 添加成员变量
     BOOL class_addIvar ( Class cls, const char *name, size_t size, uint8_t alignment, const char *types );
     // 获取整个成员变量列表
     Ivar * class_copyIvarList ( Class cls, unsigned int *outCount );
     */
    // ivars是一个数组，数组中每个元素是指向Ivar(变量信息)的指针。outCount是数组的长度
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d，ivar_offset: %td，ivar_type: %s", ivar_getName(ivar),
                                                                                            i,
                                                                                            ivar_getOffset(ivar),
                                                                                            ivar_getTypeEncoding(ivar));
    }
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
    }
    NSLog(@"==========================================================");
    
    
    // MARK: 属性
    /*
     typedef struct objc_property *objc_property_t;
     typedef struct property_t *objc_property_t;
     
     struct property_t {
         const char *name;
         const char *attributes;
     };
     
     // 获取指定的属性
     objc_property_t class_getProperty ( Class cls, const char *name );
     // 获取属性列表
     objc_property_t * class_copyPropertyList ( Class cls, unsigned int *outCount );
     // 为类添加属性
     BOOL class_addProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
     // 替换类的属性
     void class_replaceProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
     */
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s，attributes: %s", property_getName(property),
                                                      property_getAttributes(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    NSLog(@"==========================================================");
    
    
    // MARK: 方法
    /*
     typedef struct objc_method *Method;
     
     struct method_t {
         SEL name;
         const char *types;
         MethodListIMP imp;
        ...
     };
     
     // 添加方法
     // class_addMethod的实现会覆盖父类的方法实现，但不会取代本类中已存在的实现.
     // 如果本类中包含一个同名的实现，则函数会返回NO。
     // 如果要修改已存在实现，可以使用method_setImplementation。一个Objective-C方法是一个简单的C函数，它至少包含两个参数–self和_cmd。
     BOOL class_addMethod ( Class cls, SEL name, IMP imp, const char *types );
     
     // 获取实例方法
     Method class_getInstanceMethod ( Class cls, SEL name );
     // 获取类方法
     Method class_getClassMethod ( Class cls, SEL name );
     // 获取所有方法的数组
     Method * class_copyMethodList ( Class cls, unsigned int *outCount );
     // 替代方法的实现。types是一个描述传递给方法的参数类型的字符数组 。
     IMP class_replaceMethod ( Class cls, SEL name, IMP imp, const char *types );
     // 返回方法的具体实现
     IMP class_getMethodImplementation ( Class cls, SEL name );
     IMP class_getMethodImplementation_stret ( Class cls, SEL name );
     // 类实例是否响应指定的selector
     BOOL class_respondsToSelector ( Class cls, SEL sel );
     

     注意⚠️
     与成员变量不同的是，我们可以为类动态添加方法，不管这个类是否已存在。
     
     
     * class_getInstanceMethod、class_getClassMethod函数，与class_copyMethodList不同的是，这两个函数都会去搜索父类的实现。

     * class_copyMethodList函数，返回包含所有实例方法的数组，如果需要获取类方法，则可以使用class_copyMethodList(object_getClass(cls), &count)(一个类的实例方法是定义在元类里面)。该列表不包含父类实现的方法。outCount参数返回方法的个数。在获取到列表后，我们需要使用free()方法来释放它。

     *  class_replaceMethod函数，该函数的行为可以分为两种：如果类中不存在name指定的方法，则类似于class_addMethod函数一样会添加方法；如果类中已存在name指定的方法，则类似于method_setImplementation一样替代原方法的实现。

     * class_getMethodImplementation函数，该函数在向类实例发送消息时会被调用，并返回一个指向方法实现函数的指针。这个函数会比method_getImplementation(class_getInstanceMethod(cls, name))更快。返回的函数指针可能是一个指向runtime内部的函数，而不一定是方法的实际实现。例如，如果类实例无法响应selector，则返回的函数指针将是运行时消息转发机制的一部分。

     class_respondsToSelector函数，我们通常使用NSObject类的respondsToSelector:或instancesRespondToSelector:方法来达到相同目的。
     */
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %@，TypeEncoding: %s", NSStringFromSelector(method_getName(method)), method_getTypeEncoding(method));
    }
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %@", NSStringFromSelector(method_getName(method1)));
    }
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %@", NSStringFromSelector(method_getName(classMethod)));
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
#pragma clang diagnostic pop
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"==========================================================");
    
    
    // MARK: 协议
    /*
     // 添加协议
     BOOL class_addProtocol ( Class cls, Protocol *protocol );
     // 返回类是否实现指定的协议
     BOOL class_conformsToProtocol ( Class cls, Protocol *protocol );
     // 返回类实现的协议列表
     Protocol * class_copyProtocolList ( Class cls, unsigned int *outCount );
     */
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"==========================================================");
    
    
    // MARK: 版本
    /*
     // 获取版本号
     int class_getVersion ( Class cls );
     // 设置版本号
     void class_setVersion ( Class cls, int version );

     */
}


#pragma mark - 动态创建类1

void imp_submethod1(id self, SEL _cmd) {
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass); // 获取对象的isa
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}

- (void)dynamicCreateClass1 {
    
    /*
     
     // 创建一个新类和元类
     // 如果我们要创建一个根类，则superclass指定为Nil。extraBytes通常指定为0，该参数是分配给类和元类对象尾部的索引ivars的字节数。
     Class objc_allocateClassPair ( Class superclass, const char *name, size_t extraBytes );
     
     // 销毁一个类及其相关联的类。注意⚠️，如果程序运行中还存在类或其子类的实例，则不能调用针对类调用该方法。
     void objc_disposeClassPair ( Class cls );
     
     // 在应用中注册由objc_allocateClassPair创建的类
     void objc_registerClassPair ( Class cls );
     
     
     动态创建类流程：
     1、objc_allocateClassPair
        如果我们要创建一个根类，则superclass指定为Nil。extraBytes通常指定为0，该参数是分配给类和元类对象尾部的索引ivars的字节数。
     2、然后使用诸如class_addMethod、class_addIvar等函数来为新创建的类添加方法、实例变量和属性等。
     3、完成这些后，我们需要调用objc_registerClassPair函数来注册类，之后这个新类就可以在程序中使用了。
     
     实例方法和实例变量应该添加到类自身上，而类方法应该添加到类的元类上。
     
     */
    
    Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
#pragma clang diagnostic pop
    
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    id instance = [[cls alloc] init];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
#pragma clang diagnostic pop
}


#pragma mark - 动态创建类2

void TestMetaClass(id self, SEL _cmd) {
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass); // 获取对象的isa
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}

- (void)dynamicCreateClass2 {
    
    // 创建一个新类和元类
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);

    if (newClass == nil) {
        NSLog(@"不能创建类，想要的名称已经在使用中。");
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
#pragma clang diagnostic pop
    
    objc_registerClassPair(newClass);
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [instance performSelector:@selector(testMetaClass)];
#pragma clang diagnostic pop
    
    Class currentClass = objc_getMetaClass((__bridge void*)[self class]);
    NSLog(@"objc_getMetaClass: %@", currentClass);
    
    // objc[58500]: class `\250_\314' not linked into application
    
    Class cls = NSClassFromString(@"TestClass");
    NSLog(@"cls: %@", cls);
}

#pragma mark - 动态创建对象

- (void)dynamicCreateInstance {
    /*
     // 创建类实例
     // 创建实例时，会在默认的内存区域为类分配内存。extraBytes参数表示分配的额外字节数。这些额外的字节可用于存储在类定义中所定义的实例变量之外的实例变量。⚠️该函数在ARC环境下无法使用。
     id class_createInstance ( Class cls, size_t extraBytes );
     
     // 在指定位置创建类实例
     id objc_constructInstance ( Class cls, void *bytes );
     
     // 销毁类实例
     void * objc_destructInstance ( id obj );
     */
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
     
    id str1 = [theObject init];
    NSLog(@"%@", [str1 class]);
    
    id str2 = [[NSString alloc] initWithString:@"test"];
    NSLog(@"%@", [str2 class]); // 簇中的默认占位符类 __NSCFConstantString
}

#pragma mark - 实例操作函数

- (void)instanceOperation {
    /*
     1.针对整个对象进行操作的函数，这类函数包含
     
     // 返回指定对象的一份拷贝
     id object_copy ( id obj, size_t size );
     
     // 释放指定对象占用的内存
     id object_dispose ( id obj );
     */
    
    /*
     2.针对对象实例变量进行操作的函数，这类函数包含：
     // 修改类实例的实例变量的值
     Ivar object_setInstanceVariable ( id obj, const char *name, void *value );
     // 获取对象实例变量的值
     Ivar object_getInstanceVariable ( id obj, const char *name, void **outValue );
     // 返回指向给定对象分配的任何额外字节的指针
     void * object_getIndexedIvars ( id obj );
     // 返回对象中实例变量的值
     id object_getIvar ( id obj, Ivar ivar );
     // 设置对象中实例变量的值
     void object_setIvar ( id obj, Ivar ivar, id value );
     
     如果实例变量的Ivar已经知道，那么调用object_getIvar会比object_getInstanceVariable函数快，相同情况下，object_setIvar也比object_setInstanceVariable快。
     */
    
    /*
     3.针对对象的类进行操作的函数，这类函数包含：
     
     // 返回给定对象的类名
     const char * object_getClassName ( id obj );
     
     // 返回对象的类
     Class object_getClass ( id obj );
     
     // 设置对象的类
     Class object_setClass ( id obj, Class cls );
     */
}

#pragma mark - 获取类定义

NSArray<Class> *GetAllSubclasses(Class cls, BOOL includeSelf) {
    
    if (!cls) {
        return nil;
    }
    
    Class *buffer = NULL;
    
    int count, size;
    do {
        count  = objc_getClassList(NULL, 0);
        buffer = (Class *)realloc(buffer, count * sizeof(*buffer));
        size   = objc_getClassList(buffer, count);
        
    } while (size != count);
    
    NSMutableArray *classes = [NSMutableArray new];
    if (includeSelf) {
        [classes addObject:cls];
    }
    
    for (int i = 0; i < count; i++) {
        Class candidate = buffer[i];
        Class superclass = candidate;
        
        // 我们不能假设从该函数中获取的类对象是继承自NSObject体系的，所以在这些类上调用方法是，都应该先检测一下这个方法是否在这个类中实现。
        while ((superclass = class_getSuperclass(superclass))) {
            if (superclass == cls) {
                [classes addObject:candidate];
                break;
            }
        }
    }
    
    free(buffer);
    return classes.copy;
}

+ (NSArray *)subclassesOfClass:(Class)parentClass {
    
    if (!parentClass) {
        return nil;
    }
    
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = (Class*)malloc(sizeof(Class) * numClasses);
    
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++) {
        
        Class cls = classes[i];
        
        do {
            cls = class_getSuperclass(cls);
        } while (cls && cls != parentClass);
        
        
        if (cls) {
            [result addObject:classes[i]];
        }
    }
    
    free(classes);
    
    return [result copy];
}

- (void)getClassList {
    /*
     Objective-C动态运行库会自动注册我们代码中定义的所有的类。我们也可以在运行时创建类定义并使用objc_addClass函数来注册它们。runtime提供了一系列函数来获取类定义相关的信息，这些函数主要包括：
     
     // 获取已注册的类定义的列表
     // 我们不能假设从该函数中获取的类对象是继承自NSObject体系的，所以在这些类上调用方法是，都应该先检测一下这个方法是否在这个类中实现。
     // @params buffer 可以通过传递NULL来获得注册类定义的总数，而不需要实际检索任何类定义。
     int objc_getClassList ( Class *buffer, int bufferCount );
     
     // 创建并返回一个指向所有已注册类的指针列表
     Class * objc_copyClassList ( unsigned int *outCount );
     
     // 返回指定类的类定义
     Class objc_lookUpClass ( const char *name );
     Class objc_getClass ( const char *name );
     Class objc_getRequiredClass ( const char *name );
     
     // 返回指定类的元类
     Class objc_getMetaClass ( const char *name );
     */
    
    /*
     * 获取类定义的方法有三个：objc_lookUpClass、objc_getClass、objc_getRequiredClass。
     如果类在运行时未注册，则objc_lookUpClass会返回nil，而objc_getClass会调用类处理回调，并再次确认类是否注册，如果确认未注册，再返回nil。而objc_getRequiredClass函数的操作与objc_getClass相同，只不过如果没有找到类，则会杀死进程。
     
     * objc_getMetaClass函数：如果指定的类没有注册，则该函数会调用类处理回调，并再次确认类是否注册，如果确认未注册，再返回nil。不过，每个类定义都必须有一个有效的元类定义，所以这个函数总是会返回一个元类定义，不管它是否有效。
     
     */
    
    GetAllSubclasses([NSObject class], YES);
    return;
    
    int numClasses;
    Class * classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0) {
        
        classes = (Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        NSLog(@"number of classes: %d", numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            Class cls = classes[i];
            NSLog(@"class name: %s", class_getName(cls));
        }
        free(classes);
    }
}


#pragma mark - Private Methods

- (UIButton *)btnWithTag:(ObjcRuntimeBtnTag)tag
                   title:(NSString *)title
                   frame:(CGRect)frame {
    UIButton *btn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = tag;
        btn.frame = frame;
        btn.backgroundColor = UIColor.orangeColor;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        btn;
    });
    
    return btn;
}
@end
