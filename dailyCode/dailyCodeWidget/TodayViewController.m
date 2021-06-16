//
//  TodayViewController.m
//  dailyCodeWidget
//
//  Created by hello on 2020/10/28.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Masonry/Masonry.h>

#define kLogMethodName  NSLog(@"...%s...%d", __func__, __LINE__);

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    kLogMethodName
    
    // 添加全局的手势
    [self addGlobalTapGestureRecognizer];
    
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn setTitle:@"共享数据" forState:UIControlStateNormal];
    testBtn.backgroundColor = UIColor.blackColor;
    [testBtn addTarget:self action:@selector(testBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100.f, 35.f));
    }];
}

- (void)testBtnAction:(UIButton *)sender {
    kLogMethodName
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.tank.dailyCode.dailyCodeWidget"];
    id params = [userDefaults objectForKey:@"dailyCodeWidget"];
    NSLog(@"params = %@", params);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"self.view.frame = %@", NSStringFromCGRect(self.view.frame));
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    kLogMethodName
    
    completionHandler(NCUpdateResultNewData);
}



- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {

    self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, MIN(100, maxSize.height));
}

#pragma mark - Event Methods

// 添加全局的手势
- (void)addGlobalTapGestureRecognizer {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMainApp:)];
    [self.view addGestureRecognizer:tapGesture];
}

// 打开 host app
- (void)openMainApp:(UITapGestureRecognizer *)sender {
    // 可以在 scheme `liteDailyCode://` 后面添加 path和query，使 host app跳转到指定页面。
    NSURL *appUrl = [NSURL URLWithString:@"liteDailyCode://"];
    [self.extensionContext openURL:appUrl completionHandler:^(BOOL success) {
        NSLog(@"success == %@", success ? @"YES" : @"NO");
    }];
}
@end
