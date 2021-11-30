//
//  TimerViewController.m
//  fps_demo
//
//  Created by hello on 2021/11/30.
//

#import "TimerViewController.h"
#import "WrapTimer.h"

@interface TimerViewController ()
@property (nonatomic, strong) WrapTimer *timer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass(self.class);
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    
//    [self systemTimer];
   
    
//    [self wrapTimer];
}


/// 停止计时器再次触发，并请求将其从运行循环中移除。
/// @discussion 这个方法是从NSRunLoop对象中移除计时器的唯一方法。
/// NSRunLoop对象删除了它对计时器的强引用，要么是在invalidate方法返回之前，要么是在稍后的某个时间点。如果它配置了目标和用户信息对象，接收方也会删除对这些对象的强引用。
- (void)invalidate {}

//- (void)systemTimer {
////    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
////        NSLog(@"---");
////    }];
//
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//}
//
//- (void)timerAction{
//    NSLog(@"%s", __func__);
//}
//
//- (void)wrapTimer {
//
//    _timer = [WrapTimer new];
//     [_timer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//         NSLog(@"---");
//     }];
//}
//
//- (void)dealloc {
//    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
//}

@end
