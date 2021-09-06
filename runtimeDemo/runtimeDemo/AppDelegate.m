//
//  AppDelegate.m
//  RuntimeDemo
//
//  Created by hello on 2021/6/17.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "TKKid.h"
#import "TKPerson.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MainTableViewController *mainVC = [[MainTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    
    // 1、[self class]、[super class] 输出
    TKKid *kd = [[TKKid alloc] init];
    
    // 2、输出
//    Class cls = [TKPerson class];
//    void *tk = &cls;
//    [(__bridge id)kc saySomething];
    
    
    // 3、输出
    
    NSObject *objc = [NSObject new];
    NSLog(@"%---ld",CFGetRetainCount((__bridge CFTypeRef)(objc)));     // 1

    void(^block1)(void) = ^{
        NSLog(@"---%ld",CFGetRetainCount((__bridge CFTypeRef)(objc))); // 3
    };
    block1();

    void(^__weak block2)(void) = ^{
        NSLog(@"---%ld",CFGetRetainCount((__bridge CFTypeRef)(objc))); // 4
    };
    block2();

    void(^block3)(void) = [block2 copy];
    block3();                                                          // 5

    __block NSObject *obj = [NSObject new];
    void(^block4)(void) = ^{
        NSLog(@"---%ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));  // 1
    };
    block4();
    
    
    
    
    return YES;
}


@end
