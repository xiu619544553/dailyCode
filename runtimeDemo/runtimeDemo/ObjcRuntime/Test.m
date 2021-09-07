//
//  Test.m
//  RuntimeDemo
//
//  Created by hello on 2021/6/17.
//

#import "Test.h"
#import <objc/runtime.h>

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

@implementation Test


- (void)ex_registerClassPair {
    // 创建一个新类和元类
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);

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

@end
