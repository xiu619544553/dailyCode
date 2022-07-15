//
//  VideoViewController.m
//  iOSTestDemo
//
//  Created by hello on 2022/6/20.
//

#import "VideoViewController.h"
#import "TKVideoPlayerHeader.h"
#import "Masonry.h"

@interface VideoViewController ()
@property (nonatomic, strong) TKVideoPlayer *ccPlayerView;
@property (nonatomic, strong) UILabel *videoInfoLabel;
@end

@implementation VideoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPlayerView];
    [self addAssistantViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)addPlayerView {
    
    [self.view addSubview:self.ccPlayerView];
    
#warning masonry 布局 playerView，playerView旋转后 bounds 为什么被置为了 0。
    //    [self.ccPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.offset(0.f);
    //        make.top.offset(200);
    //        make.height.mas_equalTo(self.ccPlayerView.mas_width).multipliedBy(9.f/16.f);
    //    }];
    
    
    self.ccPlayerView.frame = CGRectMake(0, 150, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) * 9.f / 16.f);
    
    NSString *urlStr = @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4";
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.ccPlayerView playVideoWithURL:url];
    [self.ccPlayerView playVideo];
    
    __weak typeof(self) ws = self;
    self.ccPlayerView.playerPlayTimeChanged = ^(NSTimeInterval currentTime, NSTimeInterval totalTime) {
        __strong typeof(ws) ss = ws;
        ss.videoInfoLabel.text = [NSString stringWithFormat:@"%.f : %.f", currentTime, totalTime];
    };
}

- (void)addAssistantViews {
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    actionBtn.frame = CGRectMake(15, CGRectGetMaxY(self.ccPlayerView.frame) + 50.f, 100, 45.f);
    actionBtn.backgroundColor = UIColor.blackColor;
    [actionBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [actionBtn setTitle:@"播放" forState:UIControlStateSelected];
    [actionBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal | UIControlStateSelected];
    [actionBtn addTarget:self action:@selector(actionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionBtn];
    
    
    _videoInfoLabel = ({
        UILabel *infoLabel = [UILabel new];
        infoLabel.numberOfLines = 0;
        infoLabel.font = [UIFont systemFontOfSize:14.f];
        infoLabel.backgroundColor = UIColor.blackColor;
        infoLabel.textColor = UIColor.whiteColor;
        [self.view addSubview:infoLabel];
        
        infoLabel;
    });
    [_videoInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10.f);
        make.bottom.offset(-50.f);
    }];
}

#pragma mark - Action Methods

- (void)actionBtnAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected) {
        [self.ccPlayerView pauseVideo];
    } else {
        [self.ccPlayerView playVideo];
    }
}

#pragma mark - getter

- (TKVideoPlayer *)ccPlayerView {
    if (!_ccPlayerView) {
        TKPlayerConfig *configuration = [[TKPlayerConfig alloc] init];
        configuration.shouldAutoPlay = NO;
        configuration.supportedDoubleTap = YES;
        configuration.shouldAutorotate = NO;
        configuration.repeatPlay = YES;
        configuration.statusBarHideState = TKStatusBarHideStateAlways;
        configuration.videoGravity = TKVideoGravityResizeAspect;
        
        _ccPlayerView = [[TKVideoPlayer alloc] initWithConfig:configuration];
        _ccPlayerView.userInteractionEnabled = YES;
        
        
    }
    return _ccPlayerView;
}
@end
