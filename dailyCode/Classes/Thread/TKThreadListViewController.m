//
//  TKThreadListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKThreadListViewController.h"

@interface TKThreadListViewController ()

@end

@implementation TKThreadListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

@synthesize dataSource = _dataSource;

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC : @"TK_dispatch_barrier_ViewController",
                KeyForDesc : @"栅栏函数：dispatch_barrier_asyn、dispatch_barrier_syn"
            }
        ];
    }
    return _dataSource;
}

@end
