//
//  TKBaseViewController.m
//  test
//
//  Created by hello on 2020/7/8.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKBaseViewController.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import <RTRootNavigationController/UIViewController+RTRootNavigationController.h>

@interface TKBaseViewController () <RTNavigationItemCustomizable>

@end

@implementation TKBaseViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
//    if ([self isKindOfClass:NSClassFromString(@"TKBasicKnowledgeListViewController")]) {
//        if (self.navigationItem && self.navigationItem.leftBarButtonItem) {
//
//            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithColor:UIColor.whiteColor] style:UIBarButtonItemStylePlain target:self action:@selector(__log)];
//        }
//    }
}

- (void)__log {
    NSLog(@"...你好...");
}

#pragma mark - RTNavigationItemCustomizable

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIImage *backImg = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return [[UIBarButtonItem alloc] initWithImage:backImg
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(_leftItemAction:)];
}

#pragma mark - Event Methods

- (void)_leftItemAction:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationPortraitUpsideDown | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}
@end
