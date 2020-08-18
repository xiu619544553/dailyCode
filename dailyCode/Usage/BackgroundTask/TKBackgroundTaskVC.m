//
//  TKBackgroundTaskVC.m
//  dailyCode
//
//  Created by hello on 2020/8/17.
//  Copyright © 2020 TK. All rights reserved.
//  https://www.jianshu.com/p/5547e72f5736
//  http://www.cocoachina.com/cms/wap.php?action=article&id=27303

#import "TKBackgroundTaskVC.h"

static UIBackgroundTaskIdentifier TKBackgroundTaskIdentifier;

@interface TKBackgroundTaskVC ()

@end

@implementation TKBackgroundTaskVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didEnterBackgroundNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)didEnterBackgroundNotification:(NSNotification *)notification {
    
    NSLog(@"...进入后台...");
    
    UIApplication *app = [UIApplication sharedApplication];
    
    TKBackgroundTaskIdentifier = [app beginBackgroundTaskWithExpirationHandler:^{
        
        DLog(@"...remaining...%.2f", app.backgroundTimeRemaining);
        
        [app endBackgroundTask:TKBackgroundTaskIdentifier];
        TKBackgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }];
    
    if (@available(iOS 10.0, *)) {
        __block NSInteger count = 0;
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            count ++;
            
            if (app.applicationState == UIApplicationStateActive) {
                DLog(@"count: %ld", count);
            } else {
                DLog(@"remaining: %.2f  id: %lu  count: %ld", app.backgroundTimeRemaining, TKBackgroundTaskIdentifier, count);
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}

@end
