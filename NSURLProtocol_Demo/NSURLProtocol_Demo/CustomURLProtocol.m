//
//  CustomURLProtocol.m
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
//

#import "CustomURLProtocol.h"

#define kRequestIdentifiers @"RequestIdentifiers"

@interface CustomURLProtocol () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession * session;

@end

@implementation CustomURLProtocol

#pragma mark - Public Methods

+ (void)registerProtocol {
    [NSURLProtocol registerClass:[CustomURLProtocol class]];
}

+ (void)unregisterProtocol {
    [NSURLProtocol unregisterClass:[CustomURLProtocol class]];
}


#pragma mark - 拦截

/// 是否拦截处理指定的请求 - 子类必须实现该方法
/// @param request 指定请求
/// @return YES 表示要拦截处理；NO 表示不拦截处理
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSLog(@"%s", __func__);
    
    // 防止无限循环，因为一个请求在被拦截处理过程中，也会发起一个请求，这样又会走到这里，如果不进行处理，就会造成无限循环
    id value = [NSURLProtocol propertyForKey:kRequestIdentifiers inRequest:request];
    
    if (value) {
        
        return NO;
    }
    
    // 如果url已http或https开头，则进行拦截处理，否则不处理
    NSString *url = request.URL.absoluteString;
    if ([url hasPrefix:@"http"] || [url hasPrefix:@"https"]) {
        
        return YES;
    }
    
    return NO;
}


/// 如果需要对请求进行重定向，添加指定头部等操作，可以在该方法中进行 - 子类必须实现该方法
/// @param request 指定请求
/// @return 修改后的请求
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    NSLog(@"%s", __func__);
    
    // 修改了请求的头部信息
//    NSMutableURLRequest * mutableReq = [request mutableCopy];
//    NSMutableDictionary * headers = [mutableReq.allHTTPHeaderFields mutableCopy];
//    [headers setObject:@"BBBB" forKey:@"Key2"];
//    mutableReq.allHTTPHeaderFields = headers;
//    NSLog(@"session reset header");
//    return [mutableReq copy];
    
    return request;
}


/*
 如果有两个URL请求，并且他们是相等的，那么这里可以使用相同的缓存空间通常只需要调用父类的实现
 */
/*!
 @method requestIsCacheEquivalent:toRequest:
 @abstract 比较关于缓存的两个等价请求。
 @discussion 当且仅当请求由相同的协议处理并且该协议在执行特定于实现的检查后声明它们是等价的，那么对于缓存目的，请求被认为是等价的。
 @result 如果两个请求是缓存等效的，则为YES，否则为NO。
 */
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    NSLog(@"%s", __func__);
    return [super requestIsCacheEquivalent:a toRequest:b];
}


#pragma mark - 转发

- (instancetype)initWithTask:(NSURLSessionTask *)task cachedResponse:(nullable NSCachedURLResponse *)cachedResponse client:(nullable id <NSURLProtocolClient>)client {
    NSLog(@"%s", __func__);
    return [super initWithTask:task cachedResponse:cachedResponse client:client];
}

/*
 重点利用的一个方法，可以在里面做判断是否使用缓存，
 如果使用缓存，则对数据进行反归档，并直接实现client几个协议方法；
 如果不使用缓存，则创建一个 NSURLConnection 或 NSURLSession 对象。
 */
/// 开始加载，在该方法中，加载一个请求。
/// @discussion 当调用此方法时，协议实现应该开始加载请求。
- (void)startLoading {
    
    NSLog(@"%s", __func__);
    
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    
    // 表示该请求已经被处理，防止无限循环
    [NSURLProtocol setProperty:@(YES)
                        forKey:kRequestIdentifiers
                     inRequest:mutableRequest];
    
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    // session
//    _session = [NSURLSession sessionWithConfiguration:config];
//    NSURLSessionDataTask *task = [_session dataTaskWithRequest:mutableRequest.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        if (data.length > 0) {
//            NSError *err = nil;
//            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
//            NSLog(@"%s \njsonData:\n%@", __func__, jsonData);
//
//            if (err) {
//                NSLog(@"err: %@", err.localizedDescription);
//            }
//        }
//
//    }];
//    [task resume];
    
    
    //这个enableDebug随便根据自己的需求了，可以直接拦截到数据返回本地的模拟数据，进行测试
    BOOL enableDebug = NO;
    if (enableDebug) {
        
        NSString *str = @"测试数据";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:mutableRequest.URL
                                                            MIMEType:@"text/plain"
                                               expectedContentLength:data.length
                                                    textEncodingName:nil];
        [self.client URLProtocol:self
              didReceiveResponse:response
              cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else {
        //使用NSURLSession继续把request发送出去
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:mainQueue];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.request];
        [task resume];
    }
}

/// 取消特定协议的请求
/// @discussion 当调用此方法时，协议实现应该结束加载请求的工作。这可能是对取消操作的响应，因此协议实现必须能够在进行加载时处理这个调用
- (void)stopLoading {
    
    NSLog(@"%s", __func__);
    
    [self.session invalidateAndCancel];
    self.session = nil;
}


#pragma mark - NSURLSessionDelegate

/*
 The last message a session receives.  A session will only become invalid because of a systemic error or when it has been explicitly invalidated, in which case the error parameter will be nil.
 会话接收到的最后一条消息。会话只有在系统错误或显式无效时才会失效，在这种情况下，error参数将为nil。
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    
}

/* If implemented, when a connection level authentication challenge has occurred, this delegate will be given the opportunity to provide authentication credentials to the underlying connection. Some types of authentication will apply to more than one request on a given connection to a server (SSL Server Trust challenges).  If this delegate message is not implemented, the behavior will be to use the default handling, which may involve user interaction.
 如果实现了，当发生连接级身份验证挑战时，该委托将有机会向底层连接提供身份验证凭据。某些类型的身份验证将应用于到服务器的给定连接上的多个请求(SSL服务器信任挑战)。如果此委托消息没有实现，则行为将使用默认处理，这可能涉及用户交互。
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
}

#pragma mark - NSURLSessionDataDelegate

// 请求结束或者是失败的时候调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

// 接收到返回信息时(还未开始下载), 执行的代理方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

// 接收到服务器返回的数据 调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    // 打印返回数据
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr) {
        NSLog(@"***截取数据***: %@", dataStr);
    }
    
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler {
    completionHandler(proposedResponse);
}
@end
