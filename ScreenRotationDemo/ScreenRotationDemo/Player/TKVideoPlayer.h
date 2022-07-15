//
//  TKVideoPlayer.h
//  TKVideoPlayer
//
//  Created by hello on 2022/6/16.
//

#import <UIKit/UIKit.h>

@class TKVideoPlayer;

NS_ASSUME_NONNULL_BEGIN

/// 播放器旋转方向
typedef NS_ENUM(NSInteger, TKVideoPlayerInterfaceOrientation) {
    TKVideoPlayerInterfaceOrientationUnknown = 0,
    TKVideoPlayerInterfaceOrientationPortrait,
    TKVideoPlayerInterfaceOrientationLandscape,
};


/// 播放器的播放状态
typedef NS_ENUM(NSInteger, TKVideoPlayerState) {
    TKVideoPlayerStateUnknown = 0,
    TKVideoPlayerStateReadyToPlay, // 播放器已准备好播放item
    TKVideoPlayerStateBuffering,   // 缓冲中
    TKVideoPlayerStatePlaying,     // 播放中
    TKVideoPlayerStateFailed,      // 播放失败
    TKVideoPlayerStatePause,       // 暂停播放
    TKVideoPlayerStatePlayToEnd    // 播放已完成
};

@protocol TKVideoPlayerOrientationDelegate <NSObject>

- (void)videoPlayer:(nonnull TKVideoPlayer *)videoPlayer interfaceOrientationDidChange:(TKVideoPlayerInterfaceOrientation)interfaceOrientation;

@end


@protocol TKVideoPlayerDelegate <NSObject>

- (void)videoPlayer:(nonnull TKVideoPlayer *)videoPlayer playerStateDidChange:(TKVideoPlayerState)playerState;

@end


@class TKPlayerConfig;
@interface TKVideoPlayer : UIView

/// 初始化播放器
/// @param config 播放器配置信息
- (instancetype)initWithConfig:(TKPlayerConfig *)config;

/// 设置播放器URL
- (void)playVideoWithURL:(NSURL *)url;

/// 播放视频
- (void)playVideo;

/// 暂停播放
- (void)pauseVideo;

/// 释放播放器
- (void)releasePlayer;


/// 播放指定时间的视频
/// @param seconds 视频跳转到多少秒
/// @param completionHandler 完成的回调
- (void)seekToTime:(NSTimeInterval)seconds completionHandler:(void (^ __nullable)(BOOL finished))completionHandler;


/// The play asset URL.
@property (nonatomic, strong, readonly) NSURL *assetURL;

/// The video size.
@property (nonatomic, assign) CGSize presentationSize;

@property (nonatomic, weak) id<TKVideoPlayerOrientationDelegate> orientationDelegate;
@property (nonatomic, weak) id<TKVideoPlayerDelegate> videoPlayerDelegate;





/// 播放进度发生变化时的回调
@property (nonatomic, copy, nullable) void(^playerPlayTimeChanged)(NSTimeInterval currentTime, NSTimeInterval totalTime);

/// 播放失败的回调
@property (nonatomic, copy, nullable) void(^playerPlayFailed)(NSError *error);

/// 播放完成的回调
@property (nonatomic, copy, nullable) void(^playerDidToEnd)(void);


@end



NS_ASSUME_NONNULL_END
