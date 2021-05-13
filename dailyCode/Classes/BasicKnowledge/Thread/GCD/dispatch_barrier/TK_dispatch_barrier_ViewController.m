//
//  TK_dispatch_barrier_ViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_dispatch_barrier_ViewController.h"

@interface TK_dispatch_barrier_ViewController ()

/// cachedImages、synQueue用来演示`多读单写`
@property (nonatomic, strong) NSMutableDictionary <NSString* , NSNumber*> *cachedImages;
@property (nonatomic, strong) dispatch_queue_t synQueue;

@end

@implementation TK_dispatch_barrier_ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"dispatch_barrier 栅栏函数的应用";
    
    self.cachedImages = [NSMutableDictionary dictionary];
    self.synQueue = dispatch_queue_create([@"com.test.readwrite" cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
    
    /*
     官方文档：
     
     dispatch_barrier_sync:
     Submits a barrier block object for execution and waits until that block completes.(提交一个栅栏函数在执行中，它会等待栅栏函数执行完)
     
     dispatch_barrier_async:
     Submits a barrier block for asynchronous execution and returns immediately.(提交一个栅栏函数在异步执行中，它会立马返回)
     
     原因：在同步栅栏时栅栏函数在主线程中执行，而异步栅栏中开辟了子线程栅栏函数在子线程中执行
     
     特别注意：
     The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_sync function.
     
     官方说明大意：
     在使用栅栏函数时，使用 dispatch_queue_create 创建的自定义队列才有意义。
     如果用的是串行队列或者系统提供的全局并发队列，这个栅栏函数的作用等同于一个同步函数的作用。
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Event Methods

/*
 执行顺序：
 1、5、8、3、2、4、6、7（6和7没有先后顺序）
 
 任务1、2先完成；
 然后 barrier任务完成；
 最后才是任务3、4完成（3和4没有先后顺序）；
 */
- (IBAction)dispatch_barrier_asynUsage:(UIButton *)sender {
    
    DLog(@"1");
    
    NSThread *currentThread = [NSThread currentThread];
    dispatch_queue_t queue = dispatch_queue_create("com.dispatch.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        sleep(3);
        DLog(@"%@ - 2", currentThread);
    });
    
    dispatch_async(queue, ^{
        sleep(2);
        DLog(@"%@ - 3", currentThread);
    });
    
    dispatch_barrier_async(queue, ^{
        sleep(1);
        DLog(@"%@ - 4 - barrier", currentThread);
    });
    
    DLog(@"%@ - 5", currentThread);
    
    dispatch_async(queue, ^{
        DLog(@"%@ - 6", currentThread);
    });
    
    dispatch_async(queue, ^{
        DLog(@"%@ - 7", currentThread);
    });
    
    DLog(@"%@ - 8", currentThread);
}

#pragma mark - dispatch_barrier_sync 用法

/*
 这里的 dispatch_barrier_sync 上的队列要和需要阻塞的任务在同一队列上，否则是无效的。
 从打印上看，任务 0-4 和任务任务 5-9 因为是异步并发的原因，彼此是无序的。而由于栅栏函数的存在，导致顺序必然是先执行任务 0-4，再执行栅栏函数，再去执行任务 5-9。
 */
- (IBAction)dispatch_barrier_synUsage:(UIButton *)sender {
    
    NSLog(@"start - %@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.sync.dispatch_barrier", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 5; i ++ ) {
        dispatch_async(queue, ^{
            NSLog(@"%@ - %@", @(i), [NSThread currentThread]);
        });
    }
    
    // dispatch_barrier_sync 串行栅栏函数阻塞主队列和队列
    dispatch_barrier_sync(queue, ^{
        sleep(3);
        NSLog(@"barrier - %@", [NSThread currentThread]);
    });
    
    // 主队列也会被串行栅栏函数阻塞，栅栏函数执行完毕后才会执行该行代码
    NSLog(@"x - %@", [NSThread currentThread]);
    
    for (int i = 5; i < 10; i ++ ) {
        dispatch_async(queue, ^{
            NSLog(@"%@ - %@", @(i), [NSThread currentThread]);
        });
    }
    
    NSLog(@"end - %@", [NSThread currentThread]);
}

#pragma mark - 多读单写
- (void)moreRead_OneWrite {
    /*
     1、问:怎么用 GCD 实现多读单写?
     多读单写的意思就是:可以多个读者同时读取数据，而在读的时候，不能写入数据。并且，在写的过程 中，不能有其他写者去写。即读者之间是并发的，写者与读者或其他写者是互斥的。
     这里的写处理就是通过栅栏的形式去写。 就可以用 dispatch_barrier_sync（栅栏函数）去实现
     */
}

// 单写
- (void)cacheObject:(NSNumber *)obj forKey:(NSString *)key {
    dispatch_barrier_sync(self.synQueue, ^{
        [self.cachedImages setObject:@1 forKey:@"1"];
    });
}

// 多读
- (NSNumber *)getObjectForKey:(NSString *)key {
    return [self.cachedImages objectForKey:key];
}
@end
