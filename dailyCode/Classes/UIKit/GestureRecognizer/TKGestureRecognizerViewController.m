//
//  TKGestureRecognizerViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/29.
//  Copyright © 2021 TK. All rights reserved.
//  translation n. 翻译；译文；转化；调任

#import "TKGestureRecognizerViewController.h"

@interface TKGestureRecognizerViewController ()

@property (nonatomic, strong) UIView *panView;

@end

@implementation TKGestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手势处理";
    [self.view addSubview:self.panView];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.panView addGestureRecognizer:panGR];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    // 获取手指在 self.view 坐标系内移动的距离
    CGPoint point1 = [pan translationInView:self.view];
//    NSLog(@"前，point1: %@", NSStringFromCGPoint(point1));
    
    // 更新 self.panView 的x、y坐标
    self.panView.left += point1.x;
    self.panView.top += point1.y;
    
    // 清空偏移量
    [pan setTranslation:CGPointZero inView:self.view];
    CGPoint point2 = [pan translationInView:self.view];
//    NSLog(@"后，point2: %@", NSStringFromCGPoint(point2));
    
    
    switch (pan.state) {
        case UIGestureRecognizerStatePossible:
            // 识别器尚未识别其手势，但可能正在评估触摸事件。这是默认状态
            NSLog(@"Possible");
            break;
            
            
        case UIGestureRecognizerStateBegan:
            // 识别器接收到被识别为手势的触摸。动作方法将在运行循环的下一个回合被调用
            NSLog(@"Began");
            break;
            
            
        case UIGestureRecognizerStateChanged:
            // 识别器接收到被识别为手势更改的触摸。动作方法将在运行循环的下一个回合被调用
            NSLog(@"Changed");
            break;
            
            
        case UIGestureRecognizerStateEnded:
            // 识别器接收到被识别为手势结束的触摸。动作方法将在运行循环的下一个回合被调用，识别器将重置为UIGestureRecognizerStatePossible
            NSLog(@"Ended");
            break;
            
        case UIGestureRecognizerStateCancelled:
            // 识别器接收到导致手势取消的触摸。动作方法将在运行循环的下一个回合被调用。识别器将被重置为UIGestureRecognizerStatePossible
            NSLog(@"Cancelled");
            break;
            
            
        case UIGestureRecognizerStateFailed:
            // 识别器接收到一个不能被识别为手势的触摸序列。动作方法将不会被调用，识别器将重置为UIGestureRecognizerStatePossible
            NSLog(@"Failed");
            break;
            
        default:
            break;
    }
}

#pragma mark - getter

- (UIView *)panView {
    if (!_panView) {
        _panView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 100.f, 50.f, 50.f)];
        _panView.backgroundColor = UIColor.redColor;
    }
    return _panView;
}
@end


