//
//  TKNavigationController.m
//  test
//
//  Created by hello on 2020/5/28.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKNavigationController.h"
#import "AboutScrollViewLayoutViewController.h"

@interface TKNavigationController ()
@property (nonatomic, strong) NSArray<Class> *filterViewControllers;
@end

@implementation TKNavigationController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Override Methods

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self.filterViewControllers containsObject:viewController.class]) {
        viewController.hidesBottomBarWhenPushed = NO;
    } else {
        viewController.hidesBottomBarWhenPushed = (self.viewControllers.count > 0);
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Orientation

// MARK: UINavigationController

//- (BOOL)shouldAutorotate {
//    return [self.topViewController shouldAutorotate];
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return [self.topViewController supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return [self.topViewController preferredInterfaceOrientationForPresentation];
//}


// MARK: RTRootNavigationController
- (BOOL)shouldAutorotate {
    return [self.rt_topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.rt_topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.rt_topViewController preferredInterfaceOrientationForPresentation];
}

#pragma mark - getter

- (NSArray<Class> *)filterViewControllers {
    if (!_filterViewControllers) {
        _filterViewControllers = @[AboutScrollViewLayoutViewController.class];
    }
    return _filterViewControllers;
}
@end
