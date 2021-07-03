//
//  TKBasePlainTableViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKBasePlainTableViewController.h"
#import <Masonry.h>

@interface TKBasePlainTableViewController ()

@end

@implementation TKBasePlainTableViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    [self addNotifications];
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = kFontForPFRegular(16.f);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (self.dataSource.count > indexPath.row) {
        NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = dict[KeyForDesc];
    }
    
    return cell;
}

#pragma mark - Private Methods

- (void)addNotifications {
    __weak typeof(self) wself = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(wself) sself = wself;
        if (!sself) return;
        [self.tableView reloadData];
    }];
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
    }
    return _tableView;
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
}
@end
