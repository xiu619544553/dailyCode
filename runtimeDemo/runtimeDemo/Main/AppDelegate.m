//
//  AppDelegate.m
//  RuntimeDemo
//
//  Created by hello on 2021/6/17.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"

#ifdef DEBUG
#import <FLEX/FLEX.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (!ViewControllerCountDict) {
        ViewControllerCountDict = [NSMutableDictionary dictionary];
    }
    
#ifdef DEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MainTableViewController *mainVC = [[MainTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
