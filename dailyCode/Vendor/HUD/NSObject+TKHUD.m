//
//  NSObject+TKHUDHUD.m
//  Yeso
//
//  Created by FW on 2017/3/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSObject+TKHUD.h"

#pragma mark - 颜色

/** 从RGB转换成UIColor （16进制->10进制）*/
#define WXkUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 设置带透明度 */
#define WXkUIColorFromRGBA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


@implementation NSObject (TKHUD)

static char overlayKey;

- (MBProgressHUD *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(MBProgressHUD *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char activityHUDKey;
- (MBProgressHUD *)activityHUD
{
    return objc_getAssociatedObject(self, &activityHUDKey);
}
- (void)setActivityHUD:(MBProgressHUD *)activityHUD
{
    objc_setAssociatedObject(self, &activityHUDKey, activityHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 特殊定义吐司提示 font 不传时默认为15号常规字体
- (void)showHudText:(NSString *)text afterDelay:(NSTimeInterval)delay font:(UIFont *)font
{
    if (!font) {
        font = [UIFont systemFontOfSize:15];
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.contentColor = WXkUIColorFromRGB(0xffffff);
    hud.bezelView.color = WXkUIColorFromRGBA(0x000000, 0.8);
    hud.detailsLabel.font = font;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

#pragma mark - 展示吐司提示信息 (默认提示两秒)
- (void)showHudText:(NSString *)text
{
    if ([text isKindOfClass:[NSNull class]] || text.length == 0) {
        text = @" ";
        return;
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.contentColor = WXkUIColorFromRGB(0xffffff);
    hud.bezelView.color = WXkUIColorFromRGBA(0x000000, 1);
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark - 展示吐司提示信息 (默认提示两秒) 
- (void)showHudText:(NSString *)text onView:(UIView *)view {
    if ([text isKindOfClass:[NSNull class]] || text.length == 0) {
        text = @" ";
        return;
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.contentColor = WXkUIColorFromRGB(0xffffff);
    hud.bezelView.color = WXkUIColorFromRGBA(0x000000, 1);
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark - 吐司提示不隐藏
- (void)showHudNoHidden:(NSString *)text
{
    if ([text isKindOfClass:[NSNull class]] || text.length == 0) {
        text = @" ";
    }
    self.overlay = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    self.overlay.userInteractionEnabled = NO;
    self.overlay.mode = MBProgressHUDModeText;
    self.overlay.detailsLabel.text = text;
    self.overlay.contentColor = WXkUIColorFromRGB(0xffffff);
    self.overlay.bezelView.color = WXkUIColorFromRGBA(0x000000, 1);
    self.overlay.detailsLabel.font = [UIFont systemFontOfSize:15];
    self.overlay.margin = 10.f;
    self.overlay.removeFromSuperViewOnHide = YES;
}
- (void)hiddenHud
{
    [self.overlay hideAnimated:YES afterDelay:0];
}

//
- (BOOL)hudIsShowing
{
  UIView *keyWindow = [[UIApplication sharedApplication] keyWindow];
  for (UIView *tmpView in keyWindow.subviews) {
    if ([tmpView isKindOfClass:[MBProgressHUD class]]) {
      return YES;
    }
  }
  return NO;
}

#pragma mark - 展示菊花进度
- (void)showActivityWithText:(NSString *)text {
    [self hidenActivity];
    if (!self.activityHUD) {
        self.activityHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    }
    self.activityHUD.userInteractionEnabled = YES;
    self.activityHUD.mode = MBProgressHUDModeIndeterminate;
    self.activityHUD.label.text = text;
    self.activityHUD.detailsLabel.text = @"";
    self.activityHUD.contentColor = WXkUIColorFromRGB(0xffffff);
    self.activityHUD.bezelView.color = WXkUIColorFromRGBA(0x000000, 1);
    self.activityHUD.label.font = [UIFont systemFontOfSize:15];
    [self.activityHUD showAnimated:YES];
}

- (void)showActivity {
    [self showActivityWithText:@""];
}

- (MBProgressHUD *)showActivityWithText:(NSString *)text onView:(UIView *)view
{
    [self hidenActivity];
    if (!self.activityHUD) {
        self.activityHUD = [MBProgressHUD showHUDAddedTo:view animated:NO];
    }
    self.activityHUD.userInteractionEnabled = YES;
    self.activityHUD.mode = MBProgressHUDModeIndeterminate;
    self.activityHUD.label.text = text;
    self.activityHUD.detailsLabel.text = @"";
    self.activityHUD.contentColor = [UIColor whiteColor];
    self.activityHUD.bezelView.color = [UIColor blackColor];
    self.activityHUD.label.font = [UIFont systemFontOfSize:15];
    [self.activityHUD showAnimated:YES];
    return self.activityHUD;
}

#pragma mark - 隐藏菊花进度
- (void)hidenActivity {
    if (self.activityHUD) {
        [self.activityHUD hideAnimated:YES];
        [self.activityHUD removeFromSuperview];
        self.activityHUD = nil;
    }
}

#pragma mark - 展示带图片的提示框
- (void)showHudTextImage:(NSString *)imageName text:(NSString *)text
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.text = text;
    hud.contentColor = WXkUIColorFromRGB(0xffffff);
    hud.bezelView.color = WXkUIColorFromRGBA(0x000000, 1);
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

#pragma mark - 加载进度动画
- (void)progressViewStart
{
    
}
#pragma mark - 添加在不同位置的进度动画
- (void)progressViewStartInView:(UIView *)view
{
    
}
#pragma mark - 移除进度动画
- (void)progressViewFinish
{
    
}

- (void)showAlertWithTitle:(NSString *)title {
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
    }];
    
    [alertVC addAction:cancelAction];
    
    
    
}


@end
