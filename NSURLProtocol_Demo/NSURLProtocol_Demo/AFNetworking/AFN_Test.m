//
//  AFN_Test.m
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
//

#import "AFN_Test.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#include <CommonCrypto/CommonCrypto.h>

@implementation AFN_Test

+ (void)request {
    AFHTTPSessionManager *sessionMgr = [AFHTTPSessionManager manager];
    [sessionMgr POST:testUrlString
          parameters:testQuery
             headers:@{@"Referer" : [NSURL URLWithString:testUrlString].host}
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
    }];
}

+ (NSDictionary *)buildParams {
    NSMutableDictionary *params = @{
        @"abbreviation": @"appstore",
        @"app_name": @"中公教育",
        @"device_type": @"iphone",
        @"version" : @"7.10.0",
        @"appid" : @"zgjiaoyu",
        @"system" : [UIDevice currentDevice].systemVersion,
        @"platform" : @"iphone",
        @"user_from" : @"15",
        @"cms_version" : @"7.9.6"
    }.mutableCopy;
    
    [params setObject:[[self class] params:params appSecret:@"fhakls83a#4%8!q"]
               forKey:@"sign"];
    
    return params.copy;
}

+ (NSString *)params:(NSDictionary *)params appSecret:(NSString *)appSecret {
    
    NSMutableDictionary *handleParams = [NSMutableDictionary dictionaryWithDictionary:params];
    NSArray *keys = [handleParams allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *addStr = [NSMutableString string];
    // 拼接字符串 并且去掉空value的数据
    for (NSString *categoryId in sortedArray) {
        id value = [handleParams objectForKey:categoryId];
        NSString * valueStr;
        if ([value isKindOfClass:[NSString class]]) {
            valueStr = (NSString *)value;
        }else if ([value isKindOfClass:[NSNumber class]]){
            valueStr =  [NSString stringWithFormat:@"%zd", [value integerValue]];
        }
        if ((valueStr == nil) || ([valueStr length] == 0)) {
            [handleParams removeObjectForKey:categoryId];
            continue;
        }
        NSString *showStr = [NSString stringWithFormat:@"%@=%@&", categoryId, valueStr];
        [addStr appendString:showStr];
    }
    
    [addStr appendString:appSecret];
    
    NSString *md5Str = [[self class] md5ForString:addStr];
    return md5Str;
}

+ (NSString *)md5ForString:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
