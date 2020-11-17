//
//  TKArrayMapper.m
//  dailyCode
//
//  Created by hello on 2020/11/17.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKArrayMapper.h"

@implementation TKArrayMapper

+ (NSArray *)mapArray:(NSArray *)input block:(id  _Nonnull (^)(id _Nonnull))block {
    if (input == nil || input.count == 0) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:input.count];
    [input enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:block(obj)];
    }];
    return result.copy;
}

@end
