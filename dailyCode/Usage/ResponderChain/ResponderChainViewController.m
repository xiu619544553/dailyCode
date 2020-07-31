//
//  ResponderChainViewController.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "ResponderChainViewController.h"
#import "ResponderChainRootView.h"

@interface ResponderChainViewController ()
@property (nonatomic, strong) ResponderChainRootView *rootView;
@end

@implementation ResponderChainViewController

#pragma mark - LifeCycle Methods
- (void)loadView {
    self.view = self.rootView;
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s", __func__);
}

#pragma mark - getter

- (ResponderChainRootView *)rootView {
    if (!_rootView) {
        _rootView = [[ResponderChainRootView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
    }
    return _rootView;
}
@end
