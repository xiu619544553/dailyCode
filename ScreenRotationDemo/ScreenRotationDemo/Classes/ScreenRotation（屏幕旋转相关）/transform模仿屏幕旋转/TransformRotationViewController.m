//
//  TransformRotationViewController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/20.
//

#import "TransformRotationViewController.h"


#pragma mark ------------------------------------
#pragma mark - 视图

@interface TransformRotationView : UIView
@property (nonatomic, copy) void(^backBlock)(void);
@property (nonatomic, copy) void(^fullScreenBlock)(BOOL isFullScreen);
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *fullScreenBtn;
@end

@implementation TransformRotationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backBtn = ({
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.backgroundColor = UIColor.blackColor;
        [backBtn setTitle:@"返回上一页" forState:UIControlStateNormal];
        [backBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        backBtn;
    });
    
    self.fullScreenBtn = ({
        UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        screenBtn.backgroundColor = UIColor.blackColor;
        [screenBtn setTitle:@"全屏" forState:UIControlStateNormal];
        [screenBtn setTitle:@"退出全屏" forState:UIControlStateSelected];
        [screenBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [screenBtn addTarget:self action:@selector(screenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:screenBtn];
        
        screenBtn;
    });
}

- (void)backBtnAction:(UIButton *)sender {
    !_backBlock ?: _backBlock();
}

- (void)screenBtnAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.isFullScreen = sender.isSelected;
    !_fullScreenBlock ?: _fullScreenBlock(sender.selected);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backBtn.frame = CGRectMake(0.f, 0.f, 100.f, 45.f);
    self.fullScreenBtn.bounds = CGRectMake(0, 0, 150, 100);
    self.fullScreenBtn.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f);
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    self.fullScreenBtn.selected = isFullScreen;
}

@end


#pragma mark ------------------------------------


typedef NS_ENUM(NSInteger, TransformRotationViewInterfaceOrientation) {
    TransformRotationViewInterfaceOrientationUnknown = 0,
    TransformRotationViewInterfaceOrientationPortrait,
    TransformRotationViewInterfaceOrientationLandscape,
};

@interface TransformRotationViewController ()

@property (nonatomic, assign) TransformRotationViewInterfaceOrientation viewInterfaceOrientation;
@property (nonatomic, strong) TransformRotationView *rotationView;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) BOOL statusBarHidden;

@end

@implementation TransformRotationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupViews];
}

- (void)setupViews {
    
    self.rotationView = ({
        TransformRotationView *v = [[TransformRotationView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200)];
        v.backgroundColor = UIColor.cyanColor;
        [self.view addSubview:v];
        
        v;
    });
    self.originalFrame = self.rotationView.frame;
    
    __weak typeof(self) ws = self;
    
    self.rotationView.backBlock = ^{
        __strong typeof(ws) ss = ws;
        
        if (ss.viewInterfaceOrientation == TransformRotationViewInterfaceOrientationLandscape) {
            ss.rotationView.isFullScreen = NO;
            [ss rotationScreen:NO];
        } else {
            if (ss.presentingViewController) {
                [ss dismissViewControllerAnimated:YES completion:nil];
            } else {
                [ss.navigationController popViewControllerAnimated:YES];
            }
            
        }
    };
    
    self.rotationView.fullScreenBlock = ^(BOOL isFullScreen) {
        __strong typeof(ws) ss = ws;
        
        [ss rotationScreen:isFullScreen];
    };
}

- (void)rotationScreen:(BOOL)isFullScreen {
    
    self.viewInterfaceOrientation = isFullScreen ? TransformRotationViewInterfaceOrientationLandscape : TransformRotationViewInterfaceOrientationPortrait;
    
    // 控制导航栏显示与隐藏
    [self.navigationController setNavigationBarHidden:isFullScreen animated:YES];
    
    // 控制状态栏显示与隐藏
    self.statusBarHidden = isFullScreen;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self preferredStatusBarStyle];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    // 控制视图 transform 属性
    [UIView animateWithDuration:0.25f animations:^{
        if (isFullScreen) {
            [self executeLandscape];
        } else {
            [self executePortrait];
        }
    }];
}

- (void)executeLandscape {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect bounds = CGRectMake(0, 0, CGRectGetHeight(screenBounds), CGRectGetWidth(screenBounds));
    CGPoint center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    self.rotationView.bounds = bounds;
    self.rotationView.center = center;
    self.rotationView.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)executePortrait {
    self.rotationView.transform = CGAffineTransformIdentity;
    self.rotationView.frame = self.originalFrame;
}

- (CGAffineTransform)getARotation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI * 1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI_2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

#pragma StatusBar Style

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}
@end
