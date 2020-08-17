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
#import <FPSLabel.h>
#import <FLEX/FLEX.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [self.window makeKeyAndVisible];
    [[FLEXManager sharedManager] showExplorer];
    [FPSLabel installOnWindow:self.window];
    
    // 屏幕尺寸与屏幕旋转方向有关
    DLog(@"屏幕尺寸 : %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    // 设备分辨率是物理属性，与屏幕旋转方向无关
    DLog(@"设备分辨率 : %@", NSStringFromCGSize([UIScreen mainScreen].currentMode.size));
    
    
    
    
    return YES;
}

#pragma mark - Orientation

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - getter

- (CustomWindow *)window {
    if (!_window) {
        _window = [[CustomWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = UIColor.whiteColor;
        _window.rootViewController = [TKTabBarController new];
    }
    return _window;
}
@end
