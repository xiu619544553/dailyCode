//
//  TKVideoPlayer.h
//  TKVideoPlayer
//
//  Created by hello on 2022/6/16.
//

#import <UIKit/UIKit.h>

@class TKPlayerConfig;
@interface TKVideoPlayer : UIView

/// 初始化播放器
/// @param config 播放器配置信息
- (instancetype)initWithConfig:(TKPlayerConfig *)config;

/// 设置播放器URL
- (void)setPlayerURL:(NSURL *)url;

/// 播放视频
- (void)playVideo;

/// 暂停播放
- (void)pauseVideo;

/// 释放播放器  Release
- (void)releasePlayer;

@end
