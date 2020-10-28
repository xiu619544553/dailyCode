//
//  TKThreadListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKThreadListViewController.h"

@interface TKThreadListViewController ()

@end

@implementation TKThreadListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

@synthesize dataSource = _dataSource;

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC : @"TK_dispatch_barrier_ViewController",
                KeyForDesc : @"栅栏函数：\ndispatch_barrier_asyn  \ndispatch_barrier_syn"
            },
            @{
                KeyForVC : @"TK_asyn_syn_queue_thread_VC",
                KeyForDesc : @"同步与异步的概念\n队列与线程的区别"
            }
        ];
    }
    return _dataSource;
}

@end
