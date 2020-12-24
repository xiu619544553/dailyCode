//
//  UIWindow+TKAdd.m
//  test
//
//  Created by hello on 2020/6/2.
//  Copyright © 2020 TK. All rights reserved.
//

#import "UIWindow+TKAdd.h"

#import <RTRootNavigationController/RTRootNavigationController.h>

@implementation UIWindow (TKAdd)

//+ (UIViewController *)topViewController {
//    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
//    while (YES) {
//        if ([topVc isKindOfClass:UITabBarController.class]) {
//            topVc = ((UITabBarController *)topVc).selectedViewController;
//        }
//
//        /*
//         如果使用了其他导航栏，此处需要修改
//         比如：导航栏使用的是 RTRootNavigationController
//         if ([vc isKindOfClass:[RTRootNavigationController class]]) {
//             vc = ((RTRootNavigationController*)vc).rt_visibleViewController;
//         }
//         */
//        if ([topVc isKindOfClass:UINavigationController.class]) {
//            topVc = ((UINavigationController *)topVc).visibleViewController;
//        }
//
//        // [A presentViewController:B animated:YES completion:nil]; ===> A.presentedViewController = B;
//        // topVc.presentedViewController : topVc模态出的控制器。
//        if (topVc.presentedViewController) {
//            topVc = topVc.presentedViewController;
//        } else {
//            break;
//        }
//    }
//    return topVc;
//}


+ (UIViewController *)topViewController {
    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (YES) {
        if ([topVc isKindOfClass:UITabBarController.class]) {
            topVc = ((UITabBarController *)topVc).selectedViewController;
        }
        
        if ([topVc isKindOfClass:UINavigationController.class]) {
            topVc = ((UINavigationController *)topVc).visibleViewController;
        }
        
        if (topVc.presentedViewController) {
            topVc = topVc.presentedViewController;
        } else {
            break;
        }
    }
    
    return topVc;
}
@end
