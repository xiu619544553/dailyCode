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
                KeyForVC   : @"StudyDocumentInteractionController",
                KeyForDesc : @"文档交互控制器 UIDocumentInteractionController"
            },
            @{
                KeyForVC   : @"WebViewController",
                KeyForDesc : @"WKWebView"
            },
            @{
                KeyForVC   : @"ResponderChainViewController",
                KeyForDesc : @"响应者链、hit-test机制"
            },
            @{
                KeyForVC   : @"AboutScrollViewLayoutViewController",
                KeyForDesc : @"1.contentInsetAdjustmentBehavior 2.automaticallyAdjustsScrollViewInsets"
            },
            @{
                KeyForVC   : @"LabelViewController",
                KeyForDesc : @"关于 UILabel 的属性的尝试"
            },
            @{
                KeyForVC   : @"AsyncDecoderImageViewController",
                KeyForDesc : @"关于 【异步解码图片】 的尝试"
            },
            @{
                KeyForVC   : @"TreeTableViewController",
                KeyForDesc : @"关于 【多级cell】 的尝试"
            },
            @{
                KeyForVC   : @"TKRegularViewController",
                KeyForDesc : @"正则表达式"
            },
            @{
                KeyForVC   : @"OptionalViewController",
                KeyForDesc : @"NS_OPTIONS 与 NS_ENUM 区别"
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
                KeyForDesc : @"AFNetworking"
            },
            @{
                KeyForVC   : @"TKSDWebImageUsageViewController",
                KeyForDesc : @"SDWebImage"
            },
            @{
                KeyForVC   : @"TKImagePickerController",
                KeyForDesc : @"UIImagePickerController 使用、旋转等等"
            },
            @{
                KeyForVC   : @"TKTextViewController",
                KeyForDesc : @"UITextView 使用"
            },
            @{
                KeyForVC   : @"TKButtonUsageViewController",
                KeyForDesc : @"Button 使用"
            },
            @{
                KeyForVC   : @"TKColorUsageViewController",
                KeyForDesc : @"Color 使用"
            },
            @{
                KeyForVC   : @"TKBackgroundTaskVC",
                KeyForDesc : @"后台任务"
            },
            @{
                KeyForVC   : @"TKCollectionViewController",
                KeyForDesc : @"UICollectionView 使用"
            },
            @{
                KeyForVC   : @"TKTableViewUsageListViewController",
                KeyForDesc : @"UITableView 使用"
            },
            @{
                KeyForVC   : @"TKFeedbackGeneratorViewController",
                KeyForDesc : @"震动反馈 API"
            },
            @{
                KeyForVC   : @"TKScrollViewViewController",
                KeyForDesc : @"UIScrollView 使用"
            },
            @{
                KeyForVC   : @"TKPageManagerViewController",
                KeyForDesc : @"WMPageController 使用"
            },
            @{
                KeyForVC   : @"TKUIViewCategoryUsageViewController",
                KeyForDesc : @"UIView分类用法"
            },
            @{
                KeyForVC   : @"TKScrollViewAndNavVC",
                KeyForDesc : @"控制器属性 UIRectEdge、导航栏属性 translucent"
            },
            @{
                KeyForVC   : @"ViewController",
                KeyForDesc : @"获取 topViewController"
            },
            @{
                KeyForVC   : @"TKImageAPIUsageListVC",
                KeyForDesc : @"UIImage API使用"
            },
            @{
                KeyForVC   : @"TKTestShadowVC",
                KeyForDesc : @"阴影测试"
            }
        ];
    }
    return _dataSource;
}

@end
