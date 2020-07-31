//
//  GradientLayerViewController.m
//  test
//
//  Created by hello on 2020/6/15.
//  Copyright © 2020 TK. All rights reserved.
//

#import "GradientLayerViewController.h"
#import "TreeTableViewController.h"

@interface GradientLayerViewController ()
// 100x30
@property (weak, nonatomic) IBOutlet UILabel *testLayer;
@end

@implementation GradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    // Do any additional setup after loading the view from its nib.
    
    
    //Gradient 0 fill for 矩形 1595
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 2;
    gradientLayer0.frame = _testLayer.bounds;
    gradientLayer0.colors = @[
        (id)[UIColor colorWithRed:217.0f/255.0f green:196.0f/255.0f blue:152.0f/255.0f alpha:1.0f].CGColor,
        (id)[UIColor colorWithRed:230.0f/255.0f green:215.0f/255.0f blue:195.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 1)];
    [_testLayer.layer addSublayer:gradientLayer0];
    
    
    TreeTableViewController *treeVc = [[TreeTableViewController alloc] init];
    
    treeVc.view.frame = CGRectMake(100.f, 300.f, 200.f, 200.f);
    [self.view addSubview:treeVc.view];
    [self addChildViewController:treeVc];
}

#pragma mark - Orientations

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
