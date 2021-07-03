//
//  TKTableViewUsageListViewController.m
//  dailyCode
//
//  Created by hello on 2020/9/1.
//  Copyright © 2020 TK. All rights reserved.
//

#define KeyForVC   @"vc"
#define KeyForDesc @"desc"

#import "TKTableViewUsageListViewController.h"


@interface TKTableViewUsageListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NSDictionary *> *dataSource;

@end

@implementation TKTableViewUsageListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.insets(self.view.safeAreaInsets);
        } else {
            make.edges.equalTo(self);
        }
    }];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
    Class vcCls = NSClassFromString(dict[KeyForVC]);
    if (!vcCls) return;
    
    UIViewController *vc = [[vcCls alloc] init];
    vc.title = dict[KeyForDesc];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    
    if (self.dataSource.count > indexPath.row) {
        NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = dict[KeyForDesc];
    }
    
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray<NSDictionary *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
        _dataSource = @[
            @{
                KeyForVC   : @"TKLiftViewController",
                KeyForDesc : @"梯子视图"
            },
            @{
                KeyForVC   : @"TKScreenshotTableViewController",
                KeyForDesc : @"UITableView 截图"
            },
            @{
                KeyForVC   : @"TKClickBlankOnTableViewController",
                KeyForDesc : @"UITableView 空白处点击事件处理"
            },
            @{
                KeyForVC   : @"TKSectionHeaderViewCeilingViewController",
                KeyForDesc : @"组视图 吸顶效果"
            }
        ];
    }
    return _dataSource;
}
@end
