//
//  TKVideoPlayer.m
//  TKVideoPlayer
//
//  Created by hello on 2022/6/16.
//

#import "TKVideoPlayer.h"
#import "TKPlayerConfig.h"
#import "TKPlayerControlView.h"
#import "TKGCDExtensions.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const kStatus                   = @"status";
static NSString *const kLoadedTimeRanges         = @"loadedTimeRanges";
static NSString *const kPlaybackBufferEmpty      = @"playbackBufferEmpty";
static NSString *const kPlaybackLikelyToKeepUp   = @"playbackLikelyToKeepUp";
static NSString *const kPresentationSize         = @"presentationSize";


@interface TKVideoPlayer() <TKPlayerControlDelegate>


@property (nonatomic, strong) AVURLAsset *asset;
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

/// 窗口方向
@property (nonatomic, assign) TKVideoPlayerInterfaceOrientation interfaceOrientation;

@end

@implementation TKVideoPlayer

- (void)dealloc {
    NSLog(@"%@__%s", NSStringFromClass([self class]), __FUNCTION__);
    
    _playerItem = nil;
    
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
        
        self.backgroundColor = UIColor.blackColor;
        
        _playerConfig = config;
        
        self.playbackControls = ({
            TKPlayerControlView *controlView = [[TKPlayerControlView alloc] init];
            controlView.delegate = self;
            controlView.hideInterval = _playerConfig.hideControlsInterval;
            controlView.statusBarHideState = _playerConfig.statusBarHideState;
            
            controlView;
        });
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
    self.playbackControls.frame = self.bounds;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.playerLayer.frame = self.bounds;
    self.playbackControls.frame = self.bounds;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    self.playerLayer.frame = self.bounds;
    self.playbackControls.frame = self.bounds;
}

#pragma mark - Public Methods

- (void)playVideoWithURL:(NSURL *)url {
    if (!url) return;
    
    _assetURL = url;
    
    [self _setupPlayer];
    [self _setupPlayControls];
    [self activeAudioSessionIfNeed];
}

#pragma mark - AudioSession

// 播放视频
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


- (void)seekToTime:(NSTimeInterval)seconds completionHandler:(void (^ __nullable)(BOOL finished))completionHandler {
    if (!_player) return;
    
    CMTime seekTime = CMTimeMakeWithSeconds(seconds, 1);
    if(!CMTIME_IS_VALID(seekTime) || CMTIME_IS_INDEFINITE(seekTime)) return;
    
    [_player.currentItem cancelPendingSeeks];
    [_player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:completionHandler];
}

// 暂停播放
- (void)pauseVideo {
    [_player pause];
    [_playerItem cancelPendingSeeks];
    [_asset cancelLoading];
    
    [self.playbackControls _setPlayButtonSelect:NO];
    
    if (self.playerState == TKVideoPlayerStatePlaying) {
        self.playerState = TKVideoPlayerStatePause;
    }
}

// releasePlayer
- (void)releasePlayer {
    [self pauseVideo];
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    [self removeFromSuperview];
}

// 重新播放
- (void)_replayVideo {
    self.playDidEnd = NO;
    [_player seekToTime:CMTimeMake(0, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self playVideo];
}

- (void)activeAudioSessionIfNeed {
    AVAudioSessionCategory audioSessionCategory = AVAudioSessionCategoryPlayback;
    [AVAudioSession.sharedInstance setActive:YES error:nil];
    [AVAudioSession.sharedInstance setCategory:audioSessionCategory error:nil];
}

#pragma mark - AVPlayer Observer

- (void)addPlayerItemObserver:(AVPlayerItem *)playerItem {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    [playerItem addObserver:self forKeyPath:kStatus options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kPlaybackBufferEmpty options:NSKeyValueObservingOptionNew context:nil];    // 缓冲区空了，需要等待数据
    [playerItem addObserver:self forKeyPath:kPlaybackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:nil]; // 缓冲区有足够数据可以播放了
    [playerItem addObserver:self forKeyPath:kPresentationSize options:NSKeyValueObservingOptionNew context:nil]; // 缓冲区有足够数据可以播放了
}

- (void)removePlayerItemObserver:(AVPlayerItem *)playerItem {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [playerItem removeObserver:self forKeyPath:kStatus];
    [playerItem removeObserver:self forKeyPath:kLoadedTimeRanges];
    [playerItem removeObserver:self forKeyPath:kPlaybackBufferEmpty];
    [playerItem removeObserver:self forKeyPath:kPlaybackLikelyToKeepUp];
    [playerItem removeObserver:self forKeyPath:kPresentationSize];
}

- (void)playerItemDidPlayToEnd:(NSNotification *)notification {
    AVPlayerItem *playerItem = notification.object;
    if(playerItem != self.playerItem) { return; }
    if (!self.playerLayer) { return; }
    
    self.playerState = TKVideoPlayerStatePlayToEnd;
    
    self.playDidEnd = YES;
    if (_playerConfig.repeatPlay) {
        [self _replayVideo];
    } else {
        [self pauseVideo];
    }
    
    !self.playerDidToEnd ?: self.playerDidToEnd();
    
    TKDebugLog(@"Player Item Did Play To End");
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:kStatus]) {
        
        AVPlayerItemStatus status = self.playerItem.status;
        switch (status) {
            case AVPlayerStatusUnknown: {
                TKDebugLog(@"AVPlayerStatusUnknown");
                self.playerState = TKVideoPlayerStateUnknown;
            }
                break;
                
            case AVPlayerStatusReadyToPlay: {
                TKDebugLog(@"AVPlayerStatusReadyToPlay");
                self.playerState = TKVideoPlayerStateReadyToPlay;
                [self setNeedsLayout];
                [self layoutIfNeeded];
                [self.layer insertSublayer:_playerLayer atIndex:0];
                
                
                if (_playerConfig.shouldAutoPlay) {
                    [self playVideo];
                } else {
                    [self pauseVideo];
                }
                
            }
                break;
                
            case AVPlayerItemStatusFailed: {
                TKDebugLog(@"AVPlayerItemStatusFailed");
                self.playerState = TKVideoPlayerStateFailed;
                !self.playerPlayFailed ?: self.playerPlayFailed(self.player.currentItem.error);
            }
                break;
                
            default:
                break;
        }
        
        [self invokePlayerStateDidChangeDelegateMethod];
        
    }
    else if ([keyPath isEqualToString:kPlaybackBufferEmpty]) { // 当无缓冲视频数据时
        BOOL playbackBufferEmpty = self.playerItem.playbackBufferEmpty;
        TKDebugLog(@"playbackBufferEmpty: %@.", playbackBufferEmpty ? @"empty" : @"not empty");
        if (playbackBufferEmpty) {
            self.playerState = TKVideoPlayerStateBuffering;
            [self bufferingSomeSecond];
            [self invokePlayerStateDidChangeDelegateMethod];
        }
    }
    else if ([keyPath isEqualToString:kLoadedTimeRanges]){
        // 计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [_playbackControls _setPlayerProgress:timeInterval / totalDuration];
    }
    else if ([keyPath isEqualToString:kPlaybackLikelyToKeepUp]) {
        BOOL playbackLikelyToKeepUp = self.playerItem.playbackLikelyToKeepUp;
        TKDebugLog(@"%@", playbackLikelyToKeepUp ? @"buffering finished, start to play." : @"start to buffer.");
        if (playbackLikelyToKeepUp){
            self.playerState = TKVideoPlayerStatePlaying;
            [self invokePlayerStateDidChangeDelegateMethod];
        }
    }
    else if ([keyPath isEqualToString:kPresentationSize]) {
        self.presentationSize = self.playerItem.presentationSize;
        TKDebugLog(@"presentationSize：%@", NSStringFromCGSize(self.presentationSize));
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/// 计算缓冲进度
/// @return 缓冲的视频长度
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue]; // 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma mark - 缓冲较差时候

// 缓冲较差时候回调这里
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
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
    });
}

// 创建播放器 以及控制面板
- (void)_setupPlayer {
    self.asset = [AVURLAsset URLAssetWithURL:_assetURL options:_playerConfig.requestHeader];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    [self _setVideoGravity:_playerConfig.videoGravity];
    if (@available(iOS 9.0, *)) {
        _playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = NO;
    }
    if (@available(iOS 10.0, *)) {
        _playerItem.preferredForwardBufferDuration = 5;
    }
    
    [self itemObserving];
    
    if (_playerConfig.shouldAutoPlay) {
        [self playVideo];
    }
}

// 添加播放器控制面板
- (void)_setupPlayControls {
    [self addSubview:self.playbackControls];
}

// 创建定时器
- (void)itemObserving {
    __weak typeof(self) wself = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        __strong typeof(wself) sself = wself;
        if (!sself) return;
        
        AVPlayerItem *currentItem = wself.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            
            NSTimeInterval currentTime = CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            [wself.playbackControls _setPlaybackControlsWithPlayTime:currentTime totalTime:totalTime sliderValue:value];
            
            !sself.playerPlayTimeChanged ?: sself.playerPlayTimeChanged(currentTime, totalTime);
        }
    }];
}

/// 配置playerLayer拉伸方式
/// @param videoGravity videoGravity 拉伸方式
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

/// 设置播放器状态
/// @param playerState 播放器的播放状态
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
    if (_playerItem == playerItem) { return; }
    
    if (_playerItem) {
        [self removePlayerItemObserver:_playerItem];
    }
    
    _playerItem = playerItem;
    if (playerItem) {
        [self addPlayerItemObserver:playerItem];
    }
}

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
    _isFullScreen = !_isFullScreen;
    
    if (_isFullScreen) {
        [self rotationToLandscape];
    } else {
        [self rotationToPortrait];
    }
}

- (void)rotationToLandscape {
    
    _originalRect = self.frame;
    _originalSuperview = self.superview;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect playerFrame = [self convertRect:self.frame toView:keyWindow];
    [self removeFromSuperview];
    [keyWindow addSubview:self];
    self.frame = playerFrame;
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        [self executeLandscape];
    }
                     completion:^(BOOL finished) {
        self.interfaceOrientation = TKVideoPlayerInterfaceOrientationLandscape;
        [self invokePlayerInterfaceOrientationDidChangeDelegateMethod];
    }];
}

- (void)rotationToPortrait {
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        [self executePortrait];
    }
                     completion:^(BOOL finished) {
        self.interfaceOrientation = TKVideoPlayerInterfaceOrientationPortrait;
        [self invokePlayerInterfaceOrientationDidChangeDelegateMethod];
    }];
}

- (void)executeLandscape {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect bounds = CGRectMake(0, 0, CGRectGetHeight(screenBounds), CGRectGetWidth(screenBounds));
    CGPoint center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    self.bounds = bounds;
    self.center = center;
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)executePortrait {
    self.transform = CGAffineTransformIdentity;
    [self removeFromSuperview];
    [self.originalSuperview addSubview:self];
    self.frame = self.originalRect;
}

- (void)finishPortrait {}

- (CGAffineTransform)getARotation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI * 1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI_2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
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

// 开始拖动
- (void)videoSliderTouchBegan:(TKVideoSlider *)slider {
    [self pauseVideo];
    [_playbackControls _playerCancelAutoHidePlaybackControls];
}

// 结束拖动
- (void)videoSliderTouchEnded:(TKVideoSlider *)slider {
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

// 拖拽中
- (void)videoSliderValueChanged:(TKVideoSlider *)slider{
    CGFloat totalTime = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    CGFloat dragedSeconds = totalTime * slider.value;
    // 转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    NSInteger currentTime = (NSInteger)CMTimeGetSeconds(dragedCMTime);
    [_playbackControls _setPlaybackControlsWithPlayTime:currentTime totalTime:totalTime sliderValue:slider.value];
}

#pragma mark - Private Methods

- (void)invokePlayerInterfaceOrientationDidChangeDelegateMethod {
    TKDispatchAsyncOnMainQueue(^{
        if (self.orientationDelegate && [self.orientationDelegate respondsToSelector:@selector(videoPlayer:interfaceOrientationDidChange:)]) {
            [self.orientationDelegate videoPlayer:self interfaceOrientationDidChange:self.interfaceOrientation];
        }
    });
}

- (void)invokePlayerStateDidChangeDelegateMethod {
    TKDispatchAsyncOnMainQueue(^{
        if (self.videoPlayerDelegate && [self.videoPlayerDelegate respondsToSelector:@selector(videoPlayer:playerStateDidChange:)]) {
            [self.videoPlayerDelegate videoPlayer:self playerStateDidChange:self.playerState];
        }
    });
}

@end
