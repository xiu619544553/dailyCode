//
//  TKFoundationListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKFoundationListViewController.h"

@interface TKFoundationListViewController ()

@end

@implementation TKFoundationListViewController

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
                KeyForVC   : @"AboutLineSpacingViewController",
                KeyForDesc : @"正确设置行间距与行高",
            },
            @{
                KeyForVC   : @"JSONSerializationViewController",
                KeyForDesc : @"JSON 序列化"
            },
            @{
                KeyForVC   : @"AboutScrollViewPropertyController",
                KeyForDesc : @"关于 UIScrollView 的属性的尝试"
            },
            @{
                KeyForVC   : @"TKSortViewController",
                KeyForDesc : @"排序"
            },
            @{
                KeyForVC   : @"TKScalePropertyViewController",
                KeyForDesc : @"理解 scale 属性"
            }
        ];
    }
    return _dataSource;
}

@end
