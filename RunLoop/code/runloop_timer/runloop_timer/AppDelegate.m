//
//  AppDelegate.m
//  runloop_timer
//
//  Created by hello on 2021/11/23.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
dispatch_queue_t queue = dispatch_queue_create("com.timer.queue", DISPATCH_QUEUE_SERIAL);

// 创建定时器
dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
// 设置时间
uint64_t start = 2.0;    // 几秒后开始执行
uint64_t interval = 1.0; // 时间间隔，单位：秒
dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
// 设置回调
dispatch_source_set_event_handler(timer, ^{
    NSLog(@"%@", [NSThread currentThread]);
});
// 启动定时器
dispatch_resume(timer);
_timer = timer;

NSLog(@"%@",[NSThread currentThread]);
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end



