//
//  StatusBarViewController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/17.
//

#import "StatusBarViewController.h"

@interface StatusBarViewController ()
@property (nonatomic, assign) int num;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@end

@implementation StatusBarViewController

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _statusBarHidden = NO;
        _statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"状态栏";
    
    UIButton *hideShowStatusBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hideShowStatusBarBtn.backgroundColor = UIColor.blackColor;
    hideShowStatusBarBtn.frame = CGRectMake(15.f, 100.f, CGRectGetMaxX(self.view.frame) - 30.f, 45);
    hideShowStatusBarBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [hideShowStatusBarBtn setTitle:@"显示状态栏" forState:UIControlStateNormal];
    [hideShowStatusBarBtn setTitle:@"隐藏状态栏" forState:UIControlStateSelected];
    [hideShowStatusBarBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [hideShowStatusBarBtn addTarget:self action:@selector(hideShowStatusBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideShowStatusBarBtn];
    
    
    UIButton *statusBarStyleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    statusBarStyleBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    statusBarStyleBtn.backgroundColor = UIColor.blackColor;
    statusBarStyleBtn.frame = CGRectMake(15.f, CGRectGetMaxY(hideShowStatusBarBtn.frame) + 30.f, CGRectGetWidth(hideShowStatusBarBtn.frame), 45);
    [statusBarStyleBtn setTitle:@"状态栏样式" forState:UIControlStateNormal];
    [statusBarStyleBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [statusBarStyleBtn addTarget:self action:@selector(statusBarStyleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:statusBarStyleBtn];
}

#pragma mark - Action Methods

- (void)hideShowStatusBarBtnAction:(UIButton *)sender {
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        _statusBarHidden = !_statusBarHidden;
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    [sender setSelected:_statusBarHidden];
}

- (void)statusBarStyleBtnAction:(UIButton *)sender {
    _num ++;
    
    NSString *text;
    if (_num % 2 == 1) {
        text = @"UIStatusBarStyleLightContent";
        _statusBarStyle = UIStatusBarStyleLightContent; // 设置导航栏样式
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor]; // 设置导航栏背景颜色
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}]; // 设置导航栏标题
    } else {
        text = @"UIStatusBarStyleDefault";
        _statusBarStyle = UIStatusBarStyleDefault;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
    
    [sender setTitle:[NSString stringWithFormat:@"状态栏样式：%@", text] forState:UIControlStateNormal];
    
    // 更新导航栏样式
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self preferredStatusBarStyle];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

#pragma mark - Orientations Methods

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - StatusBarStyle

/// info.plist文件中：
/// View controller-based status bar appearance 项设为 YES，则 View controller 对status bar的设置优先级高于application的设置。即调用该方法获取状态栏状态。
/// View controller-based status bar appearance 项设为 NO，则以 application 的设置为准，view controller 的 prefersStatusBarHidden 方法无效，根本不会被调用的。
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

// 2、覆盖view controller的prefersStatusBarHidden的实现，返会YES。
- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}
@end
