//
//  Weak_ViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/13.
//

#import "Weak_ViewController.h"

@interface Weak_ViewController ()

@end

@implementation Weak_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // The nil case
    // __weak id weakPtr;
    
    // The non-nil case
    NSObject *o = [NSObject new];
    __weak id weakPtr = o;
    NSLog(@"o__%@_%p", o, o);
    NSLog(@"weakPtr__%@_%p", weakPtr, weakPtr);
}


@end
