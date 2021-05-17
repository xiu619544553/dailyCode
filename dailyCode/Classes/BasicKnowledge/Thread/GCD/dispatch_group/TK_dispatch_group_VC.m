//
//  TK_dispatch_group_VC.m
//  dailyCode
//
//  Created by hello on 2020/11/30.
//  Copyright © 2020 TK. All rights reserved.
/*
 
 一、
 
 dispatch_group有两个需要注意的地方：
 1、dispatch_group_enter必须在dispatch_group_leave之前出现
 2、dispatch_group_enter和dispatch_group_leave必须成对出现
 
 场景描述：
 用法1是 dispatch_group_notify 的简单使用；
 用法2是组队列 dispatch_group_notify 的使用。
 用法3是 dispatch_group_wait 与 dispatch_barrier_async 组合使用。APP启动先执行任务1、2，然后在调用函数 -requestResult 中使用栅栏函数阻塞 requestQueue，当 requestQueue 中的任务完成后，再回调。【调用与任务执行异步调用时，推荐使用用法2。】
 用法4与用法3功能是一致的。
 */

#import "TK_dispatch_group_VC.h"

typedef NS_ENUM(NSInteger, TK_dispatch_group_Number) {
    TK_dispatch_group_1 = 1,
    TK_dispatch_group_2 = 2,
    TK_dispatch_group_3 = 3,
    TK_dispatch_group_4 = 4
};

@interface TK_dispatch_group_VC ()
@property (nonatomic, strong) dispatch_queue_t requestQueue;
@end

@implementation TK_dispatch_group_VC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestQueue = dispatch_queue_create("com.daily.business", DISPATCH_QUEUE_CONCURRENT);
    
    [self setupViews];
}

#pragma mark - Event Methods

- (void)usageBtnAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    
    if (tag == TK_dispatch_group_1) {
        [self gcd_dispatch_group_1];
    } else if (tag == TK_dispatch_group_2) {
        [self gcd_dispatch_group_2];
    } else if (tag == TK_dispatch_group_3) {
        [self gcd_dispatch_group_3];
    } else if (tag == TK_dispatch_group_4) {
        [self gcd_dispatch_group_4];
    }
}

#pragma mark - 用法1

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
 
 场景：
 任务1和任务2并行执行，任务都完成后处理回调结果。
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

#pragma mark - 用法3
/*
 多任务并行执行 ——> 任务都完成后再处理其他逻辑
 */
- (void)gcd_dispatch_group_3 {
    [self addTasks];
    [self requestResult:^{
        NSLog(@"任务完成？%@", [NSThread currentThread]);
    }];
}

- (void)addTasks {
    for (int i = 0; i < 2; i ++) {
        dispatch_async(self.requestQueue, ^{

            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);

            [self taskDuration:((i == 0) ? 2 : 1) completion:^{
                NSLog(@"任务%@ - %@", @(i), [NSThread currentThread]);
                dispatch_group_leave(group);
            }];

            dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        });
    }
}

- (void)requestResult:(void(^)(void))completion {
    dispatch_barrier_async(self.requestQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion ?: completion();
        });
    });
}

#pragma mark - 用法4

- (void)gcd_dispatch_group_4 {
    [self addTasks4];
    [self requestResult4:^{
        NSLog(@"任务完成？%@", [NSThread currentThread]);
    }];
}

- (void)addTasks4 {
    for (int i = 0; i < 2; i ++) {
        [self queue:self.requestQueue duration:((i == 0) ? 2 : 1) completion:^{
            NSLog(@"任务%@ - %@", @(i), [NSThread currentThread]);
        }];
    }
}

- (void)requestResult4:(void(^)(void))completion {
    dispatch_barrier_async(self.requestQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion ?: completion();
        });
    });
}

/*!
 * @function dispatch_group_wait
 *
 * @abstract
 * Wait synchronously until all the blocks associated with a group have completed or until the specified timeout has elapsed.
 * 同步地等待，直到与一个组相关联的所有块都完成，或者直到指定的超时已经过去。
 *
 * @discussion
 * This function waits for the completion of the blocks associated with the given dispatch group, and returns after all blocks have completed or when the specified timeout has elapsed.
 *
 * 该函数会等待所有与 dispatc_group_t 关联的 blocks 完成，然后在所有 blocks完成或超时后返回（不在阻塞dispat_group_t）
 *
 * This function will return immediately if there are no blocks associated with the dispatch group (i.e. the group is empty).
 * 如果没有与分派组相关的块(即分派组是空的)，这个函数将立即返回。
 *
 * The result of calling this function from multiple threads simultaneously with the same dispatch group is undefined.
 * 使用同一个 dispatch_group_t 同时从多个线程调用此函数的结果是未定义的。
 *
 * After the successful return of this function, the dispatch group is empty.
 * It may either be released with dispatch_release() or re-used for additional
 * blocks. See dispatch_group_async() for more information.
 *
 * @param group
 * The dispatch group to wait on.
 * The result of passing NULL in this parameter is undefined.
 *
 * @param timeout
 * When to timeout (see dispatch_time). As a convenience, there are the
 * DISPATCH_TIME_NOW and DISPATCH_TIME_FOREVER constants.
 *
 * @result
 * Returns zero on success (all blocks associated with the group completed
 * within the specified timeout) or non-zero on error (i.e. timed out).
 */
//intptr_t dispatch_group_wait(dispatch_group_t group, dispatch_time_t timeout);

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

- (void)setupViews {
    UIButton *usageBtn1 = [self addBtnsTag:TK_dispatch_group_1
                                     frame:CGRectMake(10.f, 100.f, 200.f, 35.f)
                                     title:@"dispatch_group 用法1"];
    
    UIButton *usageBtn2 = [self addBtnsTag:TK_dispatch_group_2
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn1.frame) + 20.f, 200.f, 35.f)
                                     title:@"dispatch_group 用法2"];
    
    UIButton *usageBtn3 = [self addBtnsTag:TK_dispatch_group_3
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn2.frame) + 20.f, 200.f, 35.f)
                                     title:@"dispatch_group 用法3"];
    
    [self addBtnsTag:TK_dispatch_group_4
               frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn3.frame) + 20.f, 200.f, 35.f)
               title:@"dispatch_barrier_async 实现与 dispatch_group_t 同样的效果"];
}

- (UIButton *)addBtnsTag:(TK_dispatch_group_Number)number
             frame:(CGRect)frame
             title:(NSString *)title {
    UIButton *usageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    usageBtn.frame = frame;
    usageBtn.tag = TK_dispatch_group_3;
    usageBtn.backgroundColor = UIColor.blackColor;
    usageBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    
    [usageBtn setTitle:title
              forState:UIControlStateNormal];
    
    [usageBtn setTitleColor:UIColor.whiteColor
                   forState:UIControlStateNormal];
    
    [usageBtn addTarget:self
                  action:@selector(usageBtnAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:usageBtn];
    return usageBtn;
}
@end
