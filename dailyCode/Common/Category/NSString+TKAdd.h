//
//  NSString+TKAdd.h
//  test
//
//  Created by hello on 2020/5/26.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TKAdd)

/// 处理价格显示，默认保留小数点后2位，小数点后为0则忽略
/// @param priceNumberStr 传入价格，单位：元
/// @return 返回值：单位：元
+ (NSString *)handlerPriceNumber:(NSString *)priceNumberStr;

/// 处理价格显示，默认保留小数点后2位，小数点后为0则忽略
/// @param centNumberStr 传入价格，单位：分
/// @return 返回值：单位：元
+ (NSString *)handlerCentNumber:(NSString *)centNumberStr;

/// 计算 price1 - price2 的差值
+ (NSString *)subtractingWithPrice:(NSString *)price1 price2:(NSString *)price2;

/// 比较价格
+ (NSComparisonResult)comparePrice:(NSString *)price1 price2:(NSString *)price2;

@end

NS_ASSUME_NONNULL_END
