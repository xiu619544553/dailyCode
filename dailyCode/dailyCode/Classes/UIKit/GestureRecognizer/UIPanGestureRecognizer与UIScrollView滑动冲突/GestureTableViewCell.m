//
//  GestureTableViewCell.m
//  viptemp
//
//  Created by hello on 2022/7/13.
//

#import "GestureTableViewCell.h"

// 拖拽方向
typedef NS_ENUM(NSInteger, PanDirection) {
    PanDirectionNone,
    PanDirectionUp,
    PanDirectionDown,
    PanDirectionRight,
    PanDirectionLeft
};

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgb(r,g,b) rgba(r,g,b,1)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface GestureTableViewCell () <UIGestureRecognizerDelegate> {
    PanDirection _direction;      /// 拖拽手势移动方向
    BOOL _isHorizontalPanGesture; /// 是否是水平方向拖拽手势
}

@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) NSInteger totalTime;

@end

@implementation GestureTableViewCell

#pragma mark - Public Methods

+ (CGFloat)heightForCell {
    CGFloat videoH = [GestureTableViewCell heightForVideo];
    CGFloat btnH = 35.f;
    CGFloat separatorH = 10.f;
    return videoH + btnH + separatorH;
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = rgb(245, 245, 245);
        
        _totalTime = 5100;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.videoView = ({
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [GestureTableViewCell heightForVideo])];
        container.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:container];
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:container.bounds];
        titleLb.text = @"视频区域";
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.textColor = UIColor.blackColor;
        titleLb.font = [UIFont boldSystemFontOfSize:35];
        titleLb.layer.borderColor = UIColor.blackColor.CGColor;
        titleLb.layer.borderWidth = 1;
        [container addSubview:titleLb];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        pan.delegate = self;
        [container addGestureRecognizer:pan];
        
        container;
    });
    
    self.collectBtn = ({
        UIButton *btn = [self btnWithTitle:@"收藏" frame:CGRectMake(0, CGRectGetMaxY(self.videoView.frame), SCREEN_WIDTH / 2.f, 35.f)];
        
        btn;
    });
    
    self.likeBtn = ({
        CGRect collectFrame = self.collectBtn.frame;
        UIButton *btn = [self btnWithTitle:@"喜欢" frame:CGRectMake(CGRectGetMaxX(collectFrame), CGRectGetMinY(collectFrame), CGRectGetWidth(collectFrame), CGRectGetHeight(collectFrame))];
        
        btn;
    });
    
    self.timeLabel = ({
        CGFloat lbW = 150;
        CGFloat lbH = 50;
        CGFloat lbX = (SCREEN_WIDTH - lbW)/2.f;
        CGFloat lbY = 30.f;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
        lb.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        lb.layer.cornerRadius = 5.f;
        lb.layer.masksToBounds = YES;
        lb.hidden = YES;
        lb.textColor = UIColor.whiteColor;
        lb.font = [UIFont boldSystemFontOfSize:15.f];
        lb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lb];
        
        lb;
    });
    
    
    CGColorRef layerColor = rgb(200, 200, 200).CGColor;
    CALayer *btnTopLayer = [[CALayer alloc] init];
    btnTopLayer.frame = CGRectMake(0, CGRectGetMaxY(self.videoView.frame), SCREEN_WIDTH, 1.f);
    btnTopLayer.backgroundColor = layerColor;
    [self.contentView.layer addSublayer:btnTopLayer];
    
    CALayer *btnMidLayer = [[CALayer alloc] init];
    btnMidLayer.frame = CGRectMake(CGRectGetMaxX(self.collectBtn.frame), CGRectGetMaxY(btnTopLayer.frame), 1, CGRectGetHeight(self.collectBtn.frame));
    btnMidLayer.backgroundColor = layerColor;
    [self.contentView.layer addSublayer:btnMidLayer];
}


/// ======================= 核心代码 =======================///
#pragma mark - Action Methods

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)sender {
    UIGestureRecognizerState state = sender.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"...开始拖拽...");
            _direction = PanDirectionNone;
            // 在此处不能作为拖拽开始，我们需要知道用户的滑动方向后，在判断是否显示 timeLabel
            break;
            
        case UIGestureRecognizerStateChanged: {
            NSLog(@"...拖拽Changed...%@", _isHorizontalPanGesture ? @"水平拖拽" : @"其他");
            CGPoint translatedPoint = [sender translationInView:sender.view];
            PanDirection direction = [self determineCameraDirectionIfNeeded:translatedPoint];
            
            // 水平判定生效
            if (direction == PanDirectionRight || direction == PanDirectionLeft) {
                
                // 保存水平滑动状态
                if (!_isHorizontalPanGesture) {
                    _isHorizontalPanGesture = YES;
                    self.timeLabel.hidden = NO;
                    NSLog(@"开始拖拽");
                }
                
                // 更新拖拽进度
                CGFloat progress = translatedPoint.x / sender.view.bounds.size.width;
                progress = MAX((MIN(progress, 1)), 0);
                CGFloat seekTime = self.totalTime * progress;
                [self updateTimeLabelWithCurrentTime:seekTime];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            CGPoint translatedPoint = [sender translationInView:sender.view];
            if (_direction == PanDirectionRight || _direction == PanDirectionLeft) {
                CGFloat progress = translatedPoint.x / sender.view.bounds.size.width;
                progress = MAX((MIN(progress, 1)), 0);
                CGFloat seekTime = self.totalTime * progress;
                [self updateTimeLabelWithCurrentTime:seekTime];
            }
            [sender setTranslation:CGPointZero inView:sender.view];
            [self reset];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [sender setTranslation:CGPointZero inView:sender.view];
            [self reset];
        }
            
        default:
            break;
    }
}

static const CGFloat panGestureMinimumTranslation = 10.f;
- (PanDirection)determineCameraDirectionIfNeeded:(CGPoint)translation {
    if (_direction != PanDirectionNone) return _direction;
    
    // 当水平方向滑动距离超过最小距离时，才判定生效
    if (fabs(translation.x) > panGestureMinimumTranslation) {
        
        BOOL gestureHorizontal = NO;
        if (translation.y == 0.0) {
            gestureHorizontal = YES;
        } else {
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0);
        }
        if (gestureHorizontal) {
            if (translation.x > 0.0) {
                _direction = PanDirectionRight;
                return PanDirectionRight;
            } else {
                _direction = PanDirectionLeft;
                return PanDirectionLeft;
            }
        }
    }
    // 当垂直方向滑动距离超过最小距离时，才判定生效
    else if (fabs(translation.y) > panGestureMinimumTranslation) {
        
        BOOL gestureVertical = NO;
        if (translation.x == 0.0) {
            gestureVertical = YES;
        } else {
            gestureVertical = (fabs(translation.y / translation.x) > 5.0);
        }
        if (gestureVertical) {
            if (translation.y > 0.0) {
                _direction = PanDirectionDown;
                return PanDirectionDown;
            } else {
                _direction = PanDirectionUp;
                return PanDirectionUp;
            }
        }
    }
    return _direction;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    NSLog(@"%s%@", __FUNCTION__,  _isHorizontalPanGesture ? @"水平拖拽" : @"其他方向");
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        // UIPanGestureRecognizer 上下方向拖拽时，允许其与试听列表 UIScreenEdgePanGestureRecognizer 手势共存
        if (!_isHorizontalPanGesture) {
            return YES;
        }
    }
    
    return NO;
}
/// ======================= 核心代码 =======================///

#pragma mark - Private Methods

- (void)reset {
    self.timeLabel.hidden = YES;
    _isHorizontalPanGesture = NO;
    _direction = PanDirectionNone;
}

- (void)updateTimeLabelWithCurrentTime:(NSInteger)currentTime {
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", [self getFormattingTime:currentTime], [self getFormattingTime:self.totalTime]];
}

- (NSString *)getFormattingTime:(NSInteger)time {
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)(time / 3600), (long)(time / 60 % 60), (long)(time % 60)];
}

+ (CGFloat)heightForVideo {
    return SCREEN_WIDTH / 16.f * 9.f;
}

- (UIButton *)btnWithTitle:(NSString *)title frame:(CGRect)frame {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = UIColor.whiteColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
    return btn;;
}
@end
