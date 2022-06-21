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
@end

@implementation VideoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.ccPlayerView];

    [self.ccPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0.f);
        make.top.offset(200);
        make.height.mas_equalTo(self.ccPlayerView.mas_width).multipliedBy(9.f/16.f);
    }];

    NSString *urlStr = @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4";
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.ccPlayerView setPlayerURL:url];
    [self.ccPlayerView playVideo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
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
        _ccPlayerView.backgroundColor = [UIColor clearColor];
    }
    return _ccPlayerView;
}
@end
