//
//  TKMasonryOtherViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKMasonryOtherViewController.h"
#import <Masonry.h>

@interface TKMasonryOtherViewController ()
@property (nonatomic, strong) UIView *testView;
@end

@implementation TKMasonryOtherViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10.f);
    }];
}

#pragma mark - getter

- (UIView *)testView {
    if (!_testView) {
        _testView = [UIView new];
        _testView.backgroundColor = UIColor.cyanColor;
    }
    return _testView;
}
@end
