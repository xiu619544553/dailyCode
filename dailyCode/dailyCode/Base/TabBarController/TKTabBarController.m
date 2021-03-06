//
//  TKTabBarController.m
//  test
//
//  Created by hello on 2020/7/8.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTabBarController.h"

#import "ViewController.h"
#import "TKOtherViewController.h"
#import "TKScrollViewAndNavVC.h"
#import "TKNavigationController.h"
#import "TKFoundationListViewController.h"
#import "TKUIKitListViewController.h"
#import "TK3rdUsageListViewController.h"
#import "TKBasicKnowledgeListViewController.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface TKTabBarController () <UITabBarControllerDelegate>

@end

@implementation TKTabBarController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.delegate = self;
    
    // 设置布局
    [self setupChildControllers];
    
    // 设置 tabbar样式
    [self setupTabBarStyle];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([self isDoubleClick:viewController]) {
        NSLog(@"双击当前的控制器");
    }
    return YES;
}

#pragma mark - Private Methods

// 检查是不是双击操作
- (BOOL)isDoubleClick:(UIViewController *)viewController {
    static UIViewController *lastViewController = nil;
    static NSTimeInterval lastClickTime = 0;
    
    if (lastViewController != viewController) {
        lastViewController = viewController;
        lastClickTime = [NSDate timeIntervalSinceReferenceDate];
        
        return NO;
    }
    
    NSTimeInterval clickTime = [NSDate timeIntervalSinceReferenceDate];
    if (clickTime - lastClickTime > 0.5 ) {
        lastClickTime = clickTime;
        return NO;
    }
    
    lastClickTime = clickTime;
    return YES;
}

/**
 以导航栏控制器为子控制器
 
 @param childVC       子控制器
 @param image         普通状态下的图片
 @param selectedImage 选中时的图片
 @param title         标题
 */
- (void)addNavChildVC:(UIViewController *)childVC
                image:(NSString *)image
        selectedImage:(NSString *)selectedImage
                title:(NSString *)title {
    // 设置tabBar普通状态下图片和选中状态下图片（保证选中时图片不被渲染）
    UITabBarItem *tabBarItem =
    [[UITabBarItem alloc] initWithTitle:title
                                  image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                          selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 设置文字普通状态下颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];
    
    // 设置文字选中状态下颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    
    selectedTextAttrs[NSForegroundColorAttributeName] = kRGB(238, 178, 7);
    selectedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];
    
    
    [tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    childVC.tabBarItem = tabBarItem;
    
    childVC.title = title;
    
    // 添加导航栏控制器
    TKNavigationController *nav = [[TKNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

// 添加子控制器
- (void)setupChildControllers {
    
    /*
     tabbar_icon_game
     tabbar_icon_note
     tabbar_icon_signin
     tabbar_icon_strategy
     tabbar_icon_activity
     */
    TKFoundationListViewController *foundationListVC = [[TKFoundationListViewController alloc] init];
    [self addNavChildVC:foundationListVC image:@"tabbar_icon_note" selectedImage:@"tabbar_icon_note" title:@"Foundation"];
    
    TKUIKitListViewController *uikitListVC = [[TKUIKitListViewController alloc] init];
    [self addNavChildVC:uikitListVC image:@"tabbar_icon_signin" selectedImage:@"tabbar_icon_signin" title:@"UIKit"];
    
    TK3rdUsageListViewController *thirdListVC = [[TK3rdUsageListViewController alloc] init];
    [self addNavChildVC:thirdListVC image:@"tabbar_icon_strategy" selectedImage:@"tabbar_icon_strategy" title:@"第三方"];
    
    TKOtherViewController *homeVc = [[TKOtherViewController alloc] init];
    [self addNavChildVC:homeVc image:@"tabbar_icon_game" selectedImage:@"tabbar_icon_game" title:@"其他"];
    
    TKBasicKnowledgeListViewController *basicVc = [[TKBasicKnowledgeListViewController alloc] init];
    [self addNavChildVC:basicVc image:@"tabbar_icon_activity" selectedImage:@"tabbar_icon_activity" title:@"计算机基础"];
}

// 设置 tabbar样式
- (void)setupTabBarStyle {
    
    // 解决系统版本 >=iOS12.1 时，tabbar错乱动画bug
    [UITabBar appearance].translucent = NO;
}


#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}
@end
