//
//  NSObject+TKAdd.h
//  test
//
//  Created by hello on 2020/7/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/// 交换方法
static inline void tk_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    if (!theClass || !originalSelector || !swizzledSelector) return;
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    if (!originalMethod || !swizzledMethod) return;
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@interface NSObject (TKAdd)

@end


#pragma mark - 随机数
@interface NSObject (TKRandomNumber)

/// 生成随机数，范围在 [from,to]
/// @param from 左闭区间
/// @param to   右闭区间
- (uint64_t)getRandomNumber:(uint64_t)from to:(uint64_t)to;


/// 生成随机数
/// @param from            左区间
/// @param to              右区间
/// @param isContainFrom   左区间是否为闭区间。YES闭区间，NO开区间
/// @param isContainFromTo 右区间是否为闭区间。YES闭区间，NO开区间
- (uint64_t)getRandomNumber:(uint64_t)from to:(uint64_t)to isContainFrom:(BOOL)isContainFrom isContainFromTo:(BOOL)isContainFromTo;

@end

NS_ASSUME_NONNULL_END
