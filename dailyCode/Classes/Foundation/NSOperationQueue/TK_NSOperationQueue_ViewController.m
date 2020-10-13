//
//  TK_NSOperationQueue_ViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_NSOperationQueue_ViewController.h"

@interface TK_NSOperationQueue_ViewController ()

@end

@implementation TK_NSOperationQueue_ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 队列、操作、依赖
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *firstOp = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"最先开始的任务");
    }];
    
    for (int i = 0; i < 4; i ++) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"第 %d 个任务", i);
        }];

        // 添加依赖：op需等 lastOp执行完，才可以执行
        [op addDependency:firstOp];
        [queue addOperation:op];
    }
    
    [queue addOperation:firstOp];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DLog(@"取消所有操作");
        // 正在执行的任务，不可取消
        [queue cancelAllOperations];
    });
}

@end

