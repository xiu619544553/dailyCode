//
//  AppDelegate.h
//  NSURLProtocol_Demo
//
//  Created by hello on 2021/7/2.
//

#import <UIKit/UIKit.h>

static NSString *testQuery = @"abbreviation=appstore&app_name=%E4%B8%AD%E5%85%AC%E6%95%99%E8%82%B2&appid=zgjiaoyu&cms_version=7.9.6&device_type=iphone&platform=iphone&sign=f4a7926ed3a60716fd0f00beadf96482&system=12.4.7&user_from=15&version=7.10.0";

static NSString *testUrlString = @"http://zg-education.t.eoffcn.com/apiv3/visitor/getUpgradeDesc";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@end

