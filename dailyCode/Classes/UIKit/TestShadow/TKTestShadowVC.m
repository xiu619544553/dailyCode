//
//  TKTestShadowVC.m
//  dailyCode
//
//  Created by hello on 2020/12/11.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTestShadowVC.h"
#import "TKTestShadowCell.h"

@interface TKTestShadowVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TKTestShadowVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TKTestShadowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TKTestShadowCell.class) forIndexPath:indexPath];
    cell.name = [NSString stringWithFormat:@"row ======= %@", @(indexPath.row)];
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.rowHeight = 200.f;
        
        [_tableView registerClass:TKTestShadowCell.class forCellReuseIdentifier:NSStringFromClass(TKTestShadowCell.class)];
    }
    return _tableView;
}

@end
