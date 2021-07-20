//
//  CustomURLProtocol.h
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
/*
 参考
 https://blog.csdn.net/u014600626/article/details/108195234
 https://developer.apple.com/documentation/foundation/url_loading_system?language=objc
 https://github.com/liujinlongxa/NSURLProtocolDemo/blob/master/NSURLProtocolDemo/MySessionURLProtocol.m
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomURLProtocol : NSURLProtocol

+ (void)registerProtocol;

+ (void)unregisterProtocol;

@end

NS_ASSUME_NONNULL_END
