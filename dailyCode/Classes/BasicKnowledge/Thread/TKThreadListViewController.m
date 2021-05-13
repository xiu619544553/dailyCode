//
//  TKThreadListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/14.
//  Copyright © 2020 TK. All rights reserved.

/*
 
 */

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
                KeyForVC   : @"TK_asyn_syn_queue_thread_VC",
                KeyForDesc : @"dispatch_sync、dispatch_async"
            },
            @{
                KeyForVC   : @"TK_dispatch_barrier_ViewController",
                KeyForDesc : @"dispatch_barrier_sync、dispatch_barrier_async"
            },
            @{
                KeyForVC   : @"TK_dispatch_group_VC",
                KeyForDesc : @"dispatch_group_t"
            },
            @{
                KeyForVC   : @"TK_dispatch_semaphore_VC",
                KeyForDesc : @"dispatch_semaphore_t"
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
