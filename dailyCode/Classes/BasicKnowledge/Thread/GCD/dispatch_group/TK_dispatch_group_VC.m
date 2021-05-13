//
//  TK_dispatch_group_VC.m
//  dailyCode
//
//  Created by hello on 2020/11/30.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_dispatch_group_VC.h"

typedef NS_ENUM(NSInteger, TK_dispatch_group_Style) {
    TK_dispatch_group_Simple = 1,
    TK_dispatch_group_2 = 2
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
    usageBtn1.backgroundColor = UIColor.blackColor;
    usageBtn1.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [usageBtn1 addTarget:self
                  action:@selector(usageBtnAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:usageBtn1];
    
    UIButton *usageBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    usageBtn2.frame = CGRectMake(10.f, CGRectGetMaxY(usageBtn1.frame) + 20.f, 200.f, 35.f);
    usageBtn2.tag = TK_dispatch_group_2;
    [usageBtn2 setTitle:@"dispatch_group 用法2" forState:UIControlStateNormal];
    [usageBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    usageBtn2.backgroundColor = UIColor.blackColor;
    usageBtn2.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [usageBtn2 addTarget:self
                  action:@selector(usageBtnAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:usageBtn2];
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
        [self gcd_dispatch_group_1];
    } else if (tag == TK_dispatch_group_2) { // 用法2
        [self gcd_dispatch_group_2];
    }
}

- (void)gcd_dispatch_group_1 {
    dispatch_group_t loadGroup = dispatch_group_create();
    
    // 任务1
    dispatch_group_enter(loadGroup);
    [self taskDuration:3 completion:^{
        DLog(@"---任务1，耗时3秒");
        dispatch_group_leave(loadGroup);
    }];
    
    // 任务2
    dispatch_group_enter(loadGroup);
    [self taskDuration:2 completion:^{
        DLog(@"---任务2，耗时2秒");
        dispatch_group_leave(loadGroup);
    }];
    
    // 任务3
    dispatch_group_enter(loadGroup);
    [self taskDuration:1 completion:^{
        DLog(@"---任务3，耗时1秒");
        dispatch_group_leave(loadGroup);
    }];
    
    // 任务完成通知
    dispatch_group_notify(loadGroup, dispatch_get_main_queue(), ^{
        DLog(@"任务已完成");
    });
}

#pragma mark - 用法2

/*
 dispatch_group_enter 表示将任务追加到 group，执行一次，相当于 group 中未执行完毕任务数+1
 dispatch_group_leave 表示任务完成后从 group 移除，执行一次，相当于 group 中未执行完毕任务数-1
 当 group 中未执行完毕任务数为0的时候，才会使dispatch_group_wait解除阻塞，以及执行追加到 dispatch_group_notify 中的任务。
 */
- (void)gcd_dispatch_group_2 {
    // 打印当前线程
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"group---begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    [self queue:queue duration:2 completion:^{ // 任务1
        NSLog(@"1--%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self queue:queue duration:1 completion:^{ // 任务2
        NSLog(@"2--%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        // 模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        // 打印当前线程
        NSLog(@"3---%@", [NSThread currentThread]);
        NSLog(@"group---end");
    });
    
    NSLog(@"code end");
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"等待上面的1，2任务全部完成后，会继续往下执行，阻塞当前线程");
}

#pragma mark - Private Methods

- (void)taskDuration:(unsigned int)duration completion:(void(^)(void))completion  {
    if (completion) {
        sleep(duration);
        completion();
    }
}

- (void)queue:(dispatch_queue_t)queue duration:(unsigned int)duration completion:(void(^)(void))completion  {
    if (!completion) return;
    
    if (queue) {
        dispatch_async(queue, ^{
            sleep(duration);
            completion();
        });
    } else {
        sleep(duration);
        completion();
    }
}
@end
