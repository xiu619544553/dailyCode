//
//  TKThreadListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKThreadListViewController.h"

#define kMAX_QUEUE_COUNT 6

@interface TKThreadListViewController ()
@property (nonatomic, assign) NSUInteger limitQueueCount;
@end

@implementation TKThreadListViewController

@synthesize dataSource = _dataSource;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"当前系统处于激活状态的处理器有 %@ 个", @(self.limitQueueCount)];
}

#pragma mark - getter

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"TK_dispatch_barrier_ViewController",
                KeyForDesc : @"栅栏函数：\ndispatch_barrier_asyn  \ndispatch_barrier_syn"
            },
            @{
                KeyForVC   : @"TK_asyn_syn_queue_thread_VC",
                KeyForDesc : @"同步与异步的概念\n队列与线程的区别"
            },
            @{
                KeyForVC   : @"TK_dispatch_group_VC",
                KeyForDesc : @"组队列使用"
            },
            @{
                KeyForVC   : @"TK_dispatch_semaphore_VC",
                KeyForDesc : @"信号量使用"
            }
        ];
    }
    return _dataSource;
}

- (NSUInteger)limitQueueCount {
    if (_limitQueueCount == 0) {
        // 获取当前系统处于激活状态的处理器数量
        NSUInteger processorCount = [NSProcessInfo processInfo].activeProcessorCount;
        // 根据处理器的数量和设置的最大队列数来设定当前队列数组的大小
        _limitQueueCount = processorCount > 0 ? (processorCount > kMAX_QUEUE_COUNT ? kMAX_QUEUE_COUNT : processorCount) : 1;
    }
    return _limitQueueCount;
}
@end
