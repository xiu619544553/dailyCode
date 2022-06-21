//
//  AppDelegate.h
//  iOSTestDemo
//
//  Created by hello on 2022/6/16.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

/// 根据业务需求，来控制窗口的旋转
@property (nonatomic, assign) BOOL controlInterfaceOrientation;

@end

