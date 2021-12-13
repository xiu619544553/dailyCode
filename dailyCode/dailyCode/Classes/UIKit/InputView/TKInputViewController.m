//
//  TKInputViewController.m
//  dailyCode
//
//  Created by hello on 2021/12/10.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKInputViewController.h"
#import "TKInputView.h"

@interface TKInputViewController ()

@end

@implementation TKInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)showStyle1:(UIButton *)sender {
    [self showTKInputViewWithStyle:InputViewStyleDefault];//显示样式一
}


- (IBAction)showStyle2:(UIButton *)sender {
    [self showTKInputViewWithStyle:InputViewStyleLarge];//显示样式二
}

- (void)showTKInputViewWithStyle:(InputViewStyle)style{
    
    [TKInputView showWithStyle:style configurationBlock:^(TKInputView *inputView) {
        /** 请在此block中设置inputView属性 */
        
        /** 代理 */
        inputView.delegate = self;
        
        /** 占位符文字 */
        inputView.placeholder = @"请输入评论文字...";
        /** 设置最大输入字数 */
        inputView.maxCount = 50;
        /** 输入框颜色 */
        inputView.textViewBackgroundColor = [UIColor groupTableViewBackgroundColor];
        
        /** 更多属性设置,详见TKInputView.h文件 */
        
    } sendBlock:^BOOL(NSString *text) {
        if(text.length){
            NSLog(@"输入的信息为:%@",text);
            self.title = text;
            return YES;//return YES,收起键盘
        }else{
            NSLog(@"显示提示框-请输入要评论的的内容");
            return NO;//return NO,不收键盘
        }
    }];
}

#pragma mark - TKInputViewDelagete

// TKInputView 将要显示
- (void)TKInputViewWillShow:(TKInputView *)inputView{
    
     /** 如果你工程中有配置IQKeyboardManager,并对TKInputView造成影响,请在TKInputView将要显示时将其关闭 */
    
     //[IQKeyboardManager sharedManager].enableAutoToolbar = NO;
     //[IQKeyboardManager sharedManager].enable = NO;
}

// TKInputView 将要影藏
- (void)TKInputViewWillHide:(TKInputView *)inputView{
    
     /** 如果你工程中有配置IQKeyboardManager,并对TKInputView造成影响,请在TKInputView将要影藏时将其打开 */
    
     //[IQKeyboardManager sharedManager].enableAutoToolbar = YES;
     //[IQKeyboardManager sharedManager].enable = YES;
}

@end
