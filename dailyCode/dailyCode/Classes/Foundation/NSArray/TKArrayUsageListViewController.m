//
//  TKArrayUsageListViewController.m
//  dailyCode
//
//  Created by hello on 2020/11/17.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKArrayUsageListViewController.h"

@interface TKArrayUsageListViewController ()

@end

@implementation TKArrayUsageListViewController

@synthesize dataSource = _dataSource;

#pragma mark - getter

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"TKSortViewController",
                KeyForDesc : @"排序"
            },
            @{
                KeyForVC   : @"TKGenericsUsageViewController",
                KeyForDesc : @"泛型应用"
            }
        ];
    }
    return _dataSource;
}

@end
