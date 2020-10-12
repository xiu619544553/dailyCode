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
    view.frame = CGRectMake(100, 50.f, 120, 30);
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
    testLbl.frame = CGRectMake(100, 50.f, 120, 30);
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
    
    
    // 二维码容器视图
    CGFloat qrContainerViewX = 20.f;
    CGFloat qrContainerViewWidth = self.view.width - qrContainerViewX * 2.f;
    CGFloat qrContainerViewHeight = 130.f;
    UIView *qrContainerView = [[UIView alloc] initWithFrame:CGRectMake(qrContainerViewX, 150, qrContainerViewWidth, qrContainerViewHeight)];
    qrContainerView.backgroundColor = UIColor.clearColor;
    
    // 绘制虚线边框
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = qrContainerView.bounds;
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale]; // 虚线宽
    borderLayer.lineDashPattern = @[@2, @2]; // 虚线边框
    borderLayer.fillColor = [UIColor clearColor].CGColor; // 填充色
    borderLayer.strokeColor = [UIColor blackColor].CGColor; // 虚线着色
    [qrContainerView.layer addSublayer:borderLayer];
    [self.view addSubview:qrContainerView];
}

@end
