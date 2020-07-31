//
//  NSString+TKAdd.m
//  test
//
//  Created by hello on 2020/5/26.
//  Copyright © 2020 TK. All rights reserved.
//

#import "NSString+TKAdd.h"

@implementation NSString (TKAdd)
+ (NSString *)handlerPriceNumber:(NSString *)priceNumberStr {
    if (priceNumberStr == nil || priceNumberStr.length == 0) {
        return nil;
    }
    NSDecimalNumberHandler *handler = [NSString defaultDecimalNumberHandler];
    NSDecimalNumber *priceDecimal = [NSDecimalNumber decimalNumberWithString:priceNumberStr];
    return [[priceDecimal decimalNumberByRoundingAccordingToBehavior:handler] stringValue];
}

+ (NSString *)handlerCentNumber:(NSString *)centNumberStr {
    if (centNumberStr == nil || centNumberStr.length == 0) {
        return nil;
    }
    
    NSDecimalNumberHandler *handler = [NSString defaultDecimalNumberHandler];
    
    // 分
    NSDecimalNumber *centDecimal = [NSDecimalNumber decimalNumberWithString:centNumberStr];
    // 换单率
    NSDecimalNumber *ratioDecimal = [NSDecimalNumber decimalNumberWithString:@"100"];
    
    return [[centDecimal decimalNumberByDividingBy:ratioDecimal withBehavior:handler] stringValue];
}

+ (NSString *)subtractingWithPrice:(NSString *)price1 price2:(NSString *)price2 {
    
    NSDecimalNumberHandler *handler = [NSString defaultDecimalNumberHandler];
    
    NSDecimalNumber *priceDecimal1 = [NSDecimalNumber decimalNumberWithString:price1];
    NSDecimalNumber *priceDecimal2 = [NSDecimalNumber decimalNumberWithString:price2];
    
    return [[priceDecimal1 decimalNumberBySubtracting:priceDecimal2 withBehavior:handler] stringValue];
}

+ (NSComparisonResult)comparePrice:(NSString *)price1 price2:(NSString *)price2 {
    
    NSDecimalNumberHandler *handler = [NSString defaultDecimalNumberHandler];
    
    NSDecimalNumber *priceDecimal1 = [NSDecimalNumber decimalNumberWithString:price1];
    NSDecimalNumber *priceDecimal2 = [NSDecimalNumber decimalNumberWithString:price2];
    
    priceDecimal1 = [priceDecimal1 decimalNumberByRoundingAccordingToBehavior:handler];
    priceDecimal2 = [priceDecimal2 decimalNumberByRoundingAccordingToBehavior:handler];
    
    return [priceDecimal1 compare:priceDecimal2];
}

#pragma mark - Private Methods

+ (NSDecimalNumberHandler *)defaultDecimalNumberHandler {
    return
    [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                           scale:2
                                                raiseOnExactness:NO
                                                 raiseOnOverflow:NO
                                                raiseOnUnderflow:NO
                                             raiseOnDivideByZero:YES];
}
@end
