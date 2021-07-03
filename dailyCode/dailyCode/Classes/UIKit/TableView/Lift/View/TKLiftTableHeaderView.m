//
//  TKLiftTableHeaderView.m
//  dailyCode
//
//  Created by hello on 2020/9/2.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKLiftTableHeaderView.h"

static NSUInteger TKLiftButtonTagStartIndex = 10086;

@interface TKLiftTableHeaderView ()

@property (nonatomic, strong) UIScrollView *btnContainerScrollView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UIButton *assistBtn;

@end

@implementation TKLiftTableHeaderView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 默认选中0
        _selectedIndex = 0;
        
        [self addSubview:self.btnContainerScrollView];
        [self addSubview:self.sliderView];
        
    }
    return self;
}

#pragma mark - Event Methods

- (void)titleBtnAction:(UIButton *)sender {
    // 不处理按钮重复点击事件
    if (sender.isSelected) return;
    
    self.assistBtn = sender;
    
    [self updateSliderFrame];
    
    NSUInteger index = sender.tag - TKLiftButtonTagStartIndex;
    if (self.actionBlock) {
        self.actionBlock(index);
    }
    
    DLog(@"下标：%@，标题：%@", @(index), _titles[index]);
}

#pragma mark - Private Methods

- (void)updateSliderFrame {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.centerX = self.assistBtn.centerX;
    }];
}

#pragma mark - setter

- (void)setTitles:(NSArray<NSString *> *)titles {
    
    if (titles == _titles) return;
    if (titles.count == 0 || titles == nil) return;
    
    _titles = titles;
    _assistBtn = nil;
    
    // 清除所有视图
    [self.btnContainerScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    // 布局按钮
    [self layoutBtns];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex == _selectedIndex) return;
    
    _selectedIndex = selectedIndex;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.btnContainerScrollView.subviews.count > selectedIndex) {
            self.sliderView.centerX = [self.btnContainerScrollView.subviews objectAtIndex:selectedIndex].centerX;
        }
    }];
}

#pragma mark - Private Methods

// 布局按钮
- (void)layoutBtns {
    [_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnContainerScrollView addSubview:btn];
        
        btn.tag = TKLiftButtonTagStartIndex + idx;
        [btn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.grayColor forState:UIControlStateSelected];
        
        
        CGFloat btnX = self.assistBtn ? self.assistBtn.right : 0.f;
        CGFloat btnWidth = [obj sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}].width + 20.f;
        btn.frame = CGRectMake(btnX, 0.f, btnWidth, self.height - 10.f);
        
        self.assistBtn = btn;
        
        // 默认选中第一个按钮
        if (idx == 0) {
            [self titleBtnAction:btn];
        }
    }];
    
    
    CGFloat scrollViewContentWidth = self.assistBtn.right > self.btnContainerScrollView.width ? self.assistBtn.right : self.btnContainerScrollView.width;
    self.btnContainerScrollView.contentSize = CGSizeMake(scrollViewContentWidth, 0.f);
}

#pragma mark - getter

- (UIView *)sliderView {
    if (!_sliderView) {
        CGFloat sliderH = 3.f;
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.height - sliderH, 15.f, sliderH)];
        _sliderView.backgroundColor = UIColor.redColor;
    }
    return _sliderView;
}

- (UIScrollView *)btnContainerScrollView {
    if (!_btnContainerScrollView) {
        _btnContainerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.width, self.height - 10.f)];
    }
    return _btnContainerScrollView;
}
@end
