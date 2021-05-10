//
//  TKGestureRecognizerViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/29.
//  Copyright © 2021 TK. All rights reserved.
//  translation n. 翻译；译文；转化；调任
 

// OneGesture 优先级低于 TwoGesture优先级
// TwoGesture 识别失败时，才开始识别 OneGesture
// [OneGesture requireGestureRecognizerToFail:TwoGesture;


// @protocol UIGestureRecognizerDelegate <NSObject>
// @optional
// /**
//  是否允许识别该手势
//  当手势识别器识别到手势,准备从UIGestureRecognizerStatePossible状态开始转换时.调用此代理,如果返回YES,那么就继续识别
//  如果返回NO,那么手势识别器将会将状态置为UIGestureRecognizerStateFailed.
//  */
// - (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
//
// /**
//  当其中一个手势识别器或另一个手势识别器的识别被对方阻止时调用
//  返回YES以允许两者同时识别。默认实现返回NO(默认情况下不能同时识别两种手势)
//  注意:返回YES保证允许同时识别。不能保证返回NO来防止同时识别，因为其他手势的委派可能会返回YES
//  */
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
//
// /**
//  一般用来重写该方法.来定义什么时候手势识别失败.
//  如果直接返回YES,那么gestureRecognizer与otherGestureRecognizer互斥的话gestureRecognizer识别失败.
//  可以用tap手势和longPress手势试试.
//  */
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
// /**
//  基本同上,注意这个Be,所以是相反的,如果互斥,otherGestureRecognizer识别失败.
//  */
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
//
// /**
//  返回手势识别器是否允许检查手势对象.
//  UIKit将会在touchesBegan:withEvent:方法之前调用这个代理.
//  */
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
//
// /**
//  返回手势识别器是否允许检查按压(UIPress对象).
//  UIKit将会在touchesBegan:withEvent:方法之前调用这个代理.
//  */
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press;
//
// @end


#import "TKGestureRecognizerViewController.h"

@interface TKGestureRecognizerViewController ()

@property (nonatomic, strong) UIView *panView;

@end

@implementation TKGestureRecognizerViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手势处理";
    [self.view addSubview:self.panView];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.panView addGestureRecognizer:panGR];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    // 1. 获取拖拽手势在 self.view 坐标系平移的距离
    CGPoint point1 = [pan translationInView:self.view];
//    NSLog(@"拖拽手势在 self.view 坐标系中平移的距离: %@", NSStringFromCGPoint(point1));
    
    // 2.0 更新 self.panView 的x、y坐标
    self.panView.left += point1.x;
    self.panView.top += point1.y;
    
    // 2.1 针对 panView 添加限制条件。比如 panView.x 不可以小于0
    self.panView.left = (self.panView.left < 0.f) ? 0.f : self.panView.left;
    
    // 3. 清空拖拽手势平移距离
    [pan setTranslation:CGPointZero inView:self.view];
    
    // 验证：清空后，拖拽手势平移距离为 {0, 0}
    CGPoint point2 = [pan translationInView:self.view];
    NSLog(@"清空拖拽手势平移距离: %@", NSStringFromCGPoint(point2));
    
    
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
            self.panView.left = 0.f;
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
        _panView.layer.cornerRadius = _panView.width/2.f;
        _panView.layer.masksToBounds = YES;
    }
    return _panView;
}
@end


