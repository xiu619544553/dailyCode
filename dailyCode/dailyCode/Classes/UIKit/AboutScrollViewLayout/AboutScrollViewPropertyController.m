//
//  AboutScrollViewPropertyController.m
//  test
//
//  Created by hello on 2020/6/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "AboutScrollViewPropertyController.h"

@interface AboutScrollViewPropertyController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation AboutScrollViewPropertyController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"viewDidLoad view.bounds: %@", NSStringFromCGRect(self.view.bounds));
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.mainScrollView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.mainScrollView];
    
    self.mainScrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    
    // 添加子视图
    int count = 5;
    CGFloat height = 300.f;
    
    for (int i = 0; i < 5; i ++) {
        UIView *randomColorView = [[UIView alloc] init];
        randomColorView.backgroundColor = kRandomColor;
        [self.mainScrollView addSubview:randomColorView];
        
        CGFloat x = 10.f;
        CGFloat y = i * height;
        CGFloat width = self.view.frame.size.width - 20.f;
        
        randomColorView.frame = CGRectMake(x, y, width, height);
    }
    
    self.mainScrollView.contentSize = CGSizeMake(0, count * height);
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    DLog(@"mainScreen: %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    DLog(@"view.bounds: %@", NSStringFromCGRect(self.view.bounds));
    
    self.mainScrollView.frame = self.view.bounds;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    DLog(@"contentOffset = %@", NSStringFromCGPoint(self.mainScrollView.contentOffset));
}

#pragma mark - getter

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}
@end
