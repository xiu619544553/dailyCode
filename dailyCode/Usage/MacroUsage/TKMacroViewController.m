//
//  TKMacroViewController.m
//  test
//
//  Created by hello on 2020/7/8.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKMacroViewController.h"

@interface TKMacroViewController () <UIAlertViewDelegate>

@end

@implementation TKMacroViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark - Event Methods

- (IBAction)clickAction:(UIButton *)sender {
    
    NSString *selectorStr = @"inputSomethings";
    
    // PerformSelector may cause a leak because its selector is unknown
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(selectorStr)];
#pragma clang diagnostic pop
}

- (void)inputSomethings {
    NSLog(@"%s", __FUNCTION__);
    
    
    // 关闭废弃 api的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"我是title" message:@"我是message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", @"I know", nil];
    [alert show];
#pragma clang diagnostic pop
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"butotnIndex : %ld", buttonIndex);
}
#pragma clang diagnostic pop
@end
