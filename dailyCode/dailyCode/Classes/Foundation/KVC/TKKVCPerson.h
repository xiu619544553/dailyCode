//
//  TKKVCPerson.h
//  dailyCode
//
//  Created by hello on 2021/7/27.
//  Copyright © 2021 TK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKKVCPerson : NSObject

@property (nonatomic, copy) NSString *nickName;

- (NSInteger)readAge;

@end

NS_ASSUME_NONNULL_END
