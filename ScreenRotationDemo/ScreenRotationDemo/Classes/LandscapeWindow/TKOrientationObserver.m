//
//  TKOrientationObserver.m
//  ScreenRotationDemo
//
//  Created by hello on 2022/7/4.
//

#import "TKOrientationObserver.h"
#import "TKLandscapeWindow.h"
#import "TKLandscapeViewController.h"

@interface TKOrientationObserver ()<TKLandscapeViewControllerDelegate>

@property (nonatomic, assign) BOOL fullScreen;
@property (nonatomic, assign) BOOL forceRotaion;
@property (nonatomic, strong) TKLandscapeWindow *window;

@property (nonatomic, weak) UIView *rotateView;
@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;

@end

@implementation TKOrientationObserver

- (instancetype)init {
    self = [super init];
    if (self) {
        _fullScreen = NO;
    }
    return self;
}

- (void)updateRotateView:(UIView *)rotateView containerView:(UIView *)containerView {
    self.rotateView = rotateView;
    self.containerView = containerView;
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    [self rotateToOrientation:orientation animated:animated completion:nil];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion {
    
    _currentOrientation = orientation;
    self.forceRotaion = YES;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        
        if (!self.fullScreen) {
            
            UIView *containerView = self.containerView;
            
            CGRect targetRect = [self.rotateView convertRect:self.rotateView.frame toView:containerView.window];
            
            if (!self.window) {
                self.window = [TKLandscapeWindow new];
                self.window.landscapeViewController.delegate = self;
                if (@available(iOS 9.0, *)) {
                    [self.window.rootViewController loadViewIfNeeded];
                } else {
                    [self.window.rootViewController view];
                }
            }
            // contentView.superView = containerView
            self.window.landscapeViewController.statusBarHidden = NO;
            self.window.landscapeViewController.statusBarStyle = UIStatusBarStyleDefault;
            self.window.landscapeViewController.targetRect = targetRect;
            self.window.landscapeViewController.contentView = self.rotateView;
            self.window.landscapeViewController.containerView = self.containerView;
            self.fullScreen = YES;
        }
        if (self.orientationWillChange) self.orientationWillChange(self, self.fullScreen);
    } else {
        self.fullScreen = NO;
    }
    
    self.window.landscapeViewController.disableAnimations = !animated;
    
    __weak typeof(self) ws = self;
    self.window.landscapeViewController.rotatingCompleted = ^{
        __strong typeof(self) ss = ws;
        ss.forceRotaion = NO;
        if (completion) completion();
    };
    
    [self interfaceOrientation:UIInterfaceOrientationUnknown];
    [self interfaceOrientation:orientation];
}

#pragma mark - TKLandscapeViewControllerDelegate

- (BOOL)ls_shouldAutorotate {
    
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    
    
    if (self.forceRotaion) {
        [self _rotationToLandscapeOrientation:currentOrientation];
        return YES;
    }
    
    return NO;
}

- (void)ls_willRotateToOrientation:(UIInterfaceOrientation)orientation {
    self.fullScreen = UIInterfaceOrientationIsLandscape(orientation);
}

- (void)ls_didRotateFromOrientation:(UIInterfaceOrientation)orientation {
    if (self.orientationDidChanged) self.orientationDidChanged(self, self.fullScreen);
    if (!self.fullScreen) {
        [self _rotationToPortraitOrientation:UIInterfaceOrientationPortrait];
    }
}

- (CGRect)ls_targetRect {
    UIView *containerView = self.containerView;
    CGRect targetRect = [containerView convertRect:containerView.bounds toView:containerView.window];
    return targetRect;
}

- (void)_rotationToLandscapeOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        if (!self.window.isKeyWindow) {
            self.window.hidden = NO;
            [self.window makeKeyAndVisible];
        }
    }
}

- (void)_rotationToPortraitOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait && !self.window.hidden) {
        
        [self.containerView addSubview:self.rotateView];
        self.rotateView.frame = self.containerView.bounds;
        [self.rotateView layoutIfNeeded];
    
        UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
        [keyWindow makeKeyAndVisible];
        self.window.hidden = YES;
        self.window = nil;
    }
}

#pragma mark - Private Methods

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        UIInterfaceOrientation val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
@end
