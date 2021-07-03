//
//  TK3rdUsageListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK3rdUsageListViewController.h"

@interface TK3rdUsageListViewController ()

@end

@implementation TK3rdUsageListViewController

@synthesize dataSource = _dataSource;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - getter

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"MasonryUsageViewController",
                KeyForDesc : @"Masonry 的使用"
            },
            @{
                KeyForVC   : @"TKAFNDemoViewController",
                KeyForDesc : @"AFNetworking"
            },
            @{
                KeyForVC   : @"TKSDWebImageUsageViewController",
                KeyForDesc : @"SDWebImage"
            },
            @{
                KeyForVC   : @"TK_YYKit_UsageViewController",
                KeyForDesc : @"YYKit 的使用"
            },
            @{
                KeyForVC   : @"TKPageManagerViewController",
                KeyForDesc : @"WMPageController 使用"
            }
        ];
    }
    return _dataSource;
}
@end
