//
//  TKKVCPerson.m
//  dailyCode
//
//  Created by hello on 2021/7/27.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKKVCPerson.h"

@implementation TKKVCPerson {
    NSInteger _age;
}

- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    
    NSLog(@"%s", __func__);
}

+ (BOOL)accessInstanceVariablesDirectly {
    
    NSLog(@"%s", __func__);
    
    return NO;
}

- (NSInteger)readAge {
    return _age;
}

@end
