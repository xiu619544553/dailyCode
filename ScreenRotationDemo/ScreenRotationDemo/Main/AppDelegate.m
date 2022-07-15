//
//  AppDelegate.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/16.
//

#import "AppDelegate.h"
#import "TKBaseTabBarController.h"

#if DEBUG
#import "FLEXManager.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // TARGETS -> General -> Deployment Info -> Device Orientation
    // 支持三种旋转方向
    // ☑️ Portrait
    // ☑️ Landscape Left
    // ☑️ Landscape Right

    // 屏蔽 Masonry 警告
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:@"_UIConstraintBasedLayoutLogUnsatisfiable"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [TKBaseTabBarController new];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
#if DEBUG
    [[FLEXManager sharedManager] showExplorer]; // DEBUG 模式下才需要显示调试工具
#endif
    
    return YES;
}

// 无特殊需求，可以不实现该方法。默认根据项目配置中的旋转项  TARGETS -> General -> Deployment Info -> Device Orientation
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    if (_controlInterfaceOrientation) {
//        // 返回你需要的返回的旋转方向
//        return UIInterfaceOrientationMaskPortrait;
//    }
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}

@end
