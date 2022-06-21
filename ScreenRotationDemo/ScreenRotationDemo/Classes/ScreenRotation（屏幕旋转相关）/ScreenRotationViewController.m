//
//  ScreenRotationViewController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/17.
//

#import "ScreenRotationViewController.h"
#import "TKNavigationController.h"
#import "GravityScreenRotationViewController.h"
#import "PresentLandscapeViewController.h"
#import "CodeControlsScreenRotationController.h"
#import "TransformRotationViewController.h"

@interface ScreenRotationViewController ()

@end

@implementation ScreenRotationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"屏幕旋转";
    
    UIButton *presentBtn = [self createBtnWithTitle:@"模态出横屏视图（含导航栏）"
                                             action:@selector(presentBtnAction:)
                                              frame:CGRectMake(15.f, 100, CGRectGetWidth(self.view.frame) - 30.f, 45)];
    
    UIButton *noNavPresentBtn = [self createBtnWithTitle:@"模态出横屏视图（不含导航栏）"
                                                  action:@selector(noNavPresentBtnAction:)
                                                   frame:CGRectMake(15.f, CGRectGetMaxY(presentBtn.frame) + 30.f, CGRectGetWidth(self.view.frame) - 30.f, 45)];
    
    UIButton *codeControlBtn = [self createBtnWithTitle:@"通过代码控制横竖屏旋转"
                                                 action:@selector(codeControlBtnAction:)
                                                  frame:CGRectMake(15.f, CGRectGetMaxY(noNavPresentBtn.frame) + 30.f, CGRectGetWidth(self.view.frame) - 30.f, 45)];
    
    UIButton *gravityBtn = [self createBtnWithTitle:@"屏幕自适应重力感应进行旋转"
                                                 action:@selector(gravityBtnAction:)
                                                  frame:CGRectMake(15.f, CGRectGetMaxY(codeControlBtn.frame) + 30.f, CGRectGetWidth(self.view.frame) - 30.f, 45)];
    
    UIButton *transformBtn = [self createBtnWithTitle:@"通过 transform 的属性控制视图旋转"
                                               action:@selector(transformBtnAction:)
                                                frame:CGRectMake(15.f, CGRectGetMaxY(gravityBtn.frame) + 30.f, CGRectGetWidth(self.view.frame) - 30.f, 45)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:UIButton.class]) {
            obj.frame = CGRectMake(CGRectGetMinX(obj.frame), CGRectGetMinY(obj.frame), CGRectGetWidth(self.view.frame) - 30.f, CGRectGetHeight(obj.frame));
        }
    }];
}

- (UIButton *)createBtnWithTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    customBtn.backgroundColor = UIColor.blackColor;
    customBtn.frame = frame;
    [customBtn setTitle:title forState:UIControlStateNormal];
    [customBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [customBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customBtn];
    return customBtn;
}

#pragma mark - Action Methods

- (void)presentBtnAction:(UIButton *)sender {
    NSLog(@"...模态...");
    TKNavigationController *presentNav = [[TKNavigationController alloc] initWithRootViewController:[PresentLandscapeViewController new]];
    presentNav.modalPresentationStyle = UIModalPresentationFullScreen; // 如果想要模态出横屏视图，必须通过全屏方式展现
    [self.navigationController presentViewController:presentNav animated:YES completion:nil];
}

- (void)noNavPresentBtnAction:(UIButton *)sender {
    NSLog(@"...模态...");
    PresentLandscapeViewController *presentVc = [PresentLandscapeViewController new];
    presentVc.modalPresentationStyle = UIModalPresentationFullScreen; // 如果想要模态出横屏视图，必须通过全屏方式展现
    [self.navigationController presentViewController:presentVc animated:YES completion:nil];
}

- (void)codeControlBtnAction:(UIButton *)sender {
    NSLog(@"...代码控制屏幕旋转...");
    CodeControlsScreenRotationController *codeControlVc = [CodeControlsScreenRotationController new];
    [self.navigationController pushViewController:codeControlVc animated:YES];
}

- (void)gravityBtnAction:(UIButton *)sender {
    NSLog(@"...重力感应...");
    GravityScreenRotationViewController *orientationVc = [GravityScreenRotationViewController new];
    [self.navigationController pushViewController:orientationVc animated:YES];
}

- (void)transformBtnAction:(UIButton *)sender {
    NSLog(@"...transform...");
    TransformRotationViewController *transformVc = [TransformRotationViewController new];
    [self.navigationController pushViewController:transformVc animated:YES];
}

#pragma mark - Orientations Methods

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
