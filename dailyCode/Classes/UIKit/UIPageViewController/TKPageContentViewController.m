//
//  TKPageContentViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/12.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKPageContentViewController.h"

@interface TKPageContentViewController ()

@end

@implementation TKPageContentViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = UIColor.whiteColor;
    titleLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:35.f];
    titleLabel.text = [NSString stringWithFormat:@"第 %@ 页", self.pageTitle];
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100.f);
        make.height.mas_equalTo(100.f);
        make.left.right.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.lifeCycleDelegate
        && [self.lifeCycleDelegate respondsToSelector:@selector(viewController:willAppearAtIndex:)]) {
        [self.lifeCycleDelegate viewController:self willAppearAtIndex:self.pageIndex];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.lifeCycleDelegate
        && [self.lifeCycleDelegate respondsToSelector:@selector(viewController:didAppearAtIndex:)]) {
        [self.lifeCycleDelegate viewController:self didAppearAtIndex:self.pageIndex];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.lifeCycleDelegate
        && [self.lifeCycleDelegate respondsToSelector:@selector(viewController:willDisappearAtIndex:)]) {
        [self.lifeCycleDelegate viewController:self willDisappearAtIndex:self.pageIndex];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.lifeCycleDelegate
        && [self.lifeCycleDelegate respondsToSelector:@selector(viewController:didDisappearAtIndex:)]) {
        [self.lifeCycleDelegate viewController:self didDisappearAtIndex:self.pageIndex];
    }
}
@end
