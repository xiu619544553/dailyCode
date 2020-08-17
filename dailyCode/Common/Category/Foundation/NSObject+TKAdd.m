//
//  NSObject+TKAdd.m
//  test
//
//  Created by hello on 2020/7/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "NSObject+TKAdd.h"

@implementation NSObject (TKAdd)

@end


@implementation NSObject (TKRandomNumber)

- (uint64_t)getRandomNumber:(uint64_t)from to:(uint64_t)to {
    return [self getRandomNumber:from to:to isContainFrom:YES isContainFromTo:YES];
}

- (uint64_t)getRandomNumber:(uint64_t)from to:(uint64_t)to isContainFrom:(BOOL)isContainFrom isContainFromTo:(BOOL)isContainFromTo {
    if (from > to) return -1;
    
    uint64_t base = isContainFrom ? from : (from + 1);
    uint64_t diff = isContainFromTo ? 1 : 0;
    uint64_t result = base + arc4random() % (to - from + diff);
    
    return result;
}

@end
