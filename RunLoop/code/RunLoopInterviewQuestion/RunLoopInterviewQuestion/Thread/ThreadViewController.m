//
//  ThreadViewController.m
//  fps_demo
//
//  Created by hello on 2021/11/26.
//  线程保活

#import "ThreadViewController.h"
#import "TKThread.h"
#import "HHThread.h"

@interface ThreadViewController ()

@property (nonatomic, strong) TKThread *thread;

@property (nonatomic, strong) HHThread *hhThread;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass(self.class);
    
    [self createBtn1];
    
    [self createBtn2];
    
}

#pragma mark - 简单实现线程保活

- (void)createBtn1 {
    UIButton *threadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    threadBtn.frame = CGRectMake(10, 100, 300, 44);
    
    threadBtn.layer.cornerRadius = 4.f;
    threadBtn.layer.masksToBounds = YES;
    threadBtn.layer.borderColor = UIColor.whiteColor.CGColor;
    threadBtn.layer.borderWidth = 0.5f;
    
    threadBtn.titleLabel.font = [UIFont systemFontOfSize:20.f];
    threadBtn.backgroundColor = UIColor.blackColor;
    [threadBtn setTitle:@"简单实现线程保活"
                      forState:UIControlStateNormal];
    [threadBtn setTitleColor:UIColor.whiteColor
                           forState:UIControlStateNormal];
    [threadBtn addTarget:self
                         action:@selector(threadBtnAction)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:threadBtn];
    
    [self initThread];
}

- (void)initThread {
    // 线程保活
    __weak typeof(self) weakSelf = self;
    self.thread = [[TKThread alloc] initWithBlock:^{
        
        NSLog(@"1---%@", [NSThread currentThread]);
        
        // 通过添加 Source1 保持 RunLoop 运行
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        
        // 当 (weakSelf && weakSelf.thread) 条件成立时，程序只会执行 循环体内的语句
        while (weakSelf && weakSelf.thread) {
            NSLog(@"2---%@", [NSThread currentThread]);
            // 通过 while 循环来线程保活
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        // 关闭子线程 runloop，释放 self.thread
        // 使用 CFRunLoopStop 手动关闭子线程的 runloop，销毁线程
        // CFRunLoopStop(CFRunLoopGetCurrent());
        
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
}

- (void)threadBtnAction {
    [self.thread start];
}

#pragma mark - 线程保活封装

- (void)createBtn2 {
    
    
    CGFloat viewW = self.view.frame.size.width;
    
    UIButton *threadBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    threadBtn2.frame = CGRectMake(10, 200, (viewW - 30) / 2.f, 44);
    
    threadBtn2.layer.cornerRadius = 4.f;
    threadBtn2.layer.masksToBounds = YES;
    threadBtn2.layer.borderColor = UIColor.whiteColor.CGColor;
    threadBtn2.layer.borderWidth = 0.5f;
    
    threadBtn2.titleLabel.font = [UIFont systemFontOfSize:20.f];
    threadBtn2.backgroundColor = UIColor.blackColor;
    [threadBtn2 setTitle:@"执行任务"
                      forState:UIControlStateNormal];
    [threadBtn2 setTitleColor:UIColor.whiteColor
                           forState:UIControlStateNormal];
    [threadBtn2 addTarget:self
                   action:@selector(executeTask)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:threadBtn2];
    
    
    
    UIButton *customYourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customYourButton.frame = CGRectMake(CGRectGetMaxX(threadBtn2.frame) + 5, 200, (viewW - 30) / 2.f, 44);
    
    customYourButton.layer.cornerRadius = 4.f;
    customYourButton.layer.masksToBounds = YES;
    customYourButton.layer.borderColor = UIColor.whiteColor.CGColor;
    customYourButton.layer.borderWidth = 0.5f;
    
    customYourButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    customYourButton.backgroundColor = UIColor.blackColor;
    [customYourButton setTitle:@"停止"
                      forState:UIControlStateNormal];
    [customYourButton setTitleColor:UIColor.whiteColor
                           forState:UIControlStateNormal];
    [customYourButton addTarget:self
                         action:@selector(stop:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:customYourButton];
    
    self.hhThread = [[HHThread alloc] init];
    [self.hhThread run];
}

- (void)executeTask {
    __weak typeof(self) weakSelf = self;
    [self.hhThread executeTask:^{
        [weakSelf doSomethings];
    }];
}

- (void)stop:(UIButton *)sender {
    sender.enabled = NO;
    sender.backgroundColor = UIColor.grayColor;
    [self.hhThread stop];
}

- (void)doSomethings {
    NSLog(@"__%s__", __func__);
}

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
}

@end
