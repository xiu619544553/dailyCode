//
//  TK_NSURL_ViewController.m
//  dailyCode
//
//  Created by hello on 2021/6/7.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TK_NSURL_ViewController.h"

@interface TK_NSURL_ViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TK_NSURL_ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    
    // MARK: 解析URL
    /*
     URL组成：
     protocol host path query
     
     示例
     http://www.apple.com/search?platform=iPad&system=ios
     
     scheme  ：http://
     host    ：www.apple.com
     path    ：search
     query   ：platform=iPad&system=ios
     */
    
    NSString *urlString = @"http://www.apple.com/search?platform=iPad&system=ios";
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSString *url = @"URL: ";
    NSString *scheme = @"Scheme: ";
    NSString *host = @"Host: ";
    NSString *query = @"Query: ";
    NSString *path = @"Path: ";
    NSString *content = [NSString stringWithFormat:@"%@%@ \n%@%@ \n%@%@ \n%@%@ \n%@%@", url, urlString, scheme, components.scheme, host, components.host, query, components.query, path, components.path];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
    
    NSDictionary *redDict = @{NSForegroundColorAttributeName : UIColor.redColor};
    [attributedText addAttributes:redDict range:[content rangeOfString:url]];
    [attributedText addAttributes:redDict range:[content rangeOfString:scheme]];
    [attributedText addAttributes:redDict range:[content rangeOfString:host]];
    [attributedText addAttributes:redDict range:[content rangeOfString:query]];
    [attributedText addAttributes:redDict range:[content rangeOfString:path]];
    
    self.textView.attributedText = attributedText;
    
    
    
    NSURLQueryItem *addItem1 = [NSURLQueryItem queryItemWithName:@"appid" value:@"test"];
    NSURLQueryItem *addItem2 = [NSURLQueryItem queryItemWithName:@"version" value:@"1.0.0"];
    
    // MARK: 添加参数1 - url本身包含query
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray arrayWithArray:components.queryItems];
    components.queryItems = queryItems;
    
    [queryItems addObject:addItem1];
    NSLog(@"components.string: %@", components.string);
    
    
    // MARK: 添加参数2 - url本身不包含query
    NSString *urlString2 = @"https://www.baidu.com";
    NSURLComponents *component2 = [NSURLComponents componentsWithString:urlString2];
    NSMutableArray<NSURLQueryItem *> *queryItems2 = [NSMutableArray arrayWithArray:component2.queryItems];
    [queryItems2 addObject:addItem1];
    [queryItems2 addObject:addItem2];
    
    component2.queryItems = queryItems2;
    NSLog(@"components2.string: %@", component2.string);
    
    /*
     结论：
        通过【添加参数2】方法，可以给url后面添加必要的参数，开发者无需关注url是否已包含 & 连接符，不需关注是否已有query。算是一种讨巧的方式。
     */
    
}

- (void)setupViews {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.textView];
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0));
//    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat bottomInset = 20.f;
    if (@available(iOS 11.0, *)) {
        bottomInset += self.view.safeAreaInsets.bottom;
    }
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20.0, 20.0, bottomInset, 20.0));
    }];
}

#pragma mark - getter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius = 8.0;
        _textView.layer.borderWidth = 1.0;
        _textView.layer.masksToBounds = YES;
        _textView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.font = [UIFont systemFontOfSize:20.0];
    }
    return _textView;
}
@end
