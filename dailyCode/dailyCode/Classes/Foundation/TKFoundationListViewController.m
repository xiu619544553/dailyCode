//
//  TKFoundationListViewController.m
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKFoundationListViewController.h"

@interface TKFoundationListViewController ()

@end

@implementation TKFoundationListViewController

@synthesize dataSource = _dataSource;

#pragma mark - getter

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC : @"TKKVCUsageViewController",
                KeyForDesc : @"KVC - Key Value Coding"
            },
            @{
                KeyForVC   : @"TK_NSURL_ViewController",
                KeyForDesc : @"NSURL"
            },
            @{
                KeyForVC   : @"TK_Notification_ViewController",
                KeyForDesc : @"NSNotification"
            },
            @{
                KeyForVC   : @"AboutLineSpacingViewController",
                KeyForDesc : @"正确设置行间距与行高",
            },
            @{
                KeyForVC   : @"JSONSerializationViewController",
                KeyForDesc : @"JSON 序列化"
            },
            @{
                KeyForVC   : @"AboutScrollViewPropertyController",
                KeyForDesc : @"关于 UIScrollView 的属性的尝试"
            },
            @{
                KeyForVC   : @"TKScalePropertyViewController",
                KeyForDesc : @"理解 scale 属性"
            },
            @{
                KeyForVC   : @"TK_NSOperationQueue_ViewController",
                KeyForDesc : @"NSOperationQueue 使用"
            },
            @{
                KeyForVC   : @"TKArrayUsageListViewController",
                KeyForDesc : @"NSArray、NSMutableArray 的一些用法"
            },
            @{
                KeyForVC   : @"TK_NSAttributed_ViewController",
                KeyForDesc : @"属性字符串应用"
            },
            @{
                KeyForVC   : @"TK_Font_TableViewController",
                KeyForDesc : @"Apple 字体列表"
            }
        ];
    }
    return _dataSource;
}

@end
