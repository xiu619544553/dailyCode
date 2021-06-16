//
//  TKAccount.m
//  dailyCode
//
//  Created by hello on 2021/6/16.
//  Copyright © 2021 TK. All rights reserved.
/*
 使用经典的存钱-取钱案例。
 假设我们账号里面有100元，每次存钱都存10元，每次取钱都取20元。存5次，取5次。那么就是应该最终剩下50元才对。如果我们把存和取钱在不同的线程中访问的时候，如果不加锁，就很可能导致问题。
 */

#import "TKAccount.h"

@interface TKAccount ()
@property (nonatomic, assign) int money;
@end

@implementation TKAccount

// 存钱、取钱演示
- (void)moneyTest {
    self.money = 100;
    
    /*
     存与取钱，允许在不同的线程中同时操作，最终结果会导致用户的账户余额不是 50元。
     */
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self drawMoney];
        }
    });
}

// 存钱
- (void)saveMoney {
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 10;
    self.money = oldMoney;
    
    NSLog(@"存10元，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

// 取钱
- (void)drawMoney {
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    
    NSLog(@"取20元，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}


@end
