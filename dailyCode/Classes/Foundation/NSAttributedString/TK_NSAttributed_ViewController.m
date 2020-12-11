//
//  TK_NSAttributed_ViewController.m
//  dailyCode
//
//  Created by hello on 2020/12/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_NSAttributed_ViewController.h"

@interface TK_NSAttributed_ViewController ()

@end

@implementation TK_NSAttributed_ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     // This defines currently supported values for NSUnderlineStyleAttributeName and NSStrikethroughStyleAttributeName. These values are or'ed together to produce an underline style.
     // Underlines will be drawn with a solid pattern by default, so NSUnderlineStylePatternSolid does not need to be specified.
     typedef NS_OPTIONS(NSInteger, NSUnderlineStyle) {
         NSUnderlineStyleNone                                    = 0x00,
         NSUnderlineStyleSingle                                  = 0x01,
         NSUnderlineStyleThick API_AVAILABLE(macos(10.0), ios(7.0))      = 0x02,
         NSUnderlineStyleDouble API_AVAILABLE(macos(10.0), ios(7.0))     = 0x09,

         NSUnderlineStylePatternSolid API_AVAILABLE(macos(10.0), ios(7.0))      = 0x0000,
         NSUnderlineStylePatternDot API_AVAILABLE(macos(10.0), ios(7.0))        = 0x0100,
         NSUnderlineStylePatternDash API_AVAILABLE(macos(10.0), ios(7.0))       = 0x0200,
         NSUnderlineStylePatternDashDot API_AVAILABLE(macos(10.0), ios(7.0))    = 0x0300,
         NSUnderlineStylePatternDashDotDot API_AVAILABLE(macos(10.0), ios(7.0)) = 0x0400,

         NSUnderlineStyleByWord API_AVAILABLE(macos(10.0), ios(7.0))            = 0x8000
     } API_AVAILABLE(macos(10.0), ios(6.0));
     */
    
    /*
     key
     NSUnderlineStyleAttributeName  下划线样式
     NSUnderlineColorAttributeName  下划线颜色
     */
    
    NSDictionary *attrs = @{
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
        NSUnderlineColorAttributeName : UIColor.purpleColor,
        NSForegroundColorAttributeName:UIColor.redColor
    };
    
    
    NSString *prefix = @"前缀字符串";
    NSString *suffix = @"后缀字符串";
    
    NSMutableAttributedString *attrsStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", prefix, suffix]];
    [attrsStr setAttributes:attrs
                      range:[attrsStr.string rangeOfString:suffix]];
    
    
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 100.f, self.view.width - 30.f, 100.f)];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.numberOfLines = 0;
    oneLabel.textColor = UIColor.blackColor;
    oneLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30.f];
    oneLabel.attributedText = attrsStr;
    [self.view addSubview:oneLabel];
    
}

@end
