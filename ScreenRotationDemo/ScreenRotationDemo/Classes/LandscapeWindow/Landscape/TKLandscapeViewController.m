//
//  TKLandscapeViewController.m
//  ScreenRotationDemo
//
//  Created by hello on 2022/7/4.
//

#import "TKLandscapeViewController.h"

@interface TKLandscapeViewController ()

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;

@end

@implementation TKLandscapeViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentOrientation = UIInterfaceOrientationPortrait;
        _statusBarStyle = UIStatusBarStyleLightContent;
        _statusBarAnimation = UIStatusBarAnimationSlide;
    }
    return self;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    self.rotating = YES;
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (!UIDeviceOrientationIsValidInterfaceOrientation([UIDevice currentDevice].orientation)) {
        return;
    }
    UIInterfaceOrientation newOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    UIInterfaceOrientation oldOrientation = _currentOrientation;
    if (UIInterfaceOrientationIsLandscape(newOrientation)) {
        if (self.contentView.superview != self.view) {
            [self.view addSubview:self.contentView];
        }
    }
    
    if (oldOrientation == UIInterfaceOrientationPortrait) {
        self.contentView.frame = [self.delegate ls_targetRect];
        [self.contentView layoutIfNeeded];
    }
    self.currentOrientation = newOrientation;
    
    [self.delegate ls_willRotateToOrientation:self.currentOrientation];
    
    BOOL isFullscreen = size.width > size.height;
    
    [CATransaction begin];
    [CATransaction setDisableActions:self.disableAnimations];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        if (isFullscreen) {
            self.contentView.frame = CGRectMake(0, 0, size.width, size.height);
        } else {
            self.contentView.frame = [self.delegate ls_targetRect];
        }
        [self.contentView layoutIfNeeded];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [CATransaction commit];
        [self.delegate ls_didRotateFromOrientation:self.currentOrientation];
        if (!isFullscreen) {
            self.contentView.frame = self.containerView.bounds;
            [self.contentView layoutIfNeeded];
        }
        self.disableAnimations = NO;
        
        self.rotating = NO;
    }];
}

- (BOOL)isFullscreen {
    return UIInterfaceOrientationIsLandscape(_currentOrientation);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
    return [self.delegate ls_shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        return YES;
    }
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.statusBarAnimation;
}

- (void)setRotating:(BOOL)rotating {
    _rotating = rotating;
    if (!rotating && self.rotatingCompleted) {
        self.rotatingCompleted();
    }
}

@end
