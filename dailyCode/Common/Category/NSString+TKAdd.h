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

@end


#pragma mark - 处理货币价格
@interface NSString (TKMoney)

/// 默认保留小数点后2位，小数点后为0则忽略
/// @param numberStr 货币数量，单位：元
/// @return          返回值：单位：元
+ (NSString *)dealWithCurrencyDecimalPoint:(nullable NSString *)numberStr;

/// 将 `分` 转换为 `元`，默认保留小数点后2位，小数点后为0则忽略
/// @param centNumberStr 货币数量，单位：分
/// @return 返回值：单位：元
+ (NSString *)convertCentToYuan:(nullable NSString *)centNumberStr;

/// 计算价格差 `price1 - price2`
+ (nullable NSString *)subtractingWithPrice:(nullable NSString *)price1 price2:(nullable NSString *)price2;

/// 比较价格
+ (NSComparisonResult)comparePrice:(nullable NSString *)price1 price2:(nullable NSString *)price2;

@end

NS_ASSUME_NONNULL_END
