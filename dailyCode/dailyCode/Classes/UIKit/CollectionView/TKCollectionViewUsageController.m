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
#import "TKGridViewController.h"

typedef NS_ENUM(NSInteger, TKCollectionViewUsageType) {
    TKCollectionViewUsageTypeCommon = 999,
    TKCollectionViewUsageTypeDynamic,
    /// 九宫格
    TKCollectionViewUsageTypeGridView
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
    
    UIButton *gridBtn = ({
        UIButton *btn = [self btnWithFrame:CGRectMake(dynamicBtn.left, dynamicBtn.bottom + 10, dynamicBtn.width, dynamicBtn.height)
                                     title:@"九宫格布局，间距1像素（间距可以动态设置）"
                                    action:@selector(btnAction:)
                                       tag:TKCollectionViewUsageTypeGridView];
        btn;
    });
}

#pragma mark - Action Methods

- (void)btnAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    
    TKBaseViewController *baseVc = [TKBaseViewController new];
    
    switch (tag) {
        case TKCollectionViewUsageTypeCommon:
            baseVc = [TKCollectionViewController new];
            break;
            
        case TKCollectionViewUsageTypeDynamic:
            baseVc = [TKDynamicSpaceViewController new];
            break;
            
        case TKCollectionViewUsageTypeGridView:
            baseVc = [TKGridViewController new];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:baseVc animated:YES];
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
