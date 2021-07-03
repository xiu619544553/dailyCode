//
//  TKImageAPIUsageListVC.m
//  dailyCode
//
//  Created by hello on 2020/11/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKImageAPIUsageListVC.h"

@interface TKImageAPIUsageListVC ()

@end

@implementation TKImageAPIUsageListVC

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
                KeyForVC   : @"TKResizableImageViewController",
                KeyForDesc : @"-resizableImageWithCapInsets"
            },
            @{
                KeyForVC : @"TKImageChangeColorVC",
                KeyForDesc : @"改变 icon 颜色"
            }
        ];
    }
    return _dataSource;
}

@end
