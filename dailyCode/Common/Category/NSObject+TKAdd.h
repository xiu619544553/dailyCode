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

static inline void tk_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    if (!theClass || !originalSelector || !swizzledSelector) return;
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    if (!originalMethod || !swizzledMethod) return;
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@interface NSObject (TKAdd)

@end

NS_ASSUME_NONNULL_END
