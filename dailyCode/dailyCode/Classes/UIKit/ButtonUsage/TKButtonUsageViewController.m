//
//  TKButtonUsageViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/6.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKButtonUsageViewController.h"
#import "UIButton+TKAdd.h"

@interface TKButtonUsageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *touchBtn;
@property (nonatomic, strong) UIView *dotView;

@end

@implementation TKButtonUsageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.dotView];
    
    // 增大按钮点击区域
    [self.touchBtn setTouchInsets:UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f)];
}

#pragma mark - Event Methods

- (IBAction)touchBtnClick:(UIButton *)sender {
    DLog(@"按钮点击");
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    self.dotView.hidden = NO;
    self.dotView.center = point;
    
    DLog(@"%@", NSStringFromCGPoint(point));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    self.dotView.center = point;
    
    BOOL isContain = CGRectContainsPoint(self.touchBtn.frame, point);
    DLog(@"%@ %@", NSStringFromCGPoint(point), isContain ? @"在按钮区域内" : @"不在按钮区域");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.dotView.hidden = YES;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.dotView.hidden = YES;
}

#pragma mark - getter

- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [UIView new];
        _dotView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.4];
        _dotView.bounds = CGRectMake(0, 0, 10.f, 10.f);
        _dotView.layer.cornerRadius = _dotView.bounds.size.width/2.f;
        _dotView.hidden = YES;
        _dotView.layer.masksToBounds = YES;
    }
    return _dotView;
}
@end
