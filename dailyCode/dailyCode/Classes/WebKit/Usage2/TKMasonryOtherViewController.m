//
//  TKMasonryOtherViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/14.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKMasonryOtherViewController.h"
#import <Masonry.h>
#import <WebKit/WebKit.h>

static NSString *urlString = @"http://m.t.eoffcn.com/news/index.html?id=209";
//static NSString *urlString = @"https://www.baidu.com";


static void * const kPABaseWebViewTitleKVOContext = (void*)&kPABaseWebViewTitleKVOContext;
static void * const kPABaseWebViewProgressKVOContext = (void*)&kPABaseWebViewProgressKVOContext;

// 屏幕宽高
#define kZGScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define kZGScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define iPhoneX ((int)((kZGScreenHeight/kZGScreenWidth)*100) == 216 ? YES:NO)
#define kZGSafeNavigationBarHeight (iPhoneX ? 88:64)

@interface TKMasonryOtherViewController () <WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TKMasonryOtherViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.urlString = urlString;
    
    
    CGFloat offset = kZGSafeNavigationBarHeight;
    offset = 40;
    
    if ([UIDevice currentDevice].isPad) {
        offset = 51.f;
    } else {
        offset = 40.f;
    }
    
    
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(-offset);
        make.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.webView).offset(offset);
        make.height.equalTo(@2);
    }];
    self.progressView.alpha = 0;
    
    
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:kPABaseWebViewProgressKVOContext];
    
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:kPABaseWebViewTitleKVOContext];
    
    self.webView.scrollView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"contentOffset = %@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_webView) {
        [_webView removeObserver:self
                      forKeyPath:@"estimatedProgress"
                         context:kPABaseWebViewProgressKVOContext];
        
        [_webView removeObserver:self
                      forKeyPath:@"title"
                         context:kPABaseWebViewTitleKVOContext];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    
    if (context == kPABaseWebViewProgressKVOContext && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat progress = [change[NSKeyValueChangeNewKey] doubleValue];
        
        NSLog(@"progress: %.2f", progress);
        
        self.progressView.alpha = 1.0f;
        CGFloat preferredProgress = MAX(progress, self.progressView.progress);
        BOOL animated = progress > self.progressView.progress;
        [self.progressView setProgress:(float)preferredProgress animated:animated];
        if (progress >= 1.0f) {
            [self.progressView setProgress:1.0f animated:YES];
            [UIView animateWithDuration:0.25f
                                  delay:0.1f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                self.progressView.alpha = 0;
            }
                             completion:^(BOOL finished) {
                [self.progressView setProgress:0 animated:NO];
            }];
        }
    }
    
    if (context == kPABaseWebViewTitleKVOContext && [keyPath isEqualToString:@"title"]) {
        NSString *title = change[NSKeyValueChangeNewKey];
        self.title = title;
        NSLog(@"title: %@", title);
    }
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
        self.progressView.alpha = 1.0f;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
        self.progressView.alpha = 0;
    //    if (self.needDisplayLoadingActivity) {
    //        [self hidenActivity];
    //    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
        self.progressView.alpha = 0;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
        self.progressView.alpha = 0;
    //    [self showEmptyView];
    //    if (self.needDisplayLoadingActivity) {
    //        [self hidenActivity];
    //    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE_IOS(9_0) {
    [self.webView reload];
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}


#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        webViewConfiguration.userContentController = userContentController;
        webViewConfiguration.allowsInlineMediaPlayback = YES;
        if (@available(iOS 10.0, *)) {
            webViewConfiguration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
            webViewConfiguration.dataDetectorTypes = WKDataDetectorTypePhoneNumber | WKDataDetectorTypeLink | WKDataDetectorTypeCalendarEvent;
        }
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewConfiguration];
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.allowsBackForwardNavigationGestures = YES;
        if (@available(iOS 9.0, *)) {
            _webView.allowsLinkPreview = YES;
        }
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = [UIColor redColor];
    }
    return _progressView;
}
@end
