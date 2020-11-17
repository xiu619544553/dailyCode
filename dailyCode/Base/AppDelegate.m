//
//  AppDelegate.m
//  test
//
//  Created by hello on 2020/5/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "AppDelegate.h"
#import "TKTabBarController.h"

#import <Masonry.h>
#import <BackgroundTasks/BackgroundTasks.h>
//#import <FPSLabel.h>
#import <FLEX/FLEX.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    [[FLEXManager sharedManager] showExplorer];
//    [FPSLabel installOnWindow:self.window];
    
    // 屏幕尺寸与屏幕旋转方向有关
    DLog(@"屏幕尺寸 : %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    // 设备分辨率是物理属性，与屏幕旋转方向无关
    DLog(@"设备分辨率 : %@", NSStringFromCGSize([UIScreen mainScreen].currentMode.size));
    
    
    // Today Extension
    // suiteName = com.tank.dailyCode.dailyCodeWidget
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @"123456";
    params[@"nickName"] = @"Tank";
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.tank.dailyCode.dailyCodeWidget"];
    [userDefaults setValue:params forKey:@"dailyCodeWidget"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    DLog(@"url=%@，options=%@，url.scheme=%@", url.absoluteString, options, url.scheme);
    
    NSString *scheme = url.scheme;
    NSString *host   = url.host;
    NSString *query  = url.query;
    
    if (scheme && [scheme isEqualToString:@"liteDailyCode"]) { // today extension
        // 可以通过设置 query，跳转到指定的页面
    }
    
    return YES;
}

#pragma mark - Orientation

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - getter

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = UIColor.whiteColor;
        _window.rootViewController = [TKTabBarController new];
    }
    return _window;
}
@end
