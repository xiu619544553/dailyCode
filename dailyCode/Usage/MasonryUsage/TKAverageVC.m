//
//  TKAverageVC.m
//  test
//
//  Created by hello on 2020/7/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKAverageVC.h"
#import <Masonry.h>

/// 布局类型
typedef NS_ENUM(NSInteger, TKAverageType) {
    /// 水平方向上，控件等宽
    TKAverageTypeHorizontalFixedItemLength = 1000,
    /// 水平方向上，控件等分
    TKAverageTypeHorizontalFixedSpacing,
    /// 垂直方向上，控件等宽
    TKAverageTypeVerticalFixedItemLength,
    /// 垂直方向上，控件等分
    TKAverageTypeVerticalFixedSpacing
};

@interface TKAverageVC ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;
@property (nonatomic, strong) NSArray<UIView *> *viewArray;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation TKAverageVC

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Masonry 实现等分";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self addSubViews];
}

- (void)addSubViews {
    UIButton *lastBtn = nil;
    _btnArray = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = TKAverageTypeHorizontalFixedItemLength; i < TKAverageTypeHorizontalFixedItemLength + 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = UIColor.whiteColor;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [_btnArray addObject:btn];
        
        NSString *btnTitle = @"";
        switch (i) {
            case TKAverageTypeHorizontalFixedItemLength:
                btnTitle = @"水平方向上，控件等宽";
                break;
                
            case TKAverageTypeHorizontalFixedSpacing:
                btnTitle = @"水平方向上，控件等分";
                break;
                
            case TKAverageTypeVerticalFixedItemLength:
                btnTitle = @"垂直方向上，控件等宽";
                break;
                
            case TKAverageTypeVerticalFixedSpacing:
            default:
                lastBtn = btn;
                btnTitle = @"垂直方向上，控件等分";
                break;
        }
        btn.tag = i;
        [btn setTitle:btnTitle forState:UIControlStateNormal];
    }
    
    
    [_btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30.f leadSpacing:15.f tailSpacing:15.f];
    [_btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50.f);
        make.height.mas_equalTo(44.f);
    }];
    
    
    
    // 状态
    [self.view addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(lastBtn.mas_bottom).offset(30.f);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 添加阴影
    [_btnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.layer.cornerRadius = 5.f;
        btn.layer.shadowColor = UIColor.blackColor.CGColor;
        btn.layer.shadowOffset = CGSizeMake(0.f, 3.f);
        btn.layer.shadowRadius = 5.f;
        btn.layer.shadowOpacity = 0.5;
        btn.layer.shadowPath = [UIBezierPath bezierPathWithRect:btn.bounds].CGPath;
    }];
}

#pragma mark - Event Methods

- (void)btnAction:(UIButton *)sender {
    
    // 移除旧视图
    if (_viewArray && _viewArray.count > 0) {
        [_viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    // 添加新视图
    _viewArray = [self viewArray];

    NSString *status = @"";
    switch (sender.tag) {
        case TKAverageTypeHorizontalFixedItemLength:
            // 水平方向上，控件等宽
            [self horizontalFixedItemLength];
            status = @"水平方向上，控件等宽";
            break;
            
        case TKAverageTypeHorizontalFixedSpacing:
            // 水平方向上，控件等分
            [self horizontalFixedSpacing];
            status = @"水平方向上，控件等分";
            break;
            
        case TKAverageTypeVerticalFixedItemLength:
            // 垂直方向上，控件等宽
            [self verticalFixedItemLength];
            status = @"垂直方向上，控件等宽";
            break;
            
        case TKAverageTypeVerticalFixedSpacing:
        default:
            // 垂直方向上，控件等分
            [self verticalFixedSpacing];
            status = @"垂直方向上，控件等分";
            break;
    }
    
    self.statusLabel.text = [NSString stringWithFormat:@"如下视图，布局类型是：%@", status];
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = 0.1;     // 执行时间
    shake.autoreverses = YES; // 是否重复
    shake.repeatCount = 2;    // 次数
    [self.statusLabel.layer addAnimation:shake forKey:@"shakeAnimation"];
}

#pragma mark - 水平方向上，控件等宽
- (void)horizontalFixedItemLength {
    
    // 1. 控件数组
    // 2. 设置布局方向、间距
    [_viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60.f leadSpacing:20.f tailSpacing:30.f];
    
    // 3. 横排的时候要相应设置控件数组的垂直约束
    [_viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200.f);
        make.height.mas_equalTo(60.f);
    }];
}

#pragma mark - 水平方向上，控件等分

- (void)horizontalFixedSpacing {
    
    // 1. 控件数组
    // 2. 设置布局方向、间距等参数
    // Axis 轴向：水平或垂直
    // FixedSpacing：视图之间的固定间距
    // leadSpacing：数组中第一个视图的头部(左侧)与父视图的间距
    // tailSpacing：数组中最后一个视图的尾部(右侧)与父视图的间距
    [_viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:15 tailSpacing:15];
    
    
    // 3. 横排的时候要相应设置控件数组的垂直约束
    [_viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200.f);
        make.height.mas_equalTo(100.f);
    }];
}

#pragma mark - 垂直方向上，控件等宽

- (void)verticalFixedItemLength {
    
    // 1. 控件数组
    // 2. 设置布局方向、间距
    [_viewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30.f leadSpacing:200.f tailSpacing:20.f];
    
    // 3. 竖排的时候要相应设置控件数字的水平约束
    [_viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100.f);
    }];
}

#pragma mark - 垂直方向上，控件等分

- (void)verticalFixedSpacing {
    
    // 1. 控件数组
    // 2. 设置布局方向、间距
    [_viewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:50.f leadSpacing:200.f tailSpacing:30.f];
    
    // 3. 竖排的时候要相应设置控件数字的水平约束
    [_viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100.f);
    }];
}

#pragma mark - getter

- (NSArray <UIView *> *)viewArray {
    
    UIView *redView = [UIView new];
    redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:redView];
    
    UIView *orangeView = [UIView new];
    orangeView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:orangeView];
    
    UIView *yellowView = [UIView new];
    yellowView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:yellowView];
    
    UIView *greenView = [UIView new];
    greenView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:greenView];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = UIColor.blueColor;
    [self.view addSubview:blueView];
    
    UIView *cyanView = [UIView new];
    cyanView.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:cyanView];
    
    UIView *purpleView = [UIView new];
    purpleView.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:purpleView];
    
    return @[redView, orangeView, yellowView, greenView, blueView, cyanView, purpleView];
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.backgroundColor = UIColor.blackColor;
        _statusLabel.textColor = UIColor.whiteColor;
        
    }
    return _statusLabel;
}
@end
