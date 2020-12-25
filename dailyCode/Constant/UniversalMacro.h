//
//  UniversalMacro.h
//  dailyCode
//
//  Created by hello on 2020/8/19.
//  Copyright © 2020 TK. All rights reserved.
//

#ifndef UniversalMacro_h
#define UniversalMacro_h


#pragma mark - Log

#ifndef DLog
#define DLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#endif


/// 计算方法耗时
#ifndef kTICK
#define kTICK CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#endif

#if defined(kTICK) && !defined(kTOCK)
#define kTOCK NSLog(@"%@ : %s 耗时: %f", [self class], __func__, CFAbsoluteTimeGetCurrent() - start);
#endif


#pragma mark - Color

#ifndef kRGB
#define kRGB(r, g, b)       [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#endif

#ifndef kRGBA
#define kRGBA(r, g, b, a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#ifndef kRandomColor
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f]
#endif

#pragma mark - Font

// 粗体
#ifndef kFontForPFMedium
#define kFontForPFMedium(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#endif

// 普通
#ifndef kFontForPFRegular
#define kFontForPFRegular(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#endif

// 半粗体
#ifndef kFontForPFSemibold
#define kFontForPFSemibold(x) [UIFont fontWithName:@"PingFangSC-Semibold" size:x]
#endif


#pragma mark - Size

#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kImageName
#define kImageName(imageName)  [UIImage imageNamed:imageName]
#endif



#pragma mark - Device

/*
    2007年1月9日，第一代iPhone 2G发布
 　　2008年6月10日，第二代iPhone 3G发布
 　　2009年6月9日，第三代iPhone 3GS发布
 　　2010年6月8日，第四代iPhone 4发布
 　　2011年10月4日，第五代iPhone 4s发布
 　　2012年9月13日，第六代iPhone 5发布
 　　2013年9月10日，第七代iPhone 5c及iPhone 5s发布
 　　2014年9月10日，第八代iPhone 6及iPhone 6 Plus发布
 　　2015年9月10日，第九代iPhone 6s，iPhone SE及iPhone 6s Plus发布
 　　2016年9月8日， 第十代iPhone 7及iPhone 7 Plus发布
 　　2017年9月13日，第十一代iPhone 8，iPhone 8 Plus，iPhone X发布
 　　2018年9月13日，第十二代iPhone XS，iPhone XS Max，iPhone XR发布
 　　2019年9月11日，第十三代iPhone 11，iPhone 11 Pro，iPhone 11 Pro Max发布
 */

/// 判断是否是ipad
#ifndef kIsPad
#define kIsPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#endif

/// iPhone 4S
#ifndef kIsiPhone4S
#define kIsiPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// iPhone 5、5s、SE
/// 4英寸显示屏
#ifndef kIs_4Inch_Screen
#define kIs_4Inch_Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// iPhone 6、7、8
/// 4.7英寸显示屏
#ifndef kIs_47Inch_Screen
#define kIs_47Inch_Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// iPhone 6plus、7plus、8plus
/// 5.5英寸显示屏
#ifndef kIs_55Inch_Screen
#define kIs_55Inch_Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// iPhoneX、Xs、11Pro
#ifndef kIs_iPhoneX
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// 判断iPHone Xr、11
/// 6.1英寸显示屏
#ifndef kIs_iPhoneXR
#define kIs_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,1792), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// 判断iPhone Xs Max、11 Pro Max、
/// 6.5英寸显示屏
#ifndef kIs_iPhoneXS_MAX
#define kIs_iPhoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2688), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/// 有刘海屏的设备（这样写消除了在Xcode10上的警告）
#ifndef kIsSensorHousing
#define kIsSensorHousing \
({BOOL isSensor = NO;\
if (@available(iOS 11.0, *)) {\
isSensor = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isSensor);})
#endif


#pragma mark - Lock

#ifndef TK_LOCK
#define TK_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef TK_UNLOCK
#define TK_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif


#endif /* UniversalMacro_h */
