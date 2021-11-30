//
//  TKThread.h
//  RunLoopInterviewQuestion
//
//  Created by hello on 2021/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKThread : NSObject

/// 运行
- (void)run;

/// 线程执行任务
- (void)executeTask:(void (^)(void))task;

/// 停止/销毁
- (void)stop;

@end

NS_ASSUME_NONNULL_END
