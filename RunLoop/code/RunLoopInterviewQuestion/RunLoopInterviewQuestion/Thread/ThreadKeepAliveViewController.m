//
//  ThreadKeepAliveViewController.m
//  RunLoopInterviewQuestion
//
//  Created by hello on 2021/11/30.
//

#import "ThreadKeepAliveViewController.h"
#import "TKThread.h"

@interface ThreadKeepAliveViewController ()

@property (nonatomic, strong) TKThread *thread;

@end

@implementation ThreadKeepAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    
    self.thread = [[TKThread alloc] init];
    [self.thread run];
}

#pragma mark - 开始执行任务

- (IBAction)executeTaskAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [self.thread executeTask:^{
        [weakSelf doSomethings];
    }];
}

- (void)doSomethings {
    NSLog(@"。。。执行任务。。。");
}

#pragma mark - 关闭销毁线程

- (IBAction)stopTaskAction:(UIButton *)sender {
    
    sender.enabled = NO;
    sender.backgroundColor = UIColor.grayColor;
    [self.thread stop];
}


- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
}

@end
