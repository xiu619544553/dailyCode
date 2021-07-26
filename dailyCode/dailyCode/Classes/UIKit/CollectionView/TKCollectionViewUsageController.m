//
//  TKCollectionViewUsageController.m
//  dailyCode
//
//  Created by hello on 2021/7/21.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKCollectionViewUsageController.h"
#import "TKDynamicSpaceViewController.h"
#import "TKCollectionViewController.h"

typedef NS_ENUM(NSInteger, TKCollectionViewUsageType) {
    TKCollectionViewUsageTypeCommon = 999,
    TKCollectionViewUsageTypeDynamic
};

@interface TKCollectionViewUsageController ()

@end

@implementation TKCollectionViewUsageController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = ({
        UIButton *btn = [self btnWithFrame:CGRectMake(15.f, 100.f, self.view.width - 30.f, 30.f)
                                     title:@"普通用法"
                                    action:@selector(btnAction:)
                                       tag:TKCollectionViewUsageTypeCommon];
        btn;
    });
    
    UIButton *dynamicBtn = ({
        UIButton *btn = [self btnWithFrame:CGRectMake(btn1.left, btn1.bottom + 10, btn1.width, btn1.height)
                                     title:@"动态间距"
                                    action:@selector(btnAction:)
                                       tag:TKCollectionViewUsageTypeDynamic];
        btn;
    });
}

#pragma mark - Action Methods

- (void)btnAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    
    if (tag == TKCollectionViewUsageTypeCommon) {
        
        TKCollectionViewController *commonVC = [TKCollectionViewController new];
        [self.navigationController pushViewController:commonVC animated:YES];
        
    } else if (tag == TKCollectionViewUsageTypeDynamic) {
        
        TKDynamicSpaceViewController *dsVC = [TKDynamicSpaceViewController new];
        [self.navigationController pushViewController:dsVC animated:YES];
        
    }
}

- (UIButton *)btnWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.orangeColor;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    return btn;
}
@end
