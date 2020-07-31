//
//  AboutLineSpacingViewController.m
//  test
//
//  Created by hello on 2020/6/9.
//  Copyright © 2020 TK. All rights reserved.
// 在iOS中如何正确的实现行间距与行高 http://pingguohe.net/2018/03/29/how-to-implement-line-height.html

#import "AboutLineSpacingViewController.h"
#import <Masonry.h>

@interface AboutLineSpacingViewController ()

@end

@implementation AboutLineSpacingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.grayColor;
    
    NSString *text = @"在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在iOS中如何正确的实现行间距与行高在";
    
    
    
    
    UILabel *oneLabel = [UILabel new];
    oneLabel.backgroundColor = UIColor.whiteColor;
    oneLabel.numberOfLines = 0;
    oneLabel.text = text;
    [self.view addSubview:oneLabel];
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view.mas_centerX).offset(-10);
    }];
    
    UILabel *secLabel = [UILabel new];
    secLabel.backgroundColor = UIColor.whiteColor;
    secLabel.numberOfLines = 0;
    [self.view addSubview:secLabel];
    [secLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.mas_equalTo(self.view.mas_centerX).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    
    // oneLabel  --- 实际行高已经超过了10，因为文本上下绘制时有留白
    NSMutableParagraphStyle *onePS = [[NSMutableParagraphStyle alloc] init];
    onePS.lineSpacing = 10;
    
    NSMutableAttributedString *oneAttr = [[NSMutableAttributedString alloc] initWithString:text];
    [oneAttr addAttribute:NSParagraphStyleAttributeName value:onePS range:NSMakeRange(0, text.length)];
    oneLabel.attributedText = oneAttr;
    
    
#pragma mark - 在iOS中如何正确的实现行间距与行高  --- 行高为10的正确实现 = 10 - (secLabel.font.lineHeight - secLabel.font.pointSize);
    // two
    NSMutableParagraphStyle *twoPS = [[NSMutableParagraphStyle alloc] init];
    twoPS.lineSpacing = 10 - (secLabel.font.lineHeight - secLabel.font.pointSize);
    
    NSMutableAttributedString *secAttr = [[NSMutableAttributedString alloc] initWithString:text];
    [secAttr addAttribute:NSParagraphStyleAttributeName value:twoPS range:NSMakeRange(0, text.length)];
    secLabel.attributedText = secAttr;
    
    
    
    
    
    UILabel *errorLabel = [UILabel new];
    [errorLabel setText:@"❌错误方式"];
    [self.view addSubview:errorLabel];
    [errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneLabel);
        make.bottom.equalTo(errorLabel.mas_top).offset(5.f);
    }];
    
    UILabel *trueLabel = [UILabel new];
    [trueLabel setText:@"✅正确方式"];
    [self.view addSubview:trueLabel];
    [trueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secLabel);
        make.bottom.equalTo(secLabel.mas_top).offset(5.f);
    }];
}

@end
