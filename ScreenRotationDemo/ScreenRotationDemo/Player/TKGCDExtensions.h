//
//  TKGCDExtensions.h
//  ScreenRotationDemo
//
//  Created by hello on 2022/6/27.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN void TKDispatchSyncOnMainQueue(void (^block)(void));

UIKIT_EXTERN void TKDispatchAsyncOnMainQueue(void (^block)(void));

UIKIT_EXTERN void TKDispatchAsyncOnQueue(dispatch_queue_t queue, void (^block)(void));

UIKIT_EXTERN void TKDispatchSyncOnQueue(dispatch_queue_t queue, void (^block)(void));

UIKIT_EXTERN void TKDispatchAsyncOnNextRunloop(void (^block)(void));

UIKIT_EXTERN void TKDispatchAfterTimeIntervalInSecond(NSTimeInterval timeInterval, void (^block)(void));

/**
 * benchmark 工具(返回值为代码每次执行耗时, 单位为 ns), 注意线上环境禁用.
 *
 * @param count benchmark 次数.
 * @param block benchmark 代码.
 */
UIKIT_EXTERN int64_t tk_dispatch_benchmark(size_t count, void (^block)(void));

#define TKAssertMainThread NSAssert([NSThread isMainThread], @"代码应该在主线程调用.")

#define TKAssertNotMainThread NSAssert(![NSThread isMainThread], @"代码不应该在主线程调用.")
