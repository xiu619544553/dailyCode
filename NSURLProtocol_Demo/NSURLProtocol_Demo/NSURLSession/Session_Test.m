//
//  Session_Test.m
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
//

#import "Session_Test.h"
#import "AppDelegate.h"
#import "CustomURLProtocol.h"

@implementation Session_Test

+ (void)request {
    
    // url
    NSURL *url = [NSURL URLWithString:testUrlString];
    
    // request
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    mutableRequest.timeoutInterval = 10;
    mutableRequest.HTTPMethod = @"POST";
    mutableRequest.HTTPBody = [testQuery dataUsingEncoding:NSUTF8StringEncoding];
    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    // configuration
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.protocolClasses = @[[CustomURLProtocol class]];
    
    // session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:mutableRequest.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data.length > 0) {
            NSError *err = nil;
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            NSLog(@"%s \njsonData:\n%@", __func__, jsonData);
            
            if (err) {
                NSLog(@"err: %@", err.localizedDescription);
            }
        }
        
        
    }];
    [task resume];
}

@end
