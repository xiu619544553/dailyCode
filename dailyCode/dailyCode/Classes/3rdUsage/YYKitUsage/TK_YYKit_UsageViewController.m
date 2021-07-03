//
//  TK_YYKit_UsageViewController.m
//  dailyCode
//
//  Created by hello on 2020/12/17.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_YYKit_UsageViewController.h"

@interface TK_YYKit_UsageViewController ()

@end

@implementation TK_YYKit_UsageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YYKit";
    
    NSArray *tempArray = @[@"A", @"C", @"P", @"L"];
    NSString *jsonStr = [tempArray jsonStringEncoded];
    NSString *jsonPrettyStr = [tempArray jsonPrettyStringEncoded];
    
    NSLog(@"jsonStr = \n%@", jsonStr);
    NSLog(@"jsonPrettyStr = \n%@", jsonPrettyStr);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"\n%@\n%@", self, self.presentationController);
    
    
    if (self.presentedViewController) return;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TK_YYKit_UsageViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
