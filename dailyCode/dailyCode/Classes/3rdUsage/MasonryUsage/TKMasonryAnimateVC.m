//
//  TKMasonryAnimateVC.m
//  test
//
//  Created by hello on 2020/7/11.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKMasonryAnimateVC.h"
#import <Masonry/Masonry.h>

@interface TKMasonryAnimateVC ()
@property (nonatomic, assign) BOOL flag;
@end

@implementation TKMasonryAnimateVC

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Masonry 动画";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColor.blackColor;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn setTitle:@"动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100.f, 100.f));
    }];
}

#pragma mark - Event Methods
 
- (void)btnAction:(UIButton *)sender {
    sender.enabled = NO;
    self.flag = !self.flag;
    
    // 更新约束
    [sender mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.flag ? CGSizeMake(200.f, 200.f) : CGSizeMake(100.f, 100.f));
    }];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [sender layoutIfNeeded];
    } completion:^(BOOL finished) {
        sender.enabled = YES;
    }];
}
@end
