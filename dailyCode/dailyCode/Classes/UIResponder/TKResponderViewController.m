//
//  TKResponderViewController.m
//  dailyCode
//
//  Created by hello on 2021/7/26.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKResponderViewController.h"

@interface TKResponderViewController ()

@end

@implementation TKResponderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     
     @property(nonatomic, readonly, nullable) UIResponder *nextResponder;
     
     示意：
     The UIResponder class does not store or set the next responder automatically, so this method returns nil by default. Subclasses must override this method and return an appropriate next responder. For example, UIView implements this method and returns the UIViewController object that manages it (if it has one) or its superview (if it doesn’t). UIViewController similarly implements the method and returns its view’s superview. UIWindow returns the application object. The shared UIApplication object normally returns nil, but it returns its app delegate if that object is a subclass of UIResponder and has not already been called to handle the event.
     
     译文：
     UIResponder类不会自动存储或设置下一个responder，所以这个方法默认返回nil。子类必须重写此方法并返回适当的下一个响应器。例如，UIView实现了这个方法并返回管理它的UIViewController对象(如果它有一个)或它的父视图(如果它没有)。UIViewController同样实现了这个方法并返回其视图的父视图。UIWindow返回应用程序对象。共享的UIApplication对象通常返回nil，但是如果这个对象是UIResponder的子类并且还没有被调用来处理事件，它就返回它的应用委托。
     
     */
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
