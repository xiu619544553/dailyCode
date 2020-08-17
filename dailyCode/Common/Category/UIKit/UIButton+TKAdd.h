//
//  UIButton+TKAdd.h
//  dailyCode
//
//  Created by hello on 2020/8/6.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TKAdd)

@end


#pragma mark - 增大按钮点击区域
@interface UIButton (TKExpandClickArea)

/// 增大按钮点击区域。默认 UIEdgeZero
@property (nonatomic, assign) UIEdgeInsets touchInsets;

@end

NS_ASSUME_NONNULL_END
