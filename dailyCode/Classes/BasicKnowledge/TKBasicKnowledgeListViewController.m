//
//  TKBasicKnowledgeListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKBasicKnowledgeListViewController.h"

@interface TKBasicKnowledgeListViewController ()

@end

@implementation TKBasicKnowledgeListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

@synthesize dataSource = _dataSource;

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC : @"TKThreadListViewController",
                KeyForDesc : @"线程"
            }
        ];
    }
    return _dataSource;
}

@end
