//
//  PerformSelectorVC.m
//  fps_demo
//
//  Created by hello on 2021/11/30.
//

#import "PerformSelectorVC.h"

@interface PerformSelectorVC ()

@end

@implementation PerformSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"1 - %@", [NSThread currentThread]);
    
    NSThread *thread = [[NSThread alloc] initWithBlock:^{

        NSLog(@"2 - %@", [NSThread currentThread]);
        
        /*
         执行顺序：1、2、3、4
         分析：因为 `performSelector:withObject:` 会在当前线程立即执行指定的 `selector` 方法。
         */
//        [self performSelector:@selector(testAction)
//                   withObject:nil];
        
#pragma mark - performSelector: withObject: afterDelay
        
        /*
         结果：执行顺序：1、2、4
         分析：因为 performSelector:withObject:afterDelay: 实际是往 RunLoop 里面注册一个定时器，而在子线程中，RunLoop 是没有开启（默认）的，所有不会输出 3。
         */
//        [self performSelector:@selector(testAction)
//                   withObject:nil
//                   afterDelay:1];
        
        /*
         结果：执行顺序：1、2、3、4
         分析：因为 performSelector:withObject:afterDelay: 实际是往 RunLoop 里面注册一个定时器，而在子线程中，RunLoop 是没有开启（默认）的，我们主动开启了runloop，所以selector会执行。
         */
//        [self performSelector:@selector(testAction)
//                   withObject:nil
//                   afterDelay:2];
//        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
//        [currentRunLoop run];
        
        
        /*
         结果：执行顺序：1、2、3、4
         分析：performSelector:onThread:withObject:waitUntilDone: 会在指定的线程执行，而执行的策略根据参数 wait 处理，这里传 YES 表明将会立即阻断 指定的线程 并执行指定的 selector，selector返回后继续执行下面的任务（任务4）。
         */
//        [self performSelector:@selector(testAction)
//                     onThread:[NSThread currentThread]
//                   withObject:nil
//                waitUntilDone:YES];
        
        
#pragma mark - performSelector: onThread: withObject: waitUntilDone
        
        /*
         结果：执行顺序：1、2、3
         分析：该方法 wait 设置为 NO，表示不会阻塞指定线程，而是把 Selector 添加到指定线程的 RunLoop 中等待时机执行。RunLoop启动了，因此可以执行 Selector。
              Selector 执行完毕后，RunLoop 并没有停止，使用 run 启动方式，RunLoop 会一直运行下去，
              在此期间处理输入源的数据，并且在 `NSDefaultRunLoopMode` 模式下重复调用 `runMode:beforeDate:`，所以无法输出任务4
         */
//        [self performSelector:@selector(testAction)
//                     onThread:[NSThread currentThread]
//                   withObject:nil
//                waitUntilDone:NO];
//        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
//        [currentRunLoop run];
        
        
        /*
         结果：执行顺序：1、2、3、4
         分析：
         */
//        [self performSelector:@selector(testAction)
//                     onThread:[NSThread currentThread]
//                   withObject:nil
//                waitUntilDone:NO];
//        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
//        [currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        
        /*
         结果：Selector 不执行，顺序：1、2、4
         分析：该方法实际是往 RunLoop 里面注册一个定时器，而在子线程中，RunLoop 是没有开启（默认）的，所有不会输出 3。
         */
//        [self performSelector:@selector(testAction)
//                   withObject:nil
//                   afterDelay:1
//                      inModes:@[NSDefaultRunLoopMode]];
        
        
        /*
         结果：Selector 执行，顺序：1、2、3、4
         分析：子线程runloop是懒加载+开发者自己开启
         */
//        [self performSelector:@selector(testAction)
//                   withObject:nil
//                   afterDelay:1
//                      inModes:@[NSDefaultRunLoopMode]];
//        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
//        [currentRunLoop run];
        
        
        /*
         结果：1、2、3
         分析：`[[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];` 已经创建的当前子线程对应的 RunLoop 对象并启动了，因此可以执行Selector方法；但是Selector方法执行完后，RunLoop 并没有结束（使用这种启动方式，可以设置超时时间，在超时时间到达之前，runloop会一直运行，在此期间runloop会处理来自输入源的数据，并且会在 `NSDefaultRunLoopMode` 模式下重复调用 `runMode:beforeDate:` 方法）所以无法继续输出 4。
         */
//        [self performSelector:@selector(testAction)
//                     onThread:[NSThread currentThread]
//                   withObject:nil
//                waitUntilDone:NO];
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        
        
        NSLog(@"4 - %@", [NSThread currentThread]);
    }];
    [thread start];
}


- (void)testAction {
    NSLog(@"3 - %@", [NSThread currentThread]);
}

@end
