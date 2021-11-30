//
//  HHThread.m
//  RunLoopInterviewQuestion
//
//  Created by hello on 2021/11/30.
//

#import "HHThread.h"

@interface HHThread ()

/// 一条线程
@property(nonatomic ,strong) NSThread *thread;

/// 是否停止 RunLoop
@property(nonatomic ,assign) BOOL    isStoped;

@end

@implementation HHThread

#pragma mark - Public Methods

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.isStoped = NO;
        
        // 线程保活
        __weak typeof(self)weakSelf = self;
        self.thread = [[NSThread alloc] initWithBlock:^{
            
            // 通过添加 Source1 保持 RunLoop 运行
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            
            // 通过 while 循环来线程保活
            while(weakSelf && !weakSelf.isStoped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

// 开启一条线程
- (void)run {
    if (!self.thread) return;
    [self.thread start];
}

// 线程执行任务
- (void)executeTask:(void (^)(void))task {
    if (!task) return;
    if (!self.thread) return;
    // 在当前线程执行任务
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.thread) return;
    [self performSelector:@selector(__stopRunLoop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

#pragma mark - Private Methods

// 销毁析构方法
- (void)dealloc {
    NSLog(@"%s",__func__);
    [self stop];
}

// 停止RunLoop
- (void)__stopRunLoop {
    self.isStoped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

// 执行任务
- (void)__executeTask:(void (^)(void))task {
    task();
}

@end
