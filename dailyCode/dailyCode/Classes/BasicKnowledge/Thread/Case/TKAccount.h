//
//  TKAccount.h
//  dailyCode
//
//  Created by hello on 2021/6/16.
//  Copyright © 2021 TK. All rights reserved.

/*
 使用经典的存钱-取钱案例。
 假设我们账号里面有100元，每次存钱都存10元，每次取钱都取20元。存5次，取5次。那么就是应该最终剩下50元才对。如果我们把存在和取钱在不同的线程中访问的时候，如果不加锁，就很可能导致问题。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKAccount : NSObject

/// 存钱、取钱演示
- (void)moneyTest;

/// 存钱
- (void)saveMoney;

/// 取钱
- (void)drawMoney;

@end

NS_ASSUME_NONNULL_END
