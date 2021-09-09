//
//  Method_SendMsg_ViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/8.
//

#import "Method_SendMsg_ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "TestForwardFlow.h"

@interface Method_SendMsg_ViewController ()

@end

@implementation Method_SendMsg_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    /*
     1、不同的类，函数名相同，都有参数或都没参数，则 SEL相同；
     2、不同的类，函数名相同，一个有参数、一个没有参数，那么 SEL不同；
     
     */
    SEL sel = @selector(test);
    NSLog(@"sel : %p", sel);
}

- (void)test {
    NSLog(@"这是个测试");
}

- (void)method1 {
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [TestForwardFlow new];
}

@end
