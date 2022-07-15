//
//  SelPlayerConfiguration.h
//  TKVideoPlayer
//
//  Created by hello on 2022/6/16.
//

#import <UIKit/UIKit.h>
#import "TKVideoPlayerSupportUtils.h"

NS_ASSUME_NONNULL_BEGIN

/// 视频填充方式
typedef NS_ENUM(NSUInteger, TKVideoGravity){
    TKVideoGravityResize,           // 非均匀拉伸。两个维度完全填充至整个视图区域
    TKVideoGravityResizeAspect,     // 等比例拉伸，直到一个维度到达区域边界
    TKVideoGravityResizeAspectFill, // 等比例拉伸，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

/// 全屏状态下状态栏显示方式
typedef NS_ENUM(NSInteger, TKStatusBarHideState) {
    TKStatusBarHideStateFollowControls = 0, // 跟随控制面板显示
    TKStatusBarHideStateNever,              // 从不显示
    TKStatusBarHideStateAlways,             // 一直显示
};

static TKLogLevel _logLevel;
@interface TKPlayerConfig : NSObject

/** 是否自动播放 */
@property (nonatomic, assign) BOOL shouldAutoPlay;
/** 视频拉伸方式 */
@property (nonatomic, assign) TKVideoGravity videoGravity;
/** 是否重复播放 */
@property (nonatomic, assign) BOOL repeatPlay;
/** 是否支持双击暂停或播放 */
@property (nonatomic, assign) BOOL supportedDoubleTap;
/** 是否支持自动转屏 */
@property (nonatomic, assign) BOOL shouldAutorotate;
/** 隐藏控制面板延时时间 缺省5s */
@property (nonatomic, assign) NSTimeInterval hideControlsInterval;
/** 全屏状态下状态栏显示方式 */
@property (nonatomic, assign) TKStatusBarHideState statusBarHideState;

/// 视频请求头
@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *requestHeader;


/// 设置日志输出级别
/// @param logLevel 指定日志输出级别
+ (void)preferLogLevel:(TKLogLevel)logLevel;

@end

NS_ASSUME_NONNULL_END
