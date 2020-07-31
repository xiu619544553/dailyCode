//
//  TestSuccessViewController.m
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TestSuccessViewController.h"
#import "WXUClassOrderSuccessView.h"
#import <Masonry.h>

@interface TestSuccessViewController ()

@property (nonatomic, strong) WXUClassOrderSuccessView *successView;
@end

@implementation TestSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view addSubview:self.successView];
    [self.successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    DLog(@"screen.bounds = %@", NSStringFromCGRect(mainScreen.bounds));
    DLog(@"screen.bounds.size = %@", NSStringFromCGSize(mainScreen.bounds.size));
    
    UIScreenMode *currentMode = mainScreen.currentMode;
    DLog(@"currentMode.size = %@", NSStringFromCGSize(currentMode.size));
    
    
    if (kIs_4Inch_Screen) {
        DLog(@"4英寸显示屏");
    }
    
    if (kIs_47Inch_Screen) {
        DLog(@"4.7英寸手机屏幕");
    }
    
    if (kIs_55Inch_Screen) {
        DLog(@"5.5英寸手机屏幕");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getter

- (WXUClassOrderSuccessView *)successView {
    if (!_successView) {
        _successView = [[WXUClassOrderSuccessView alloc] initWithIsCorrectionGoods:self.isCorrectionGoods];
    }
    return _successView;
}
@end
