//
//  TKArrayMapper.h
//  dailyCode
//
//  Created by hello on 2020/11/17.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKArrayMapper<ObjectType, ResultType> : NSObject

+ (NSArray<ResultType> *)mapArray:(NSArray<ObjectType> *)input
                            block:(ResultType(^)(ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
