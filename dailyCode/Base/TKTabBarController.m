//
//  TKTabBarController.m
//  test
//
//  Created by hello on 2020/7/8.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTabBarController.h"

#import "ViewController.h"
#import "TKHomePageViewController.h"
#import "SecondViewController.h"
#import "TKNavigationController.h"

@interface TKTabBarController ()

@end

@implementation TKTabBarController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [[UITabBar appearance] setTranslucent:NO];

    TKHomePageViewController *homeVc = [[TKHomePageViewController alloc] init];
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    ViewController *vc = [[ViewController alloc] init];
    
    UINavigationController *homeNav = [[TKNavigationController alloc] initWithRootViewController:homeVc];
    UINavigationController *secondNav = [[TKNavigationController alloc] initWithRootViewController:secondVc];
    UINavigationController *vcNav = [[TKNavigationController alloc] initWithRootViewController:vc];
    
    homeNav.tabBarItem.title = @"首页";
    secondNav.tabBarItem.title = @"我的";
    vcNav.tabBarItem.title = @"模态测试";
    
    self.viewControllers = @[homeNav, secondNav, vcNav];
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
