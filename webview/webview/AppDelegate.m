//
//  AppDelegate.m
//  webview
//
//  Created by hello on 2021/11/1.
//  参考：https://github.com/wsl2ls/WKWebView

#import "AppDelegate.h"
#import "MainPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // iOS 15系统适配
    if (@available(iOS 15.0, *)) {
        // 适配导航栏
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor whiteColor];
        [UINavigationBar appearance].standardAppearance = appearance;
        [UINavigationBar appearance].scrollEdgeAppearance = appearance;
        
        // 适配UITableView
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[MainPageViewController new]];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
