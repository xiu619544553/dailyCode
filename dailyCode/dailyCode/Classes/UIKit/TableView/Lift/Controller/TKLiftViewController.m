//
//  TKLiftViewController.m
//  dailyCode
//
//  Created by hello on 2020/9/1.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKLiftViewController.h"

#import "TKLiftTableViewCell.h"
#import "TKLiftTableHeaderView.h"
#import "TKLiftHeaderInSectionView.h"

@interface TKLiftViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) TKLiftTableHeaderView *tableHeaderView;

@end

@implementation TKLiftViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    self.titles = @[@"天气", @"音乐", @"海洋"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 初始化视图
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tableHeaderView];
    [self.view bringSubviewToFront:self.tableHeaderView];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.tableView) return;

    DLog(@"%@ %@", NSStringFromCGRect(self.tableHeaderView.frame), self.tableHeaderView.superview);
    
    if (self.tableView.contentOffset.y > 0.f) {
        self.tableHeaderView.alpha = self.tableView.contentOffset.y/100.f;
    } else {
        self.tableHeaderView.alpha = 0.f;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section >= self.titles.count) return nil;
    
    TKLiftHeaderInSectionView *header = [[TKLiftHeaderInSectionView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 44.f)];
    header.title = [self.titles objectAtIndex:section];
    return header;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TKLiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TKLiftTableViewCell.class)];
    
    self.tableHeaderView.selectedIndex = indexPath.section;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NSObject getRandomNumberFrom:50 to:200];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= self.titles.count) return 0.f;
    return 44.f;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:TKLiftTableViewCell.class forCellReuseIdentifier:NSStringFromClass(TKLiftTableViewCell.class)];
    }
    return _tableView;
}

- (TKLiftTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[TKLiftTableHeaderView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, 54.f)];
        _tableHeaderView.backgroundColor = UIColor.whiteColor;
        _tableHeaderView.titles = self.titles;
        _tableHeaderView.alpha = 0.f;
        
        __weak typeof(self) weakSelf = self;
        _tableHeaderView.actionBlock = ^(NSUInteger index) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.tableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
        };
    }
    return _tableHeaderView;
}
@end
