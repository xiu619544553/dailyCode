//
//  TKLandscapeViewController.h
//  ScreenRotationDemo
//
//  Created by hello on 2022/7/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TKLandscapeViewControllerDelegate <NSObject>

- (BOOL)ls_shouldAutorotate;
- (void)ls_willRotateToOrientation:(UIInterfaceOrientation)orientation;
- (void)ls_didRotateFromOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)ls_targetRect;

@end

@interface TKLandscapeViewController : UIViewController

@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, assign) CGRect targetRect;

@property (nonatomic, weak, nullable) id<TKLandscapeViewControllerDelegate> delegate;

@property (nonatomic, readonly) BOOL isFullscreen;

@property (nonatomic, getter=isRotating) BOOL rotating;

@property (nonatomic, assign) BOOL disableAnimations;

@property (nonatomic, assign) BOOL statusBarHidden;
/// default is  UIStatusBarStyleLightContent.
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
/// defalut is UIStatusBarAnimationSlide.
@property (nonatomic, assign) UIStatusBarAnimation statusBarAnimation;

@property (nonatomic, copy) void(^rotatingCompleted)(void);

@end

NS_ASSUME_NONNULL_END
