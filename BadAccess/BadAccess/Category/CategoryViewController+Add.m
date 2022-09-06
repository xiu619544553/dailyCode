//
//  CategoryViewController+Add.m
//  viptemp
//
//  Created by hello on 2022/8/31.
//

#import "CategoryViewController+Add.h"
#import <objc/runtime.h> // 导入 runtime 库

@implementation CategoryViewController (Add)

/// 关联 count 属性
- (void)setCount:(NSInteger)count {
    objc_setAssociatedObject(self, @selector(count), @(count), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)count {
    return [objc_getAssociatedObject(self, @selector(count)) integerValue];
}

/// 关联 code 属性
- (void)setCode:(NSNumber *)code {
    objc_setAssociatedObject(self, @selector(code), code, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSNumber *)code {
    return objc_getAssociatedObject(self, @selector(code));
}

/// 关联 identifier 属性
- (void)setIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, @selector(identifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)identifier {
    return objc_getAssociatedObject(self, @selector(identifier));
}

@end
