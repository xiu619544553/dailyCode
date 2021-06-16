//
//  WebViewController.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>

static void * const WebViewKVOContext = (void *)&WebViewKVOContext;

@interface WebViewController () <WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WebViewController

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
    if (_webView) {
        [_webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                         context:WebViewKVOContext];
        [_webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(title))
                         context:WebViewKVOContext];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.webView.title;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(2.f);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.insets(self.view.safeAreaInsets);
        } else {
            // Fallback on earlier versions
            make.edges.insets(UIEdgeInsetsZero);
        }
    }];
    [self.view bringSubviewToFront:self.progressView];
    
    // 监听webview的加载进度
    [_webView addObserver:self
               forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                  options:(NSKeyValueObservingOptionNew)
                  context:WebViewKVOContext];
    // 监听标题
    [_webView addObserver:self
               forKeyPath:NSStringFromSelector(@selector(title))
                  options:NSKeyValueObservingOptionNew
                  context:WebViewKVOContext];
    
    
    // 定制化需求 --> 加载页面
    __weak typeof(self) ws = self;
    [self customizedUserAgent:^(id _Nullable result, NSError * _Nullable error) {
        __strong typeof(ws) ss = ws;
        
        // navigator.userAgent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148
        
        NSString *userAgent = (NSString *)result;
        if (userAgent.length > 0) {
            [userAgent stringByAppendingString:@" app=pro"];
        }
        
        [self.webView setCustomUserAgent:userAgent];
        
        [ss loadRequest];
    }];
}

- (void)customizedUserAgent:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler   {
    [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:completionHandler];
}

- (void)loadRequest {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsInvokeOcAndOCCallback" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context != WebViewKVOContext) {
        return;
    }
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        NSNumber *value = change[NSKeyValueChangeNewKey];
        [self.progressView setProgress:value.floatValue animated:YES];
        
        if (value.floatValue >= 1.0) {
            [self.progressView performSelector:@selector(setProgress:) withObject:@0 afterDelay:0.5];
        }
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]) {
        NSString *title = change[NSKeyValueChangeNewKey];
        if (title != nil && title.length > 0) {
            self.title = title;
        }
        NSLog(@"title=====%@", title);
    }
}

#pragma mark - WKUIDelegate

// js端调起输入框prompt，客户端再该方法中通过 completionHandler 回调数据给H5页面


/// 监听js调起输入框的动作。其中 prompt、completionHandler 是我们常用的参数
/// @param webView WKWebView实例对象
/// @param prompt js输入框提示文字
/// @param defaultText defaultText
/// @param frame frame
/// @param completionHandler 客户端通过 completionHandler 回传数据给H5页面
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    NSLog(@"defaultText: %@\nprompt: %@", defaultText, prompt);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"H5页面调起了输入框prompt，请输入内容" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入账号";
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入密码";
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *account = alertController.textFields.firstObject.text;
        NSString *password = alertController.textFields.lastObject.text;
        
        if (account.length > 0 && password.length > 0) {
            NSString *callbackStr = [NSString stringWithFormat:@"账号：%@\n密码：%@", account, password];
            completionHandler(callbackStr);
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 解决WKWebView不弹出javascript Alert问题

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - WKNavigationDelegate

// 页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = self.webView.title;
    NSLog(@"didFinishNavigation=====%@", self.webView.title);
}

#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
        
        // 修改userAgent
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = UIColor.systemPinkColor;
        [self.view addSubview:_progressView];
    }
    return _progressView;
}
@end
