//
//  TKPageManagerViewController.m
//  dailyCode
//
//  Created by hello on 2020/9/24.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKPageManagerViewController.h"
#import "TKTableViewController.h"

// 菜单的高度
static CGFloat const kWMMenuViewHeight = 44.0;

@interface TKPageManagerViewController ()
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) UIView *bannerView;
@end

@implementation TKPageManagerViewController


#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        
        _titleArray = @[@"多云转晴", @"大到暴雨"];
        
        // 设置菜单的高度
        self.menuViewHeight = kWMMenuViewHeight;
        
        // 菜单字体
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.titleFontName = @"PingFangSC-Medium";
        
        // 菜单展示的样式
        self.menuViewStyle = WMMenuViewStyleLine;
        self.automaticallyCalculatesItemWidths = YES;
        
        self.titleColorSelected = UIColor.blackColor;
        self.titleColorNormal = UIColor.grayColor;
        
        self.progressColor = UIColor.systemPinkColor;
        self.menuView.backgroundColor = [UIColor whiteColor];
        
        self.itemMargin = 30.f;
        
        self.menuViewContentMargin = -15.f;
        self.progressViewIsNaughty = YES;
//        self.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
        self.progressViewBottomSpace = 3.f;
        self.progressWidth = 23.5f;
        self.showOnNavigationBar = NO;
        
        self.title = @"";
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bannerView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.maximumHeaderViewHeight = self.bannerView.height;
    self.menuViewHeight = 44.f;
    
    
    [self reloadData];
}

#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleArray.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    TKTableViewController *vc = [TKTableViewController new];
    
    __weak typeof(self) weakSelf = self;
    vc.updateBlock = ^(CGFloat height) {
        
        weakSelf.bannerView.height = height;
        weakSelf.menuViewHeight = 44.f;
        self.maximumHeaderViewHeight = height;
        
        [weakSelf reloadData];
    };
    
    return vc;
}

//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
//    return CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49.f - self.navigationController.navigationBar.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
//}
//
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleArray[index];
}
//
//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
//    return CGRectMake(0.f, 0, kScreenWidth, 44.f);
//}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, self.maximumHeaderViewHeight, CGRectGetWidth(self.view.frame), self.menuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGRect preferredFrameForMenuView = [self pageController:pageController preferredFrameForMenuView:pageController.menuView];
    
    return CGRectMake(0,
                      CGRectGetMaxY(preferredFrameForMenuView),
                      CGRectGetWidth(preferredFrameForMenuView),
                      CGRectGetHeight(self.view.frame) -
                      CGRectGetHeight(preferredFrameForMenuView));
}

#pragma mark - getter

- (UIView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, 200.f)];
        _bannerView.backgroundColor = UIColor.yellowColor;
    }
    return _bannerView;
}
@end
