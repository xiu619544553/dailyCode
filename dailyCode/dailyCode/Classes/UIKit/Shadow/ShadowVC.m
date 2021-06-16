//
//  ShadowVC.m
//  test
//
//  Created by hello on 2020/7/8.
//  Copyright © 2020 TK. All rights reserved.
//

#import "ShadowVC.h"

@interface ShadowVC ()

@end

@implementation ShadowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 给 UIButton 添加阴影
    UIButton *shadowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shadowBtn.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:shadowBtn];
    [shadowBtn setTitle:@"阴影按钮" forState:UIControlStateNormal];
    [shadowBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    shadowBtn.frame = CGRectMake(100.f, 200.f, 200.f, 50.f);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowBtn.bounds];
    
    shadowBtn.layer.cornerRadius = 5.f;
    shadowBtn.layer.shadowColor = UIColor.blackColor.CGColor;    // 阴影颜色
    shadowBtn.layer.shadowOffset = CGSizeMake(-3.f, 0.f);        // 偏移量
    shadowBtn.layer.shadowRadius = shadowBtn.layer.cornerRadius; // 圆角
    shadowBtn.layer.shadowOpacity = 0.5;                         // 不透明度
    shadowBtn.layer.shadowPath = path.CGPath;                    // 阴影路径
}
@end
