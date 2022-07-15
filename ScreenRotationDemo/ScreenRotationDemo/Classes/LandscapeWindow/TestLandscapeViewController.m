//
//  TestLandscapeViewController.m
//  ScreenRotationDemo
//
//  Created by hello on 2022/7/4.
//

#import "TestLandscapeViewController.h"
#import "TKOrientationObserver.h"

@interface TestLandscapeViewController ()

@property (nonatomic, assign) UIView *bgView;
@property (nonatomic, assign) UIView *greenView;
@property (nonatomic, strong) TKOrientationObserver *observer;

@end

@implementation TestLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 16.f * 9.f)];
    bgView.backgroundColor = UIColor.redColor;
    [self.view addSubview:bgView];
    
    UIView *greenView = [[UIView alloc] initWithFrame:bgView.bounds];
    greenView.backgroundColor = UIColor.greenColor;
    [bgView addSubview:greenView];
    
    UIButton *fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fullScreenBtn.frame = CGRectMake(15, 20, 100, 35);
    [fullScreenBtn setTitle:@"全屏" forState:UIControlStateNormal];
    [fullScreenBtn setTitle:@"退出全屏" forState:UIControlStateSelected];
    fullScreenBtn.backgroundColor = UIColor.blackColor;
    [fullScreenBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [fullScreenBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [fullScreenBtn addTarget:self action:@selector(fullScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:fullScreenBtn];
    
    _bgView = bgView;
    _greenView = greenView;
    
    
    UIButton *rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rotateBtn.frame = CGRectMake(100, 100, 200, 45.f);
    rotateBtn.backgroundColor = UIColor.blackColor;
    [rotateBtn setTitle:@"竖屏" forState:UIControlStateNormal];
    [rotateBtn setTitle:@"横屏" forState:UIControlStateSelected];
    [rotateBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [rotateBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
//    [rotateBtn addTarget:self action:@selector(rotateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotateBtn];
}

#pragma mark - Action Methods

- (void)fullScreenBtnAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    [self.observer updateRotateView:_greenView containerView:_bgView];
    
    UIInterfaceOrientation orientation = sender.isSelected ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
    [self.observer rotateToOrientation:orientation animated:YES completion:^{
        
    }];
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (TKOrientationObserver *)observer {
    if (!_observer) {
        _observer = [[TKOrientationObserver alloc] init];
    }
    return _observer;
}

@end
