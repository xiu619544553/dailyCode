//
//  PresentLandscapeViewController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/20.
//

#import "PresentLandscapeViewController.h"

@interface PresentLandscapeViewController ()
@property (nonatomic, strong) UIButton *dismissBtn;
@end

@implementation PresentLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.navigationController) {
        self.navigationItem.title = @"横屏";
    }
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    dismissBtn.backgroundColor = UIColor.blackColor;
    dismissBtn.frame = CGRectMake(15.f, 100, CGRectGetWidth(self.view.frame) - 30.f, 45);
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    _dismissBtn = dismissBtn;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _dismissBtn.frame = CGRectMake(15.f, 100, CGRectGetWidth(self.view.frame) - 30.f, 45);
}

#pragma mark - Action Methods

- (void)dismissBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Orientations Methods

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

// 当然，使用这个方法是有前提的，就是当前ViewController是通过全屏的Presentation（模态视图）方式展现出来的。
// 模态控制器偏好的页面方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

#pragma StatusBar Style

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

@end
