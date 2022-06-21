//
//  TKNavigationController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/20.
//

#import "TKNavigationController.h"

@interface TKNavigationController ()

@end

@implementation TKNavigationController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Overwirte Methods

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = (self.viewControllers.count > 0);
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Orientations Methods

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

#pragma StatusBar Style

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.topViewController.preferredStatusBarUpdateAnimation;
}

@end
