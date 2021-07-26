//
//  TKDynamicSpaceViewController.m
//  dailyCode
//
//  Created by hello on 2021/7/21.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKDynamicSpaceViewController.h"
#import "TKDynamicSpaceView.h"

@interface TKDynamicSpaceViewController ()
@property (nonatomic, strong) TKDynamicSpaceView *mainView;
@end

@implementation TKDynamicSpaceViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.mainView];
    
    
}

#pragma mark - Override Methods

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.mainView.frame = self.view.bounds;
}

#pragma mark - getter

- (TKDynamicSpaceView *)mainView {
    if (!_mainView) {
        _mainView = [[TKDynamicSpaceView alloc] init];
    }
    return _mainView;
}
@end
