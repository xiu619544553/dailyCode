//
//  NSObject+YHZombiesNSObject.m
//  viptemp
//
//  Created by hello on 2022/9/5.
//

#import "NSObject+YHZombiesNSObject.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (YHZombiesNSObject)

+ (void)load {
    [self __YHZobiesObject];
}

+ (void)__YHZobiesObject {
    char *clsChars = "NSObject";
    Class cls = objc_lookUpClass(clsChars);
    Method oriMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"__YHDealloc_zombie"));
    method_exchangeImplementations(oriMethod, newMethod);
    
}

- (void)__YHDealloc_zombie {
    const char *className = object_getClassName(self);
    char *zombieClassName = NULL;
    asprintf(&zombieClassName, "_YHZombie_%s", className);
    Class zombieClass = objc_getClass(zombieClassName);
    if (zombieClass == Nil) {
        zombieClass = objc_duplicateClass(objc_getClass("_YHZombie_"), zombieClassName, 0);
    }
    // 'objc_destructInstance'不可用:在自动引用计数模式下不可用
    // 销毁一个类的实例，但不释放内存；并删除它的任何关联引用。
//    objc_destructInstance(self);
    object_setClass(self, zombieClass);
    if (zombieClassName != NULL)
    {
        free(zombieClassName);
    }
}

@end
