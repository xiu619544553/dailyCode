//
//  TKUIKitListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKUIKitListViewController.h"

@interface TKUIKitListViewController ()

@end

@implementation TKUIKitListViewController

@synthesize dataSource = _dataSource;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - getter

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"TKUIViewCategoryUsageViewController",
                KeyForDesc : @"UIView"
            },
            @{
                KeyForVC   : @"LabelViewController",
                KeyForDesc : @"UILabel"
            },
            @{
                KeyForVC   : @"TKButtonUsageViewController",
                KeyForDesc : @"UIButton"
            },
            @{
                KeyForVC   : @"TKScrollViewViewController",
                KeyForDesc : @"UIScrollView"
            },
            @{
                KeyForVC   : @"TKTableViewUsageListViewController",
                KeyForDesc : @"UITableView"
            },
            @{
                KeyForVC   : @"TKCollectionViewUsageController",
                KeyForDesc : @"UICollectionView"
            },
            @{
                KeyForVC   : @"TKTextViewController",
                KeyForDesc : @"UITextView"
            },
            @{
                KeyForVC   : @"TKImageAPIUsageListVC",
                KeyForDesc : @"UIImage"
            },
            @{
                KeyForVC   : @"WebViewController",
                KeyForDesc : @"WKWebView"
            },
            @{
                KeyForVC : @"TKGestureRecognizerViewController",
                KeyForDesc : @"UIGestureRecognizer"
            },
            @{
                KeyForVC : @"TKPageViewController",
                KeyForDesc : @"UIPageViewController"
            },
            @{
                KeyForVC   : @"AboutAlertViewController",
                KeyForDesc : @"UIAlertViewController"
            },
            @{
                KeyForVC   : @"TKImagePickerController",
                KeyForDesc : @"UIImagePickerController"
            },
            @{
                KeyForVC   : @"TKColorUsageViewController",
                KeyForDesc : @"UIColor"
            },
            @{
                KeyForVC   : @"StudyDocumentInteractionController",
                KeyForDesc : @"UIDocumentInteractionController"
            },
            @{
                KeyForVC : @"TKFontListViewController",
                KeyForDesc : @"UIFont"
            },
            @{
                KeyForVC   : @"ViewController",
                KeyForDesc : @"获取 topViewController"
            },
            @{
                KeyForVC   : @"AboutScrollViewLayoutViewController",
                KeyForDesc : @"1.contentInsetAdjustmentBehavior 2.automaticallyAdjustsScrollViewInsets"
            },
            @{
                KeyForVC   : @"ShadowVC",
                KeyForDesc : @"shadow 阴影"
            },
            @{
                KeyForVC   : @"TKTestShadowVC",
                KeyForDesc : @"阴影测试"
            },
            @{
                KeyForVC   : @"TKScrollViewAndNavVC",
                KeyForDesc : @"控制器属性 UIRectEdge、导航栏属性 translucent"
            },
            @{
                KeyForVC   : @"LayoutViewController",
                KeyForDesc : @"layoutSubViews 调用时机"
            },
            @{
                KeyForVC   : @"TreeTableViewController",
                KeyForDesc : @"关于 【多级cell】 的尝试"
            },
            @{
                KeyForVC : @"TKInputViewController",
                KeyForDesc : @"轻量级评论输入框,支持多种样式,支持占位符设置等等!"
            }
        ];
    }
    return _dataSource;
}

@end
