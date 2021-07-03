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
