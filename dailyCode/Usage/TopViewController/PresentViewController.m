//
//  PresentViewController.m
//  test
//
//  Created by hello on 2020/6/2.
//  Copyright © 2020 TK. All rights reserved.
//

#import "PresentViewController.h"
#import "UIWindow+TKAdd.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.purpleColor;
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    dismissBtn.backgroundColor = UIColor.whiteColor;
    dismissBtn.frame = CGRectMake(100, 100, 100, 100);
    [dismissBtn addTarget:self action:@selector(dismissBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
}

- (void)dismissBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    BOOL shouldAutorotate = [self shouldAutorotate];
    UIInterfaceOrientationMask supportedInterfaceOrientations = [self supportedInterfaceOrientations];
    UIInterfaceOrientation preferredInterfaceOrientationForPresentation = [self preferredInterfaceOrientationForPresentation];
    
    DLog(@"\nshouldAutorotate : %@  \nsupportedInterfaceOrientations : %ld   \npreferredInterfaceOrientationForPresentation : %ld", shouldAutorotate ? @"是" : @"否", supportedInterfaceOrientations, preferredInterfaceOrientationForPresentation);
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"===============================================================");
//    NSLog(@"presentingViewController : %@", self.presentingViewController);
//    NSLog(@"presentedViewController  : %@", self.presentedViewController);
//    NSLog(@"presentationController   : %@", self.presentationController);
//    NSLog(@"===============================================================");
//
//    NSLog(@"topViewController : %@", [UIWindow topViewController]);
//}


@end
