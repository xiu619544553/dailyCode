//
//  AppDelegate.m
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "CustomURLProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册 CustomURLProtocol
    // 一旦注册完毕后，它就有机会来处理所有交付给URL Loading system的网络请求。
    [CustomURLProtocol registerProtocol];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
