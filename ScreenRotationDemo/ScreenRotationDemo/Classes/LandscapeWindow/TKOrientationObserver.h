//
//  TKOrientationObserver.h
//  ScreenRotationDemo
//
//  Created by hello on 2022/7/4.
//

#import <UIKit/UIKit.h>

@class TKOrientationObserver;

NS_ASSUME_NONNULL_BEGIN

@interface TKOrientationObserver : NSObject


/// 设置需要旋转的视图和它的父视图
/// @param rotateView 需要旋转的视图（播放器）
/// @param containerView 播放器视图的父视图
- (void)updateRotateView:(UIView *)rotateView containerView:(UIView *)containerView;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

@property (nonatomic, readonly) BOOL fullScreen;
@property (nonatomic, copy, nullable) void(^orientationWillChange)(TKOrientationObserver *observer, BOOL isFullScreen);
@property (nonatomic, copy, nullable) void(^orientationDidChanged)(TKOrientationObserver *observer, BOOL isFullScreen);

@end

NS_ASSUME_NONNULL_END
