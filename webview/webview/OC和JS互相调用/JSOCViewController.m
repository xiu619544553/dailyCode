//
//  JSOCViewController.m
//  webview
//
//  Created by hello on 2021/11/1.
//

#import "JSOCViewController.h"
#import <WebKit/WebKit.h>
#import "WeakWebViewScriptMessageDelegate.h"

/*
 OC与JS交互的三种方式：
 1、webview调用JS函数, JS代码可根据需要拼接好。
 NSString *JSFunc = xxx;
 [self.webView evaluateJavaScript:JSFunc completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    NSLog(@"evaluateJavaScript:\n result = %@ error = %@",result, error);
 }];
 
 2、网页JS调原生:
    1> 需要先设置Webview. config 的WKUserContentController
    2> 注册方法名 [userCC addScriptMessageHandler:self name:];
    3> 遵守协议<WKScriptMessageHandler>，实现其方法.
    4> 在控制器销毁时，需要移除方法名注册
 
 3、三.处理跳转链接（JS中的a标签、href等标签）
 /// 解释一下，前端网页中不仅仅是调用方法或者调用弹出框触发事件的，JS中的a标签，标签中又有href资源的话，用户直接点击不用调用方法就可以进行跳转，触发跳转的事件.
 - (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
 
 */

static void * const WebViewKVOContext = (void *)&WebViewKVOContext;

@interface JSOCViewController () <WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JSOCViewController

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
    if (_webView) {
        // 移除观察者
        [_webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                         context:WebViewKVOContext];
        [_webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(title))
                         context:WebViewKVOContext];
        
        // 移除注册的js方法
        [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcNoPrams"];
        [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcWithPrams"];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.webView.title;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.webView];
    [self.view bringSubviewToFront:self.progressView];
    
    // 添加观察者
    [self addObservers];
    
    // 加载页面
    [self loadRequest];
    
    // 设置导航栏
    [self setupNav];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"%s", __func__);
    
    self.progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2.0);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.progressView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.progressView.frame));
}

// 使用此方法更新界面以适应新的安全区。
// UIKit更新安全区域以响应系统条的大小变化，或者当你修改视图控制器的附加安全区域插入时。UIKit也会在视图出现在屏幕上之前立即调用这个方法。
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    NSLog(@"%s", __func__);
}

#pragma mark - Private

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbutton"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    // 刷新按钮
    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"webRefreshButton"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * refreshButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    
    UIBarButtonItem * ocToJs = [[UIBarButtonItem alloc] initWithTitle:@"OC调用JS" style:UIBarButtonItemStyleDone target:self action:@selector(ocToJs)];
    self.navigationItem.rightBarButtonItems = @[refreshButtonItem, ocToJs];
    
    self.navigationController.navigationBar.translucent = YES;
}

- (void)loadRequest {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)addObservers {
    // 监听webview的加载进度
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:(NSKeyValueObservingOptionNew)
                      context:WebViewKVOContext];
    // 监听标题
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(title))
                      options:NSKeyValueObservingOptionNew
                      context:WebViewKVOContext];
}

#pragma mark - Action Methods

- (void)backAction {
    if (_webView.canGoBack) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)refreshAction {
    [_webView reload];
}

- (void)ocToJs {
    //changeColor()是JS方法名，completionHandler是异步回调block
    NSString *jsString = [NSString stringWithFormat:@"changeColor('%@')", @"Js颜色参数"];
    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"改变HTML的背景色");
    }];
    
    // 改变字体大小 调用原生JS方法
    NSString *jsFont = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", arc4random()%99 + 100];
    [_webView evaluateJavaScript:jsFont completionHandler:nil];
    
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"copy_mutableCopy" ofType:@"png"];
    NSString *jsPicture = [NSString stringWithFormat:@"changePicture('%@','%@')", @"pictureId", path];
    [_webView evaluateJavaScript:jsPicture completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"切换本地头像");
    }];
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

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    // 用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    // JS调用OC
    if([message.name isEqualToString:@"jsToOcNoPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:@"不带参数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else if([message.name isEqualToString:@"jsToOcWithPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:parameter[@"params"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
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


/// 以上三个代理，是用来解决WKWebView不弹出javascript Alert问题

/// web界面中有弹出警告框时调用。比如JS调用 `alert("message");`，则会被该代理捕获
/// @param webView 实现该代理的webview
/// @param message 警告框中的内容
/// @param frame 一种对象，它包含关于网页上框架的信息。
/// @param completionHandler 警告框消失调用
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 确认框.
/// JavaScript调用confirm方法后回调的方法 confirm是js中的确定框,需要在block中把用户选择的情况传递进去.
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

// 打开新窗口,页面是弹出窗口blank处理,blank是js中"打开一个新窗口"的意思.
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - WKNavigationDelegate

/// 三.处理跳转链接（JS中的a标签等）
/// 解释一下，前端网页中不仅仅是调用方法或者调用弹出框触发事件的，JS中的a标签，标签中又有href资源的话，用户直接点击不用调用方法就可以进行跳转，触发跳转的事件.
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转.
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    if([urlStr hasPrefix:@"github://"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                }];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
    }else if ([urlStr hasPrefix:@"https://www.jianshu.com"]){//简书主页
        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }

}

// 页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = self.webView.title;
    NSLog(@"didFinishNavigation=====%@", self.webView.title);
}


#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        
        //创建网页配置对象.
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        //是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        configuration.allowsInlineMediaPlayback = YES;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        if (@available(iOS 10.0, *)) {
            configuration.mediaTypesRequiringUserActionForPlayback = YES;
        } else {}
        //设置是否允许画中画技术 在特定设备上有效
        configuration.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        configuration.applicationNameForUserAgent = @"XXXX";
        
        
        
        
//        // 以下代码适配文本大小
//        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//        //用于进行JavaScript注入
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        [configuration.userContentController addUserScript:wkUScript];
        
        
        
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题.
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
        configuration.userContentController = wkUController;
        
        //创建设置对象.
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 40;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        //在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preference;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:configuration];
        //UI代理.
        _webView.UIDelegate = self;
        //导航代理.
        _webView.navigationDelegate = self;
        //是否允许手势左滑返回上一级, 类似导航控制的左滑返回.
        _webView.allowsBackForwardNavigationGestures = YES;
        
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
