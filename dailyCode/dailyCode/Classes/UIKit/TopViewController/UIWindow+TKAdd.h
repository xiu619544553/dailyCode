//
//  UIWindow+TKAdd.h
//  test
//
//  Created by hello on 2020/6/2.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (TKAdd)

/// 获取窗口最顶层的控制器
+ (UIViewController *)topViewController;

@end

NS_ASSUME_NONNULL_END
