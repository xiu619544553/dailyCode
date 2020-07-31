//
//  DetailViewController.m
//  test
//
//  Created by hello on 2020/6/2.
//  Copyright © 2020 TK. All rights reserved.
//

#import "DetailViewController.h"
#import "PresentViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.yellowColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     [A presentViewController:B animated:YES completion:nil];
     那么：A.presentedViewController = B;
     */
    
//    NSLog(@"===============================================================");
//    NSLog(@"presentingViewController : %@", self.presentingViewController);
//    NSLog(@"presentedViewController  : %@", self.presentedViewController);
//    NSLog(@"presentationController   : %@", self.presentationController);
//    NSLog(@"===============================================================");
    
    PresentViewController *pvc = [PresentViewController new];
    [self presentViewController:pvc animated:YES completion:nil];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"===============================================================");
//        NSLog(@"presentingViewController : %@", self.presentingViewController);
//        NSLog(@"presentedViewController  : %@", self.presentedViewController);
//        NSLog(@"presentationController   : %@", self.presentationController);
//        NSLog(@"===============================================================");
//    });
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
