//
//  TKAutolayoutViewController.m
//  test
//
//  Created by hello on 2020/7/22.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKAutolayoutViewController.h"
#import "TKAutolayoutCell.h"

@interface TKAutolayoutViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TKAutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.whiteColor;

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
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TKAutolayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TKAutolayoutCell.class) forIndexPath:indexPath];
    
    
    NSString *title = [NSString stringWithFormat:@"标题：%@", @(indexPath.row)];
    NSString *info = [NSString stringWithFormat:@"已批改 %@次，剩余 %@次批改", @(indexPath.row), @(indexPath.row - 1)];
    
    [cell updateDataWithTitle:title desc:@"描述描述" info:info];
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 150.f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerClass:TKAutolayoutCell.class forCellReuseIdentifier:NSStringFromClass(TKAutolayoutCell.class)];
    }
    return _tableView;
}
@end
