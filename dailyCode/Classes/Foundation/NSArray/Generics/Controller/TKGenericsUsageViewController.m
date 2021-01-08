//
//  TKGenericsUsageViewController.m
//  dailyCode
//
//  Created by hello on 2020/11/17.
//  Copyright © 2020 TK. All rights reserved.
//  参考：https://mp.weixin.qq.com/s/hY49YSBAvK8l7tp9rMDpxg

#import "TKGenericsUsageViewController.h"
#import "TKArrayMapper.h"

@interface TKGenericsUsageViewController ()

@end

@implementation TKGenericsUsageViewController

#pragma mark - Life Cycle

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray<NSNumber *> *numbers = @[@(1), @(2), @(3)];
    
    NSArray<NSString *> *strings = [TKArrayMapper<NSNumber *, NSString *> mapArray:numbers block:^NSString * _Nonnull(NSNumber * _Nonnull obj) {
        return [obj stringValue];
    }];
    DLog(@"strings:\n%@", strings);
}

@end
