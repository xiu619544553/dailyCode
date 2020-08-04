//
//  TKTextViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/4.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTextViewController.h"
#import "TKTextView.h"

#import <objc/runtime.h>
#import <Masonry.h>

@interface TKTextViewController ()
@property (nonatomic, strong) TKTextView *textView;
@end

@implementation TKTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.blackColor;
    self.textView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(100.f, 15.f, 200.f, 15.f));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - getter

- (TKTextView *)textView {
    if (!_textView) {
        _textView = [[TKTextView alloc] init];
        _textView.scrollEnabled = NO;
        _textView.editable = NO;
        _textView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
        _textView.font = [UIFont systemFontOfSize:20.f];
        _textView.text = @"中公名师原创命题，力求让考生了解国考的题型题量。\n加备考qq群：797191226，\n电话：19801032830\n备用电话：13888888888\n官网：https://www.baidu.com\n地址：北京市海淀区学院路汉华大厦B座100号了解更多国考资讯、干货。\n国考考试中，试卷分为省级以上(含副省级)和市地级以下两类。\n两类试卷在总题量与考点设置上存在一定的差异，主要是基于招考岗位与测查能力的不同，其中市地级试卷130题，省级试卷135题。\n每周一会上架上周的模考试卷，请前往【试卷】--【模拟试卷】进行练习。";
        
        
    }
    return _textView;
}
@end
