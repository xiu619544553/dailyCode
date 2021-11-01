//
//  WeakWebViewScriptMessageDelegate.h
//  webview
//
//  Created by hello on 2021/11/1.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/// WKWebView 内存不释放的问题解决。该协议专门用来处理`JS`调用原生`OC`的方法

@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
