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


static inline void TKAsyncToMainQueue(void (^blk)(void)) {
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        blk();
    } else {
        dispatch_async(dispatch_get_main_queue(), blk);
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"当前系统处于激活状态的处理器有 %@ 个", @(self.limitQueueCount)];
    
    
    // 获取队列的标签
    dispatch_queue_t customQueue = dispatch_queue_create("com.daily.code", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"customQueue：%s", dispatch_queue_get_label(customQueue));
    
    
    // DISPATCH_CURRENT_QUEUE_LABEL：常量传递给 dispatch_queue_get_label() 函数以检索当前队列的标签。
    NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)); // com.apple.main-thread
    NSLog(@"%s", dispatch_queue_get_label(dispatch_get_main_queue()));    // com.apple.main-thread
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 全局并发队列 com.apple.root.default-qos
        NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });
}

#pragma mark - getter

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"TKThreadCaseVC",
                KeyForDesc : @"案例"
            },
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
