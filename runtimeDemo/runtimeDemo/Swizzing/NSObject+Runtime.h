//
//  NSObject+Runtime.h
//  RuntimeDemo
//
//  Created by hello on 2021/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end

NS_ASSUME_NONNULL_END
