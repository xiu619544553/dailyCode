//
//  TK_dispatch_group_VC.m
//  dailyCode
//
//  Created by hello on 2020/11/30.
//  Copyright © 2020 TK. All rights reserved.
/*
 
 0、
 dispatch_group_async
 场景:在 n 个耗时并发任务都完成后，再去执行接下来的任务。比如，在 n 个网络请求完成后去刷新 UI 页 面。
 
1、
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
    
    switch (tag) {
        case 1:
            [self gcd_dispatch_group_1];
            break;
            
        case 2:
            [self gcd_dispatch_group_2];
            break;
            
        case 3:
            [self gcd_dispatch_group_3];
            break;
            
        case 4:
            [self gcd_dispatch_group_4];
            break;
            
        case 5:
            [self gcd_dispatch_group_5];
            break;
            
        default:
            break;
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

#pragma mark - 用法5
- (void)gcd_dispatch_group_5 {
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"0 - %@", [NSThread currentThread]);
       
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_queue_create("com.5.dispatch_group", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            sleep(2);
            NSLog(@"1 - %@", [NSThread currentThread]);
            dispatch_group_leave(group);
        });
        
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            sleep(1);
            NSLog(@"2 - %@", [NSThread currentThread]);
            dispatch_group_leave(group);
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            sleep(1);
            NSLog(@"3 - %@", [NSThread currentThread]);
        });
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
    CGFloat btnWidth = self.view.width - 20.f;
    UIButton *usageBtn1 = [self addBtnsTag:1
                                     frame:CGRectMake(10.f, 100.f, btnWidth, 35.f)
                                     title:@"dispatch_group 用法1"];
    
    UIButton *usageBtn2 = [self addBtnsTag:2
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn1.frame) + 20.f, btnWidth, 35.f)
                                     title:@"dispatch_group 用法2"];
    
    UIButton *usageBtn3 = [self addBtnsTag:3
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn2.frame) + 20.f, btnWidth, 35.f)
                                     title:@"dispatch_group 用法3"];
    
    UIButton *usageBtn4 = [self addBtnsTag:4
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn3.frame) + 20.f, btnWidth, 60.f)
                                     title:@"dispatch_barrier_async 实现与 dispatch_group_t 同样的效果"];
    
    [self addBtnsTag:5
               frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn4.frame) + 20.f, btnWidth, 35.f)
               title:@"dispatch_group 用法5，与用法 1 等同"];
}

- (UIButton *)addBtnsTag:(NSInteger)tag
             frame:(CGRect)frame
             title:(NSString *)title {
    UIButton *usageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    usageBtn.frame = frame;
    usageBtn.tag = tag;
    usageBtn.backgroundColor = UIColor.blackColor;
    usageBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    usageBtn.titleLabel.numberOfLines = 0;
    
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
