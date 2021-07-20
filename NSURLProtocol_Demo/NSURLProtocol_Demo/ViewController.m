//
//  ViewController.m
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
//

#import "ViewController.h"
#import "AFN_Test.h"
#import "Session_Test.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // title
    self.title = @"NSURLProtocol";
    
    // AFNetworking
    UIButton *afnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:afnBtn];
    [afnBtn setTitle:@"AFNetworking" forState:UIControlStateNormal];
    afnBtn.frame = CGRectMake(15, 100, self.view.bounds.size.width - 30, 44);
    afnBtn.backgroundColor = UIColor.orangeColor;
    [afnBtn addTarget:self
               action:@selector(afnBtnAction:)
     forControlEvents:UIControlEventTouchUpInside];
    
    // NSURLSession
    UIButton *sessionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:sessionBtn];
    [sessionBtn setTitle:@"NSURLSession" forState:UIControlStateNormal];
    sessionBtn.frame = CGRectMake(15, CGRectGetMaxY(afnBtn.frame) + 20, self.view.bounds.size.width - 30, 44);
    sessionBtn.backgroundColor = UIColor.orangeColor;
    [sessionBtn addTarget:self
                  action:@selector(sessionBtnAction:)
        forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Action Methods

- (void)afnBtnAction:(UIButton *)sender {
    [AFN_Test request];
}

- (void)sessionBtnAction:(UIButton *)sender {
    [Session_Test request];
}

@end
