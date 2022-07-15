//
//  CodeControlsScreenRotationController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/20.
//

#import "CodeControlsScreenRotationController.h"

@interface CodeControlsScreenRotationController ()
@property (nonatomic, assign) UIInterfaceOrientationMask interfaceOrientation;
@end

@implementation CodeControlsScreenRotationController

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _interfaceOrientation = UIInterfaceOrientationMaskPortrait;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *portraitBtn = [self createBtnWithTitle:@"竖屏：UIInterfaceOrientationPortrait"
                                              action:@selector(portraitBtnAction:)
                                               frame:CGRectMake(15.f, 100.f, CGRectGetWidth(self.view.frame) - 30.f, 45)];
    
    UIButton *leftLandscapeBtn = [self createBtnWithTitle:@"横屏：UIInterfaceOrientationLandscapeLeft"
                                                   action:@selector(leftLandscapeBtnAction:)
                                                    frame:CGRectMake(15.f, CGRectGetMaxY(portraitBtn.frame) + 30, CGRectGetWidth(self.view.frame) - 30.f, 45)];
    
    UIButton *rightLandscapeBtn =  [self createBtnWithTitle:@"横屏：UIInterfaceOrientationLandscapeRight"
                                                     action:@selector(rightLandscapeBtnAction:)
                                                      frame:CGRectMake(15.f, CGRectGetMaxY(leftLandscapeBtn.frame) + 30, CGRectGetWidth(self.view.frame) - 30.f, 45)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:UIButton.class]) {
            obj.frame = CGRectMake(CGRectGetMinX(obj.frame), CGRectGetMinY(obj.frame), CGRectGetWidth(self.view.frame) - 30.f, CGRectGetHeight(obj.frame));
        }
    }];
}

#pragma mark - Action Methods

- (void)portraitBtnAction:(UIButton *)sender {
    _interfaceOrientation = UIInterfaceOrientationMaskPortrait;
    [self forceOrientation:UIInterfaceOrientationPortrait];
}

- (void)leftLandscapeBtnAction:(UIButton *)sender {
    _interfaceOrientation = UIInterfaceOrientationMaskLandscapeLeft;
    [self forceOrientation:UIInterfaceOrientationLandscapeLeft];
}

- (void)rightLandscapeBtnAction:(UIButton *)sender {
    _interfaceOrientation = UIInterfaceOrientationMaskLandscapeRight;
    [self forceOrientation:UIInterfaceOrientationLandscapeRight];
}

#pragma mark - Private Methods

- (void)forceOrientation:(UIInterfaceOrientation)orientation {
    SEL seletor = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocatino = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:seletor]];
    [invocatino setSelector:seletor];
    [invocatino setTarget:[UIDevice currentDevice]];
    NSInteger val = orientation;
    [invocatino setArgument:&val atIndex:2];
    [invocatino invoke];
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

#pragma mark - Orientations Methods

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _interfaceOrientation;
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
