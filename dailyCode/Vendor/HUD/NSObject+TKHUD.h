//
//  NSObject+TKHUDHUD.h
//  Yeso
//
//  Created by FW on 2017/3/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface NSObject (TKHUD) <MBProgressHUDDelegate>

/// 特殊定义吐司提示 font 不传时默认为15号常规字体
- (void)showHudText:(NSString *)text afterDelay:(NSTimeInterval)delay font:(UIFont *)font;

/// 展示吐司提示信息 (默认提示两秒)
- (void)showHudText:(NSString *)text;

/// 展示吐司提示信息 (默认提示两秒) 展示在那个视图上
- (void)showHudText:(NSString *)text onView:(UIView *)view;

/// 吐司提示不隐藏
- (void)showHudNoHidden:(NSString *)text;
- (void)hiddenHud;

/// 展示菊花进度 （转菊花时一般是等待操作，所以禁止用户操作）
- (void)showActivity;
- (void)showActivityWithText:(NSString *)text;

- (MBProgressHUD *)showActivityWithText:(NSString *)text onView:(UIView *)view;

/// 是否现在有展示的MB
- (BOOL)hudIsShowing;

/// 隐藏菊花进度
- (void)hidenActivity;

/// 展示带图片的提示框
- (void)showHudTextImage:(NSString *)imageName text:(NSString *)text;

/// 加载进度动画
- (void)progressViewStart;

/// 添加在不同位置的进度动画
- (void)progressViewStartInView:(UIView *)view;

/// 移除进度动画
- (void)progressViewFinish;

/// alert提示
- (void)showAlertWithTitle:(NSString *)title;

@end
