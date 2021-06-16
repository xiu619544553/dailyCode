//
//  TKSectionHeaderViewCeilingViewController.m
//  dailyCode
//
//  Created by hello on 2021/5/14.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKSectionHeaderViewCeilingViewController.h"
#import "TKSectionHeaderViewCeilingView.h"

@interface TKSectionHeaderViewCeilingViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TKSectionHeaderViewCeilingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.insets(self.view.safeAreaInsets);
        } else {
            make.edges.insets(UIEdgeInsetsZero);
        }
    }];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TKSectionHeaderViewCeilingView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(TKSectionHeaderViewCeilingView.class)];;
    headerView.tableView = tableView;
    headerView.section = section;
    
    // 第2组，不支持悬浮
    headerView.isCeiling = !(section == 1);
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", @(indexPath.section), @(indexPath.row)];
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsMake(0.f, 15.f, 0.f, 15.f);
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        
        [_tableView registerClass:TKSectionHeaderViewCeilingView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(TKSectionHeaderViewCeilingView.class)];
    }
    return _tableView;
}
@end
