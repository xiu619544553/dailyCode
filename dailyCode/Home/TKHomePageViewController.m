//
//  TKHomePageViewController.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKHomePageViewController.h"


#define KeyForVC   @"vc"
#define KeyForDesc @"desc"

static NSString *homePageCellID = @"UITableViewCell";

@interface TKHomePageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataSource;
@end

@implementation TKHomePageViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableVeiwDelegate

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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:homePageCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
    NSString *vcClsName = dict[KeyForVC];
    NSString *vcDesc = dict[KeyForDesc];
    
    cell.textLabel.text = vcClsName;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = vcDesc;
    
    return cell;
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

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray<NSDictionary<NSString *,NSString *> *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"StudyDocumentInteractionController",
                KeyForDesc : @"学习苹果提供的文档交互控制器：DocumentInteractionController"
            },
            @{
                KeyForVC   : @"WebViewController",
                KeyForDesc : @"学习 WKWebView"
            },
            @{
                KeyForVC   : @"ResponderChainViewController",
                KeyForDesc : @"响应者链、hit-test机制"
            },
            @{
                KeyForVC   : @"AboutLineSpacingViewController",
                KeyForDesc : @"在iOS中如何正确的实现行间距与行高",
            },
            @{
                KeyForVC   : @"AboutScrollViewLayoutViewController",
                KeyForDesc : @"contentInsetAdjustmentBehavior 和 automaticallyAdjustsScrollViewInsets"
            },
            @{
                KeyForVC   : @"JSONSerializationViewController",
                KeyForDesc : @"NSJSONSerialization"
            },
            @{
                KeyForVC   : @"AboutScrollViewPropertyController",
                KeyForDesc : @"关于 UIScrollView 的属性的尝试"
            },
            @{
                KeyForVC   : @"LabelViewController",
                KeyForDesc : @"关于 UILabel 的属性的尝试"
            },
            @{
                KeyForVC   : @"GradientLayerViewController",
                KeyForDesc : @"关于 CAGradientLayer 的尝试"
            },
            @{
                KeyForVC   : @"AsyncDecoderImageViewController",
                KeyForDesc : @"关于 【异步解码图片】 的尝试"
            },
            @{
                KeyForVC   : @"TestSuccessViewController",
                KeyForDesc : @"关于 【适配】 的尝试"
            },
            @{
                KeyForVC   : @"TreeTableViewController",
                KeyForDesc : @"🌲🌲🌲关于 【多级cell】 的尝试"
            },
            @{
                KeyForVC   : @"TKRegularViewController",
                KeyForDesc : @"正则表达式"
            },
            @{
                KeyForVC   : @"OptionalViewController",
                KeyForDesc : @"optional"
            },
            @{
                KeyForVC   : @"LayoutViewController",
                KeyForDesc : @"layoutSubViews 调用时机"
            },
            @{
                KeyForVC   : @"AboutAlertViewController",
                KeyForDesc : @"AlertViewController 在 iPad中的使用"
            },
            @{
                KeyForVC   : @"MasonryUsageViewController",
                KeyForDesc : @"Masonry 的使用"
            },
            @{
                KeyForVC   : @"ShadowVC",
                KeyForDesc : @"shadow 阴影"
            },
            @{
                KeyForVC   : @"TKMacroViewController",
                KeyForDesc : @"常见宏使用"
            },
            @{
                KeyForVC   : @"TKAutolayoutViewController",
                KeyForDesc : @"自动布局cell"
            },
            @{
                KeyForVC   : @"TKAFNDemoViewController",
                KeyForDesc : @"AFNetworking demo"
            },
            @{
                KeyForVC   : @"TKSortedViewController",
                KeyForDesc : @"排序"
            },
            @{
                KeyForVC   : @"TKScalePropertyViewController",
                KeyForDesc : @"scale 属性"
            },
            @{
                KeyForVC   : @"TKSDWebImageUsageViewController",
                KeyForDesc : @"SDWebImage 用法"
            }
        ];
    }
    return _dataSource;
}
@end
