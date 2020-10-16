//
//  TKSafeAreaInsetsViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKSafeAreaInsetsViewController.h"

@interface TKSafeAreaInsetsViewController ()
@property (nonatomic, strong) UIView *testSafeAreaView;
@end

@implementation TKSafeAreaInsetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于 safeAreaInsets 属性";
    [self.view addSubview:self.testSafeAreaView];
    
    if (@available(iOS 11.0, *)) { // {0, 0, 0, 0}
        DLog(@"safeAreaInsets =%@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
    }
    
    
//    __weak typeof(self) wself = self;
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        __strong typeof(wself) sself = wself;
//        if (!self) return;
//
//        DLog(@"...UIApplicationDidChangeStatusBarOrientationNotification...");
//
//        [sself.view setNeedsUpdateConstraints];
//        [sself updateFocusIfNeeded];
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 11.0, *)) { // {0, 0, 0, 0}
        DLog(@"safeAreaInsets =%@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (@available(iOS 11.0, *)) { // 竖屏：{88, 0, 34, 0} 、横屏：{44, 44, 21, 44}
        DLog(@"safeAreaInsets =%@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (@available(iOS 11.0, *)) { // 竖屏：{88, 0, 34, 0} 、横屏：{44, 44, 21, 44}
        DLog(@"safeAreaInsets =%@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
    }
    
    
    [self.testSafeAreaView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.insets(self.view.safeAreaInsets);
        } else {
            make.edges.insets(UIEdgeInsetsZero);
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (@available(iOS 11.0, *)) { // 竖屏：{88, 0, 34, 0} 、横屏：{44, 44, 21, 44}
        DLog(@"safeAreaInsets =%@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
    }
}

// 首次进入控制器，iphone调用了，但是ipad 未调用该方法
- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    if (@available(iOS 11.0, *)) { // 竖屏：{88, 0, 34, 0} 、横屏：{44, 44, 21, 44}
        DLog(@"safeAreaInsets =%@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - getter

- (UIView *)testSafeAreaView {
    if (!_testSafeAreaView) {
        _testSafeAreaView = [UIView new];
        _testSafeAreaView.backgroundColor = UIColor.systemPinkColor;
    }
    return _testSafeAreaView;
}
@end
