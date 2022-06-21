//
//  TKBaseTabBarController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/20.
//

#import "TKBaseTabBarController.h"

#import "StatusBarViewController.h"
#import "TKNavigationController.h"
#import "ScreenRotationViewController.h"
#import "GravityScreenRotationViewController.h"
#import "VideoViewController.h"

@interface TKBaseTabBarController ()

@end

@implementation TKBaseTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITabBarItem *statusItem = [[UITabBarItem alloc] initWithTitle:@"状态栏" image:[UIImage new] tag:1];
    StatusBarViewController *statusVc = [StatusBarViewController new];
    statusVc.tabBarItem = statusItem;
    TKNavigationController *statusNav = [[TKNavigationController alloc] initWithRootViewController:statusVc];
    [self addChildViewController:statusNav];
    
    
    UITabBarItem *landscapeItem = [[UITabBarItem alloc] initWithTitle:@"屏幕旋转" image:[UIImage new] tag:2];;
    ScreenRotationViewController *landscapeVc = [ScreenRotationViewController new];
    landscapeVc.tabBarItem = landscapeItem;
    TKNavigationController *landscapeNav = [[TKNavigationController alloc] initWithRootViewController:landscapeVc];
    [self addChildViewController:landscapeNav];
    
    
    UITabBarItem *videoItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:[UIImage new] tag:3];;
    VideoViewController *videoVc = [VideoViewController new];
    videoVc.tabBarItem = videoItem;
    TKNavigationController *videoNav = [[TKNavigationController alloc] initWithRootViewController:videoVc];
    [self addChildViewController:videoNav];
}

#pragma mark - Orientations Methods

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

#pragma StatusBar Style

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.selectedViewController.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
}
@end
