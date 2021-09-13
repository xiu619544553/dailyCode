//
//  AppDelegate.h
//  RuntimeDemo
//
//  Created by hello on 2021/6/17.
//

#import <UIKit/UIKit.h>

/// 记录某些页面出现的次数。通过 method swizzing 实现。
static NSMutableDictionary<NSString *, NSNumber *> *ViewControllerCountDict;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@end

