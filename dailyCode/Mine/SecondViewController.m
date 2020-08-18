//
//  SecondViewController.m
//  test
//
//  Created by hello on 2020/5/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomTableViewCell.h"
#import <Masonry.h>
#import "TKTableView.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TKTableView *tableView;
@end

@implementation SecondViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.title = NSStringFromClass(self.class);
    
    
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
    
    /*
     // 设置该行代码，意味着导航栏控制器将不在透明，self的view的原点在导航栏的下面开始计算。视图高度 = 屏幕高度 - 导航栏高度
     self.navigationController.navigationBar.translucent = NO;
     // 设置该行代码，意味着Tabbar将不在透明， 。视图高度 = 屏幕高度 - Tabbar高度
     self.tabBarController.tabBar.translucent = NO;
     // 上面两行代码同时设置，则 【视图高度 = 屏幕高度 - 导航栏高度 - Tabbar高度】,等效于UIRectEdgeNone
     
     
     UIRectEdgeNone
     控制器的视图顶部不会被导航栏遮挡，视图的原点(0,0)在导航栏下开始。底部不会被Tabbar遮挡。得出公式【视图高度 = 屏幕高度 - 导航栏高度 - Tabbar高度】
        viewFrame={{0, 64}, {414, 623}}
        tableFrame={{0, 0}, {414, 736}}
     
     UIRectEdgeAll
     控制器的视图原点(0,0)在屏幕左上角开始，bottom等于Tabbar的顶部。顶部会被导航栏遮挡，底部会被Tabbar遮挡，但是不会遮挡视图的显示。得出公式视图高度 = 屏幕高度
     */
    NSLog(@"\nviewFrame=%@\ntableFrame=%@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.tableView.frame));
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CustomTableViewCell.class) forIndexPath:indexPath];
    
    NSString *name = [NSString stringWithFormat:@"姓名:%@", @(indexPath.row)];;
    NSString *tag = [NSString stringWithFormat:@"标签:%@", @(indexPath.row)];;
    NSString *count =[NSString stringWithFormat:@"已报名:%@", @(indexPath.row)];;
    
    [cell setName:name tag:tag count:count];
    return cell;
}


- (TKTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.redColor;
        
        _tableView.estimatedRowHeight = 150.f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:CustomTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CustomTableViewCell.class)];
    }
    return _tableView;
}

@end
