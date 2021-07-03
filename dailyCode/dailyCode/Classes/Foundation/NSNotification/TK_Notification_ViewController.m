//
//  TK_Notification_ViewController.m
//  dailyCode
//
//  Created by hello on 2021/5/19.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TK_Notification_ViewController.h"

@interface TK_Notification_ViewController ()

@end

@implementation TK_Notification_ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    // 发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"TestNotification" object:@1];
    // 接收通知
    [NSNotificationCenter.defaultCenter postNotificationName:@"TestNotification" object:nil];
}

- (void)handleNotification:(NSNotification *)noti {
    NSLog(@"%@", noti.object);
}

@end
