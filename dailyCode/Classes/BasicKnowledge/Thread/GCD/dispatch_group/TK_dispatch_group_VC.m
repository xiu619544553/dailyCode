//
//  TK_dispatch_group_VC.m
//  dailyCode
//
//  Created by hello on 2020/11/30.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_dispatch_group_VC.h"

typedef NS_ENUM(NSInteger, TK_dispatch_group_Style) {
    TK_dispatch_group_Simple = 1
};

@interface TK_dispatch_group_VC ()

@end

@implementation TK_dispatch_group_VC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *usageBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    usageBtn1.frame = CGRectMake(10.f, 100.f, 200.f, 35.f);
    usageBtn1.tag = TK_dispatch_group_Simple;
    [usageBtn1 setTitle:@"dispatch_group 用法1" forState:UIControlStateNormal];
    [usageBtn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    usageBtn1.backgroundColor = UIColor.whiteColor;
    usageBtn1.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [usageBtn1 addTarget:self
                  action:@selector(usageBtnAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:usageBtn1];
    
    DISPATCH_TIME_NOW;
    DISPATCH_TIME_FOREVER;
}


#pragma mark - Event Methods

- (void)usageBtnAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    /*
     dispatch_group有两个需要注意的地方：
     1、dispatch_group_enter必须在dispatch_group_leave之前出现
     2、dispatch_group_enter和dispatch_group_leave必须成对出现
     */
    if (tag == TK_dispatch_group_Simple) { // dispatch_group 简单使用
        [self simple_batchRequest];
    }
}

- (void)simple_batchRequest {
    dispatch_group_t loadGroup = dispatch_group_create();
    
    // 任务1
    dispatch_group_enter(loadGroup);
    [self networkTask:^{
        DLog(@"---任务1，耗时3秒");
        dispatch_group_leave(loadGroup);
    } duration:3];
    
    // 任务2
    dispatch_group_enter(loadGroup);
    [self networkTask:^{
        DLog(@"---任务2，耗时2秒");
        dispatch_group_leave(loadGroup);
    } duration:2];
    
    // 任务3
    dispatch_group_enter(loadGroup);
    [self networkTask:^{
        DLog(@"---任务3，耗时1秒");
        dispatch_group_leave(loadGroup);
    } duration:2];
    
    // 任务完成通知
    dispatch_group_notify(loadGroup, dispatch_get_main_queue(), ^{
        DLog(@"任务已完成");
    });
}

#pragma mark - Private Methods

- (void)networkTask:(void(^)(void))completion duration:(unsigned int)duration {
    if (completion) {
        sleep(duration);
        completion();
    }
}

@end
