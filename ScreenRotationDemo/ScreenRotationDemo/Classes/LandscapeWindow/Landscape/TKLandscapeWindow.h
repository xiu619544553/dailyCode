//
//  TKLandscapeWindow.h
//  ScreenRotationDemo
//
//  Created by hello on 2022/7/4.
//

#import <UIKit/UIKit.h>

@class TKLandscapeViewController;

NS_ASSUME_NONNULL_BEGIN

@interface TKLandscapeWindow : UIWindow

@property (nonatomic, strong, readonly) TKLandscapeViewController *landscapeViewController;

@end

NS_ASSUME_NONNULL_END
