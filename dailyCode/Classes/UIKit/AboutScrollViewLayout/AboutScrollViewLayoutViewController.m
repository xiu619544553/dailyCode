//
//  AboutScrollViewLayoutViewController.m
//  test
//
//  Created by hello on 2020/6/9.
//  Copyright © 2020 TK. All rights reserved.
//  contentInsetAdjustmentBehavior 和 automaticallyAdjustsScrollViewInsets

#import "AboutScrollViewLayoutViewController.h"

@interface AboutScrollViewLayoutViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AboutScrollViewLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"系统版本: %@", [UIDevice currentDevice].systemVersion];
    [self.view addSubview:self.tableView];
    

    /*
     contentInsetAdjustmentBehavior 是UIScrollView及其子类的属性，控制scrollView的显示的内容是否被导航栏及tabBar遮挡。
        * UIScrollViewContentInsetAdjustmentAutomatic : 默认值。scrollView或其子类不会被导航栏及tabbar遮挡
        * UIScrollViewContentInsetAdjustmentNever     : scrollView或其子类会被导航栏及tabbar遮挡
        * UIScrollViewContentInsetAdjustmentAlways    : contentInset总是由滚动视图的safeAreaInsets进行调整
     
     
     
     automaticallyAdjustsScrollViewInsets 是 UIViewController的属性。
        作用：控制器是否自动调整 UIScrollView 的内边距，即 UIScrollView 显示内容是否允许被 navigationBar 及 tabbar 遮挡。
        * YES，默认值。scrollView或其子类不会被导航栏及tabbar遮挡
        * NO，scrollView或其子类会被导航栏及tabbar遮挡
     */
    
    if (@available(iOS 11.0, *)) {
        // UIScrollViewContentInsetAdjustmentNever
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    
    /*
 环境：
    * iPhone 11 Pro Max
    * 系统版本：13.4.1
    * NavBar 和 tabbar均在；
    * self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
 
 结果：
  <
 UITableView:
     frame = (0 0; 414 896);
     clipsToBounds = YES;
     contentOffset: {0, -88}; ----> 如果设置了UIScrollView不被导航栏遮挡，则Y轴偏移量为导航栏+状态栏高度的负数值，即 -(导航栏+状态栏)
     contentSize: {414, 1100};
     adjustedContentInset: {88, 0, 83, 0};  iOS11增加的属性：适配后的内边距
 
     
 打印结果：contentInset = {0, 0, 0, 0}
 >
 
 
 
 
 
 环境：
    * iPhone 6S
    * 系统版本：10.3.1
    * NavBar 和 tabbar 均在；
    * self.automaticallyAdjustsScrollViewInsets = YES;
 
 结果：
 <
 UITableView:
 frame = (0 0; 375 667);
 contentOffset: {0, -64};
 contentSize: {375, 1100}>
 
 打印结果：contentInset = {64, 0, 49, 0}
 
 
 
 
 contentInsetAdjustmentBehavior 或 automaticallyAdjustsScrollViewInsets 会影响 UIScrollView 的contentOffset的值：
    * UIScrollViewContentInsetAdjustmentAutomatic 或 YES，则 contentOffset.y = -(导航栏+状态栏) - (contentInsets.top)
    * UIScrollViewContentInsetAdjustmentNever 或 NO，则 contentOffset.y = - contentInsets.top
     
     */
    
    NSLog(@"%@", self.tableView);
    NSLog(@"tableView.contentInset = %@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"row = %@", @(indexPath.row)];
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}
@end
