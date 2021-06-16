//
//  TKRegularViewController.m
//  test
//
//  Created by hello on 2020/6/24.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKRegularViewController.h"

@interface TKRegularViewController ()

@end

@implementation TKRegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正则表达式";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    NSString *htmlString;
//    htmlString = @"<img src=\"https://s.eoffcn.com/tiku/html/2018082515590253/b.png\" name=\"图片 13\" align=\"bottom\" hspace=\"1\" vspace=\"1\" width=\"485\" height=\"76\" border=\"0\"/>";
    htmlString = @"<img src=\"myurl.jpg\" width=\"12\" name=\"图片\" height=\"32\">";
    
    NSError *error;
    NSString *regular = nil;
//    regular = @"<IMG[^><]*src=/\"([^/\"]*?)/\"[^><]*>";
//    NSString *regular = @"<(img|IMG)(.*?)(/>|></img>|>)";
    
    // 匹配
    regular = @"(<img\\b|(?!^)\\G)[^>]*?\\b(src|width|height)=([\"']?)([^\"]*)\\3";
    NSRegularExpression *regularExp = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionAllowCommentsAndWhitespace error:&error];
    NSArray<NSTextCheckingResult *> *result = [regularExp matchesInString:htmlString options:NSMatchingReportCompletion range:NSMakeRange(0, htmlString.length)];
    
    [result enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *rangeStr = [htmlString substringWithRange:obj.range];
        DLog(@"range:%@，string:%@", NSStringFromRange(obj.range), rangeStr);
    }];
    
}
@end
