//
//  TKVideoPlayer.m
//  TKVideoPlayer
//
//  Created by hello on 2022/6/16.
//

#import "TKVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "TKPlayerConfig.h"
#import "TKPlayerControlView.h"

/// 播放器的播放状态
typedef NS_ENUM(NSInteger, TKVideoPlayerState) {
    TKVideoPlayerStateFailed,     // 播放失败
    TKVideoPlayerStateBuffering,  // 缓冲中
    TKVideoPlayerStatePlaying,    // 播放中
    TKVideoPlayerStatePause,      // 暂停播放
};

@interface TKVideoPlayer() <TKPlayerControlDelegate>

/** 播放器 */
@property (nonatomic, strong) AVPlayerItem *playerItem;
/** 播放器item */
@property (nonatomic, strong) AVPlayer *player;
/** 播放器layer */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** 是否播放完毕 */
@property (nonatomic, assign) BOOL isFinish;
/** 是否处于全屏状态 */
@property (nonatomic, assign) BOOL isFullScreen;
/** 播放器配置信息 */
@property (nonatomic, strong) TKPlayerConfig *playerConfig;
/** 视频播放控制面板 */
@property (nonatomic, strong) TKPlayerControlView *playbackControls;
/** 非全屏状态下播放器 superview */
@property (nonatomic, strong) UIView *originalSuperview;
/** 非全屏状态下播放器 frame */
@property (nonatomic, assign) CGRect originalRect;
/** 时间监听器 */
@property (nonatomic, strong) id timeObserve;
/** 播放器的播放状态 */
@property (nonatomic, assign) TKVideoPlayerState playerState;
/** 是否结束播放 */
@property (nonatomic, assign) BOOL playDidEnd;

@end

@implementation TKVideoPlayer

- (void)dealloc {
    self.playerItem = nil;
    // 需要移除，否则会影响外部试图布局
    // [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_timeObserve) {
        [_player removeTimeObserver:_timeObserve];
        _timeObserve = nil;
    }
    _playerLayer = nil;
    _player = nil;
}

#pragma mark - Init

- (instancetype)initWithConfig:(TKPlayerConfig *)config {
    self = [super init];
    if (self) {
        _playerConfig = config;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
    self.playbackControls.frame = self.bounds;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    NSLog(@"%s-%@", __func__, NSStringFromCGRect(frame));
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    NSLog(@"%s-%@", __func__, NSStringFromCGRect(bounds));
}

#pragma mark - Public Methods

- (void)setPlayerURL:(NSURL *)url {
    if (!url) return;
    
    _playerConfig.sourceUrl = url;
    
    [self _setupPlayer];
    [self _setupPlayControls];
}

- (void)playVideo {
    if (!self.playerLayer) return;
    
    if (self.playDidEnd && self.playbackControls.videoSlider.value == 1.0) {
        // 若播放已结束重新播放
        [self _replayVideo];
    } else {
        [_player play];
        [self.playbackControls _setPlayButtonSelect:YES];
        if (self.playerState == TKVideoPlayerStatePause) {
            self.playerState = TKVideoPlayerStatePlaying;
        }
    }
}

- (void)pauseVideo {
    [_player pause];
    
    [self.playbackControls _setPlayButtonSelect:NO];
    
    if (self.playerState == TKVideoPlayerStatePlaying) {
        self.playerState = TKVideoPlayerStatePause;
    }
}

- (void)releasePlayer {
    [self pauseVideo];
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    [self removeFromSuperview];
}

///** 屏幕翻转监听事件 */
//- (void)orientationChanged:(NSNotification *)notify {
//    if (_playerConfig.shouldAutorotate) {
//        [self orientationAspect];
//    }
//}

/** 根据屏幕旋转方向改变当前视频屏幕状态 */
- (void)orientationAspect
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft){
        if (!_isFullScreen){
            [self _videoZoomInWithDirection:UIInterfaceOrientationLandscapeRight];
        }
    }
    else if (orientation == UIDeviceOrientationLandscapeRight){
        if (!_isFullScreen){
            [self _videoZoomInWithDirection:UIInterfaceOrientationLandscapeLeft];
        }
    }
    else if(orientation == UIDeviceOrientationPortrait){
        if (_isFullScreen){
            [self _videoZoomOut];
        }
    }
}

/**
 视频放大全屏幕
 @param orientation 旋转方向
 */
- (void)_videoZoomInWithDirection:(UIInterfaceOrientation)orientation
{
    _originalSuperview = self.superview;
    _originalRect = self.frame;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    [keyWindow addSubview:self];
    
    CGRect videoPlayerViewFrameInWindow = [self convertRect:self.frame toView:nil];
    [self removeFromSuperview];
    [keyWindow addSubview:self];
    self.frame = videoPlayerViewFrameInWindow;
    
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:5 animations:^{
        
        self.transform = [self getARotation:UIInterfaceOrientationLandscapeRight];
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGPoint center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
        self.bounds = screenBounds;
        self.center = center;
        self.frame = screenBounds;
        self.playerLayer.frame = screenBounds;
    }];

    
//    self.frame = keyWindow.bounds;
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
    
    self.isFullScreen = YES;
    
    // 显示或隐藏状态栏
    [self.playbackControls _showOrHideStatusBar];
}

- (CGAffineTransform)getARotation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}


/** 视频退出全屏幕 */
- (void)_videoZoomOut
{
    //退出全屏时强制取消隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
    }completion:^(BOOL finished) {
        
    }];
    self.frame = _originalRect;
    self.playerLayer.frame = _originalRect;
    [_originalSuperview addSubview:self];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.isFullScreen = NO;
}

/** 重新播放 */
- (void)_replayVideo
{
    self.playDidEnd = NO;
    [_player seekToTime:CMTimeMake(0, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self playVideo];
}

static int gl_play_times = 0;
/** 监听播放器事件 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    gl_play_times += 1;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        // 计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [_playbackControls _setPlayerProgress:timeInterval / totalDuration];
    }
    else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
        
        // 当无缓冲视频数据时
        if (self.playerItem.playbackBufferEmpty) {
            self.playerState = TKVideoPlayerStateBuffering;
            [self bufferingSomeSecond];
        }
    }
    else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        // 当视频缓冲好时
        if (self.playerItem.playbackLikelyToKeepUp && self.playerState == TKVideoPlayerStateBuffering){
            self.playerState = TKVideoPlayerStatePlaying;
        }
    }
    else if ([keyPath isEqualToString:@"status"])
    {
        if (self.player.currentItem.status == AVPlayerStatusReadyToPlay) {
            gl_play_times = 0;
            [self setNeedsLayout];
            [self layoutIfNeeded];
            [self.layer insertSublayer:_playerLayer atIndex:0];
            self.playerState = TKVideoPlayerStatePlaying;
        }
        else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
            if (gl_play_times == 2)
            {
                gl_play_times = 0;
                return;
            }
            self.playerState = TKVideoPlayerStateFailed;
            [self reload_play];
        }
    }
}

- (void)reload_play
{
    [self setPlayerURL:self.playerConfig.sourceUrl];
    [self playVideo];
}

/**
 *  计算缓冲进度
 *  @return 缓冲进度
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma mark - 缓冲较差时候

/**
 *  缓冲较差时候回调这里
 */
- (void)bufferingSomeSecond {
    self.playerState = TKVideoPlayerStateBuffering;
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    __block BOOL isBuffering = NO;
    if (isBuffering) return;
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self pauseVideo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self playVideo];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.playerItem.isPlaybackLikelyToKeepUp)
        {
            [self bufferingSomeSecond];
        }
        
    });
}

///** 应用进入后台 */
//- (void)appDidEnterBackground:(NSNotification *)notify
//{
//    if (!self.playerLayer)
//    {
//        return;
//    }
//    [self pauseVideo];
//}
//
///** 应用进入前台 */
//- (void)appDidEnterPlayground:(NSNotification *)notify
//{
//    if (!self.playerLayer)
//    {
//        return;
//    }
//    [self playVideo];
//}

// 视频播放结束事件监听
- (void)videoDidPlayToEnd:(NSNotification *)notify
{
    if (!self.playerLayer)
    {
        return;
    }
    self.playDidEnd = YES;
    if (_playerConfig.repeatPlay) {
        [self _replayVideo];
    }else
    {
        [self pauseVideo];
    }
}

// 创建播放器 以及控制面板
- (void)_setupPlayer {
    self.playerItem = [AVPlayerItem playerItemWithURL:_playerConfig.sourceUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self _setVideoGravity:_playerConfig.videoGravity];
    
    [self createTimer];
    
    if (_playerConfig.shouldAutoPlay) {
        [self playVideo];
    }
}

/** 添加播放器控制面板 */
- (void)_setupPlayControls {
    [self addSubview:self.playbackControls];
}

/** 创建定时器 */
- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time){
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            [weakSelf.playbackControls _setPlaybackControlsWithPlayTime:currentTime totalTime:totalTime sliderValue:value];
        }
    }];
}

/**
 配置playerLayer拉伸方式
 @param videoGravity 拉伸方式
 */
- (void)_setVideoGravity:(TKVideoGravity)videoGravity {
    NSString *fillMode = AVLayerVideoGravityResize;
    switch (videoGravity) {
        case TKVideoGravityResize:
            fillMode = AVLayerVideoGravityResize;
            break;
        case TKVideoGravityResizeAspect:
            fillMode = AVLayerVideoGravityResizeAspect;
            break;
        case TKVideoGravityResizeAspectFill:
            fillMode = AVLayerVideoGravityResizeAspectFill;
            break;
        default:
            break;
    }
    _playerLayer.videoGravity = fillMode;
}


/**
 @param playerState 播放器的播放状态
 */
- (void)setPlayerState:(TKVideoPlayerState)playerState {
    _playerState = playerState;
    switch (_playerState) {
        case TKVideoPlayerStateBuffering: {
            [_playbackControls _activityIndicatorViewShow:YES];
        }
            break;
        case TKVideoPlayerStatePlaying: {
            [_playbackControls _activityIndicatorViewShow:NO];
        }
            break;
        case TKVideoPlayerStateFailed: {
            [_playbackControls _activityIndicatorViewShow:NO];
            [_playbackControls _retryButtonShow:YES];
        }
            break;
        default:
            break;
    }
}

// 改变全屏切换按钮状态
- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    _playbackControls.isFullScreen = isFullScreen;
}

// 根据playerItem，来添加移除观察者
- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    if (_playerItem == playerItem) {return;}
    
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    
    _playerItem = playerItem;
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        // 缓冲区空了，需要等待数据
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        // 缓冲区有足够数据可以播放了
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

#pragma mark - 播放器控制面板代理
#pragma mark - TKPlayerControlDelegate

/// 播放按钮点击事件
/// @param selected 播放按钮选中状态
- (void)playButtonAction:(BOOL)selected {
    if (selected) {
        [self pauseVideo];
    } else {
        [self playVideo];
    }
}

// 全屏切换按钮点击事件
- (void)fullScreenButtonAction {
    if (!_isFullScreen) {
        [self _videoZoomInWithDirection:UIInterfaceOrientationLandscapeRight];
    } else {
        [self _videoZoomOut];
    }
}

// 控制面板单击事件
- (void)tapGesture {
    [_playbackControls _playerShowOrHidePlaybackControls];
}

// 控制面板双击事件
- (void)doubleTapGesture {
    if (_playerConfig.supportedDoubleTap) {
        if (self.playerState == TKVideoPlayerStatePlaying) {
            [self pauseVideo];
        }
        else if (self.playerState == TKVideoPlayerStatePause)
        {
            [self playVideo];
        }
    }
}

// 重新加载视频
- (void)retryButtonAction {
    [_playbackControls _retryButtonShow:NO];
    [_playbackControls _activityIndicatorViewShow:YES];
    [self _setupPlayer];
    [self playVideo];
}

#pragma mark 滑杆拖动代理

/** 开始拖动 */
- (void)videoSliderTouchBegan:(TKVideoSlider *)slider {
    [self pauseVideo];
    [_playbackControls _playerCancelAutoHidePlaybackControls];
}

/** 结束拖动 */
-(void)videoSliderTouchEnded:(TKVideoSlider *)slider {
    if (slider.value != 1) {
        self.playDidEnd = NO;
    }
    
    if (!self.playerItem.isPlaybackLikelyToKeepUp) {
        [self bufferingSomeSecond];
    } else {
        //继续播放
        [self playVideo];
    }
    [_playbackControls _playerAutoHidePlaybackControls];
}

/** 拖拽中 */
- (void)videoSliderValueChanged:(TKVideoSlider *)slider{
    CGFloat totalTime = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    CGFloat dragedSeconds = totalTime * slider.value;
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    NSInteger currentTime = (NSInteger)CMTimeGetSeconds(dragedCMTime);
    [_playbackControls _setPlaybackControlsWithPlayTime:currentTime totalTime:totalTime sliderValue:slider.value];
}

#pragma mark - getter

- (TKPlayerControlView *)playbackControls {
    if (!_playbackControls) {
        _playbackControls = [[TKPlayerControlView alloc] init];
        _playbackControls.delegate = self;
        _playbackControls.hideInterval = _playerConfig.hideControlsInterval;
        _playbackControls.statusBarHideState = _playerConfig.statusBarHideState;
    }
    return _playbackControls;
}
@end
