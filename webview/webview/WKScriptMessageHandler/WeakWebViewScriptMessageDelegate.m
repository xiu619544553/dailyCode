//
//  WeakWebViewScriptMessageDelegate.m
//  webview
//
//  Created by hello on 2021/11/1.
//

#import "WeakWebViewScriptMessageDelegate.h"

@implementation WeakWebViewScriptMessageDelegate

#pragma mark - Init Methods

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
