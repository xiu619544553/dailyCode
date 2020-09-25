//
//  TKUIViewCategoryUsageViewController.m
//  dailyCode
//
//  Created by hello on 2020/9/25.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKUIViewCategoryUsageViewController.h"
#import <UIView+TKAdd.h>

@interface TKUIViewCategoryUsageViewController ()

@end

@implementation TKUIViewCategoryUsageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(100, 200, 120, 30);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];

    //设置view的左上和右下为圆角
    if ([view respondsToSelector:@selector(setCornerByRoundingCorners:cornerRadius:)]) {
        NSLog(@"响应");
        [view setCornerByRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadius:10.f];
    } else {
        NSLog(@"不响应");
    }
    
    

    
    UILabel *testLbl = [UILabel new];
    testLbl.frame = CGRectMake(100, 300, 120, 30);
    testLbl.font = [UIFont systemFontOfSize:14];
    testLbl.textAlignment = NSTextAlignmentCenter;
    testLbl.text = @"看我的圆角边框";
    [self.view addSubview:testLbl];
    
    // 绘制label边框,左下和右上为圆角
    if ([testLbl respondsToSelector:@selector(setCornerByRoundingCorners:cornerRadius:borderColor:)]) {
        NSLog(@"响应");
        [testLbl setCornerByRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadius:10.f borderColor:UIColor.blackColor];
    } else {
        NSLog(@"不响应");
    }
}

@end
