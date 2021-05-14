//
//  MasonryUsageViewController.m
//  test
//
//  Created by hello on 2020/7/6.
//  Copyright © 2020 TK. All rights reserved.
//

#import "MasonryUsageViewController.h"
#import <Masonry.h>

#define KeyForVC   @"vc"
#define KeyForDesc @"desc"

static NSString *tableViewCellId = @"UITableViewCell";

@interface MasonryUsageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MasonryUsageViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Masonry 用法";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableVeiwDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    Class vcCls = NSClassFromString(dict[KeyForVC]);
    if (!vcCls) return;
    
    UIViewController *vc = [[vcCls alloc] init];
    vc.title = dict[KeyForDesc];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *vcClsName = dict[KeyForVC];
    NSString *vcDesc = dict[KeyForDesc];
    
    cell.textLabel.text = vcClsName;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = vcDesc;
    
    return cell;
}

#pragma mark - getter

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            @{
                KeyForVC   : @"TKAverageVC",
                KeyForDesc : @"Masonry 实现等分【水平、垂直 2个方向】【等宽、登高】"
            },
            @{
                KeyForVC   : @"TKMasonryAnimateVC",
                KeyForDesc : @"Masonry 动画"
            },
            @{
                KeyForVC   : @"TKAutoLayoutCellController",
                KeyForDesc : @"自动布局 cell"
            },
            @{
                KeyForVC   : @"TKSafeAreaInsetsViewController",
                KeyForDesc : @"关于 safeAreaInsets 属性"
            },
            @{
                KeyForVC   : @"TKMasonryOtherViewController",
                KeyForDesc : @"Masonry 练手"
            },
            @{
                KeyForVC   : @"TKAutolayoutViewController",
                KeyForDesc : @"自动布局cell"
            }
        ];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end
