//
//  TKSafeAccount.m
//  dailyCode
//
//  Created by hello on 2021/6/16.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKSafeAccount.h"

@interface TKSafeAccount ()

@property (nonatomic, strong) dispatch_semaphore_t smp;

@end

@implementation TKSafeAccount

- (instancetype)init {
    self = [super init];
    if (self) {
        // 设置初始信号量计数为1（最大并发数为1）
        _smp = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)saveMoney {
    dispatch_semaphore_wait(_smp, DISPATCH_TIME_FOREVER);
    [super saveMoney];
    dispatch_semaphore_signal(_smp);
}

- (void)drawMoney {
    dispatch_semaphore_wait(_smp, DISPATCH_TIME_FOREVER);
    [super drawMoney];
    dispatch_semaphore_signal(_smp);
}

@end


/*!
 * @function dispatch_semaphore_create
 *
 * @abstract 使用初始值创建新的计数信号量。
 *
 * @discussion
 *      ①当两个线程需要协调某个特定事件的完成时，传递值为0是很有用的。
 *      ②传递大于0的值对于管理有限的资源池很有用，其中池大小等于该值。
 *
 * @param value 信号量的起始值。传递一个小于零的值将导致返回NULL。
 *
 * @result 新创建的信号量，失败时为NULL。
 */
//dispatch_semaphore_t dispatch_semaphore_create(intptr_t value);


/*!
 * @function dispatch_semaphore_wait
 *
 * @abstract 等待(递减)一个信号量。
 *
 * @discussion 减少计数信号量。如果结果值小于零，则该函数等待信号出现后才返回。
 *
 * @param dsema 信号量。在这个参数中传递NULL的结果是未定义的。
 *
 * @param timeout 何时超时(参见dispatch_time)。为了方便起见，这里有DISPATCH_TIME_NOW和DISPATCH_TIME_FOREVER常数。
 *
 * @result 成功时返回零，如果发生超时则返回非零。
 */
//intptr_t dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout);


/*!
 * @function dispatch_semaphore_signal
 *
 * @abstract 发送(增加)一个信号量。
 *
 * @discussion 增加计数信号量。如果之前的值小于零，这个函数在返回之前唤醒一个等待的线程。
 *
 * @param dsema 计数信号量。在这个参数中传递NULL的结果是未定义的。
 *
 * @result 如果线程被唤醒，这个函数返回非零值。否则，返回0。
 */
//intptr_t dispatch_semaphore_signal(dispatch_semaphore_t dsema);
