//
//  TestForwardFlow.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/9.
//

#import "TestForwardFlow.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface TestForwardHelper : NSObject
- (void)printUserInfo;
@end

@implementation TestForwardHelper
- (void)printUserInfo { NSLog(@"%s", __func__); }
@end


@implementation TestForwardFlow {
    TestForwardHelper *_helper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _helper = [TestForwardHelper new];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self performSelector:@selector(printUserInfo)];
#pragma clang diagnostic pop
        
        /*
         /// 这2个方法，允许开发者动态地为给定的选择器提供一个实现。
         /// @params 动态解析的方法
         /// @return 如果找到方法并添加到接收端，则为“是”，否则为“否”。
         + (BOOL)resolveClassMethod:(SEL)sel;
         + (BOOL)resolveInstanceMethod:(SEL)sel;
         */
    }
    return self;
}

#pragma mark - 消息转发

//+ (BOOL)resolveClassMethod:(SEL)sel {
//    return [super resolveClassMethod:sel];
//}

//- (void)commonFunction {
//    NSLog(@"%@, %p", self, _cmd);
//}

/// 动态地为实例方法提供给定选择器的实现。
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSString *selectorName = NSStringFromSelector(sel);
//
//    if ([selectorName isEqualToString:@"printUserInfo"]) {
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//        SEL commonSEL = @selector(commonFunction);
//#pragma clang diagnostic pop
//
//        Method commonM = class_getInstanceMethod(self, commonSEL);
//
//        const char *types = method_getTypeEncoding(commonM);
//
//        class_addMethod(self,
//                        sel,
//                        class_getMethodImplementation(self, commonSEL),
//                        types);
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//
//    NSLog(@"%s", __func__);
//
//    NSString *selectorString = NSStringFromSelector(aSelector);
//
//    // 将消息转发给_helper来处理
//    if (selectorString.length > 0 && [selectorString isEqualToString:@"printUserInfo"]) {
//        return _helper;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


/// 返回一个NSMethodSignature对象，该对象包含由给定选择器标识的方法的描述。
/// @param aSelector 方法选择器
/// @return 返回一个NSMethodSignature实例对象，包含由aSelector识别的方法的描述，如果找不到该方法，则为nil。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSLog(@"%s", __func__);
    
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature) { // 如果 signature 为空，则表示当前类没有实现 aSelector。我们可以找一个实现了 aSelector 实例对象，构建一个新的 signature
        if ([TestForwardHelper instancesRespondToSelector:aSelector]) {
            signature = [TestForwardHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSLog(@"%s", __func__);
    
    if ([TestForwardHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
}

@end
