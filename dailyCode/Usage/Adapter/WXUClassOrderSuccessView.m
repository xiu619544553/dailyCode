//
//  WXUClassOrderSuccessView.m
//  WXQuestion
//
//  Created by hello on 2020/5/22.
//  Copyright © 2020 中公网校. All rights reserved.
//

#import "WXUClassOrderSuccessView.h"
#import <Masonry.h>

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kImageName(imageName)  [UIImage imageNamed:imageName]

#define kMarginWidth 15
#define KWXWhiteColor [UIColor whiteColor]
#define RGB(r, g, b)           [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]


// 网校粗体
#define kWXWideFont(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]
// 网校普通
#define kWXNormalFont(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]

// 判断是不是5s
#define is5S   (kScreenHeight == 568.0)

// 5s特殊处理
#define kHScaleWidth(x)  (is5S ? (x*320.f/375.f) : x)

#define kOrderScreenHeightScale  (kScreenHeight/667.f)
#define kVerticalHeight(x)       (x * kOrderScreenHeightScale)

@interface WXUClassOrderSuccessView () {
    BOOL _isCorrectionGoods;
}

/// 支付成功icon
@property (nonatomic, strong)UIImageView *successImgView;
/// 支付成功文案
@property (nonatomic, strong)UILabel *successStatusLabel;
/// 查看课程
@property (nonatomic, strong)UIButton *watchCourseBtn;
/// 关注学习助手
@property (nonatomic, strong) UIButton *learningAssistantBtn;

/// 阴影
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *pcDescLabel;
@property (nonatomic, strong) UIView *pcDescBottomDashLine;
@property (nonatomic, strong) UILabel *phoneDescLabel;
@property (nonatomic, strong) UIView *phoneDescBottomDashLine;
@property (nonatomic, strong) UILabel *wxDescLabel;
@property (nonatomic, strong) UIImageView *qrCodeImgV;
@property (nonatomic, strong) UILabel *qrCodeDescLabel;

@end

@implementation WXUClassOrderSuccessView

#pragma mark - Init Methods

- (instancetype)initWithIsCorrectionGoods:(BOOL)isCorrectionGoods {
    self = [super init];
    if (self) {
        
        _isCorrectionGoods = isCorrectionGoods;
        self.backgroundColor = UIColor.grayColor;
        [self prepareUI];
        
        UILongPressGestureRecognizer *longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPGRAction:)];
        longPGR.minimumPressDuration = 0.5;
        [self.qrCodeImgV addGestureRecognizer:longPGR];
    }
    return self;
}

- (void)prepareUI {
    [self addSubview:self.successImgView];
    [self.successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kVerticalHeight(40.f));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(139 * kOrderScreenHeightScale, 94 * kOrderScreenHeightScale));
    }];
    
    // 支付成功
    [self addSubview:self.successStatusLabel];
    [self.successStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successImgView.mas_bottom).offset(kVerticalHeight(15.f));
        make.centerX.mas_equalTo(self.mas_centerX).offset(-5.f);
    }];
    
    // 查看课程
    [self addSubview:self.watchCourseBtn];
    [self.watchCourseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).offset(-7.5);
        make.height.mas_equalTo([self btnHeight]);
        make.width.mas_equalTo([self btnWidth]);
        
        
        
        
        make.top.equalTo(self.successStatusLabel.mas_bottom).offset((kIs_4Inch_Screen || kIs_47Inch_Screen) ? 20.f : 40.f);
//        make.top.equalTo(self.successStatusLabel.mas_bottom).offset(kVerticalHeight(40.f));
        
    }];
    
    // 关注学习助手
    [self addSubview:self.learningAssistantBtn];
    [self.learningAssistantBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.watchCourseBtn.mas_right).offset(15.f);
        make.height.mas_equalTo([self btnHeight]);
        make.width.mas_equalTo([self btnWidth]);
        make.top.equalTo(self.watchCourseBtn);
    }];
    
    // 阴影层
    [self addSubview:self.containerView];
    [self insertSubview:self.shadowView belowSubview:self.containerView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
    
    // 容器视图
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25.f);
        make.right.offset(-25.f);
        make.bottom.offset(-(kVerticalHeight(20)));
        make.top.equalTo(self.watchCourseBtn.mas_bottom).offset(kVerticalHeight(33.f));
    }];
    
    
    
    if (_isCorrectionGoods) {
        // 批改商品
        
        self.phoneDescLabel.text = @"商品已经购买成功，请在【题库APP-我的批改】中学习";
        [self.containerView addSubview:self.phoneDescLabel];
        [self.phoneDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(25.f);
            make.right.equalTo(self.containerView).offset(-25.f);
            make.top.equalTo(self.containerView).offset((kIs_4Inch_Screen || kIs_47Inch_Screen) ? 15.f : 30.f);
        }];
        [self.containerView addSubview:self.phoneDescBottomDashLine];
        [self.phoneDescBottomDashLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.phoneDescBottomDashLine.bounds.size);
            make.top.mas_equalTo(self.phoneDescLabel.mas_bottom).offset(kVerticalHeight(10.f));
            make.centerX.mas_equalTo(self.containerView.mas_centerX);
        }];
        
    } else {
        // 课程商品
        
        self.pcDescLabel.text = @"电脑端：请登录xue.eoffcn.com进行学习";
        [self.containerView addSubview:self.pcDescLabel];
        [self.pcDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(25.f);
            make.right.equalTo(self.containerView).offset(-25.f);
//            make.top.equalTo(self.containerView).offset(kVerticalHeight(30.f));
            make.top.equalTo(self.containerView).offset((kIs_4Inch_Screen || kIs_47Inch_Screen) ? 15.f : 30.f);
        }];
        [self.containerView addSubview:self.pcDescBottomDashLine];
        [self.pcDescBottomDashLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.pcDescBottomDashLine.bounds.size);
            make.top.mas_equalTo(self.pcDescLabel.mas_bottom).offset(kVerticalHeight(10.f));
            make.centerX.mas_equalTo(self.containerView.mas_centerX);
        }];
        
        self.phoneDescLabel.text = @"移动端：请在【题库APP-我的课程】中进行学习";
        [self.containerView addSubview:self.phoneDescLabel];
        [self.phoneDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(25.f);
            make.right.equalTo(self.containerView).offset(-25.f);
            make.top.equalTo(self.pcDescBottomDashLine).offset(kVerticalHeight(10.f));
        }];
        [self.containerView addSubview:self.phoneDescBottomDashLine];
        [self.phoneDescBottomDashLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.phoneDescBottomDashLine.bounds.size);
            make.top.mas_equalTo(self.phoneDescLabel.mas_bottom).offset(kVerticalHeight(10.f));
            make.centerX.mas_equalTo(self.containerView.mas_centerX);
        }];
    }
    
    // 微信描述
    [self.containerView addSubview:self.wxDescLabel];
    [self.wxDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(25.f);
        make.right.equalTo(self.containerView).offset(-25.f);
        make.top.mas_equalTo(self.phoneDescBottomDashLine.mas_bottom).offset(kVerticalHeight(15.f));
    }];
    
    
    // 二维码描述
    [self.containerView addSubview:self.qrCodeDescLabel];
    [self.qrCodeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.containerView).offset(is5S ? (-20) : (-(kVerticalHeight(35.f))));
        
        make.bottom.equalTo(self.containerView).offset((kIs_4Inch_Screen || kIs_47Inch_Screen) ? -10.f : -30.f);
        
        make.centerX.mas_equalTo(self.containerView.mas_centerX);
    }];
    
    // 二维码
    [self.containerView addSubview:self.qrCodeImgV];
    [self.qrCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxDescLabel.mas_bottom).offset((kIs_4Inch_Screen || kIs_47Inch_Screen) ? 10.f : 20.f);
        make.bottom.mas_equalTo(self.qrCodeDescLabel.mas_top).offset(-(kVerticalHeight(10.f)));
        make.width.mas_equalTo(self.qrCodeImgV.mas_height).multipliedBy(1);
        make.centerX.mas_equalTo(self.containerView.mas_centerX);
    }];
}

#pragma mark - Event Methods

// 查看课程
- (void)watchCourseBtnClick {
    if (self.watchCourseBtnClickHandler) {
        self.watchCourseBtnClickHandler();
    }
}

// 关注学习助手
- (void)learningAssistantBtnClick {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:@"中公网校学习助手"];
    
//    [WXProgressHUD showAlertWithMessage:kWXMessageForCopyOffcnLearningAssistantPublicNameText];
}

// 长按保存图片
- (void)longPGRAction:(UILongPressGestureRecognizer *)sender {
    DLog(@"state = %@", @(sender.state));
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIImageWriteToSavedPhotosAlbum(self.qrCodeImgV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
//        [WXProgressHUD showAlertWithMessage:@"保存成功"];
    }
}



#pragma mark - 适配

- (CGFloat)btnWidth {
    return (kScreenWidth - kHScaleWidth(45.f) * 2 - 15.f)/2.f;
}

- (CGFloat)btnHeight {
    if (kIs_4Inch_Screen) {
        return 30.f;
    } else if (kIs_47Inch_Screen) {
        return 35.f;
    } else {
        return 44.f;
    }
}


- (UIFont *)btnFont {
    if (kIs_4Inch_Screen) {
        return kWXWideFont(14.f);
    } else if (kIs_47Inch_Screen) {
        return kWXWideFont(14.f);
    } else {
        return kWXWideFont(17.f);
    }
}

- (CGSize)sizeForwatchCourseBtn {
    
    if (kIs_4Inch_Screen) {
        return CGSizeMake(200, 50.f);
    } else if (kIs_47Inch_Screen) {
        return CGSizeMake(200, 50.f);
    } else {
        return CGSizeMake(200, 50.f);
    }
}

#pragma mark - getter

- (UIImageView *)successImgView {
    if (!_successImgView) {
        _successImgView = [[UIImageView alloc] initWithImage:kImageName(@"wx_pay_success_top")];
        _successImgView.backgroundColor = UIColor.clearColor;
        _successImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _successImgView;
}

- (UILabel *)successStatusLabel {
    if (!_successStatusLabel) {
        _successStatusLabel = [[UILabel alloc] init];
        _successStatusLabel.textColor = UIColor.blackColor;
//        _successStatusLabel.font = kWXWideFont(18);
        

        _successStatusLabel.font = (kIs_4Inch_Screen || kIs_47Inch_Screen) ? kWXWideFont(16.f) : kWXWideFont(18.f);
        
        _successStatusLabel.text = @"支付成功";
        _successStatusLabel.textAlignment = NSTextAlignmentCenter;
        [_successStatusLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_successStatusLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _successStatusLabel;
}

- (UIButton *)watchCourseBtn {
    if (!_watchCourseBtn) {
        _watchCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_watchCourseBtn setTitle:@"查看课程" forState:(UIControlStateNormal)];
        [_watchCourseBtn setTitleColor:KWXWhiteColor forState:UIControlStateNormal];
        _watchCourseBtn.layer.cornerRadius = [self btnHeight]/2.f;
        _watchCourseBtn.titleLabel.font = [self btnFont];
        _watchCourseBtn.layer.masksToBounds = YES;
        [_watchCourseBtn addTarget:self
                            action:@selector(watchCourseBtnClick)
                  forControlEvents:(UIControlEventTouchUpInside)];
        
        // 渐变色层
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, [self btnWidth], [self btnHeight]);
        gradientLayer.colors =
        @[
            (__bridge id)RGB(144, 199, 255).CGColor,
            (__bridge id)RGB(89.f,  150.f, 255).CGColor
        ];
        gradientLayer.locations  = @[@0, @1];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint   = CGPointMake(1, 1);
        [_watchCourseBtn.layer insertSublayer:gradientLayer atIndex:0];
    }
    return _watchCourseBtn;
}

- (UIButton *)learningAssistantBtn {
    if (!_learningAssistantBtn) {
        _learningAssistantBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, kScreenHeight/2+kMarginWidth, 200, 50)];
        [_learningAssistantBtn setTitle:@"关注学习助手" forState:(UIControlStateNormal)];
        [_learningAssistantBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        _learningAssistantBtn.titleLabel.font = [self btnFont];
        _learningAssistantBtn.backgroundColor = UIColor.whiteColor;
        _learningAssistantBtn.layer.cornerRadius = [self btnHeight]/2.f;
        _learningAssistantBtn.layer.masksToBounds = YES;
        _learningAssistantBtn.layer.borderWidth = 0.5;
        _learningAssistantBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        [_learningAssistantBtn addTarget:self
                            action:@selector(learningAssistantBtnClick)
                  forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _learningAssistantBtn;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = UIColor.whiteColor;
        _containerView.layer.cornerRadius = 8.f;
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [UIView new];
        // 必须有背景色。否则shadow不显示。
        _shadowView.backgroundColor = UIColor.whiteColor;
        _shadowView.layer.cornerRadius = 8.f;
//        [_shadowView setCommonShadowWithRadius:8.f];
    }
    return _shadowView;
}

- (UILabel *)pcDescLabel {
    if (!_pcDescLabel) {
        _pcDescLabel = [self fastCreatLabel];
    }
    return _pcDescLabel;
}

- (UIView *)pcDescBottomDashLine {
    if (!_pcDescBottomDashLine) {
        _pcDescBottomDashLine = [UIView new];
        _pcDescBottomDashLine.bounds = CGRectMake(0, 0, kScreenWidth - 25 * 4, 1);
        _pcDescBottomDashLine.backgroundColor = UIColor.whiteColor;
        [self drawLineOfDashByCAShapeLayer:_pcDescBottomDashLine lineLength:2 lineSpacing:1 lineColor:RGB(204, 204, 204) lineDirection:YES];
    }
    return _pcDescBottomDashLine;
}

- (UIView *)phoneDescBottomDashLine {
    if (!_phoneDescBottomDashLine) {
        _phoneDescBottomDashLine = [UIView new];
        _phoneDescBottomDashLine.bounds = CGRectMake(0, 0, kScreenWidth - 25 * 4, 1);
        _phoneDescBottomDashLine.backgroundColor = UIColor.whiteColor;
        [self drawLineOfDashByCAShapeLayer:_phoneDescBottomDashLine lineLength:2 lineSpacing:1 lineColor:RGB(204, 204, 204) lineDirection:YES];
    }
    return _phoneDescBottomDashLine;
}

- (UILabel *)phoneDescLabel {
    if (!_phoneDescLabel) {
        _phoneDescLabel = [self fastCreatLabel];
    }
    return _phoneDescLabel;
}

- (UILabel *)wxDescLabel {
    if (!_wxDescLabel) {
        _wxDescLabel = [self fastCreatLabel];
        _wxDescLabel.text = @"微信关注【中公网校学习助手】\n与客服老师实时互动，一对一解决您的问题";
    }
    return _wxDescLabel;
}

- (UIImageView *)qrCodeImgV {
    if (!_qrCodeImgV) {
        _qrCodeImgV = [[UIImageView alloc] initWithImage:kImageName(@"wx_learning_assistant")];
        _qrCodeImgV.contentMode = UIViewContentModeScaleAspectFit;
        _qrCodeImgV.userInteractionEnabled = YES;
    }
    return _qrCodeImgV;
}

- (UILabel *)qrCodeDescLabel {
    if (!_qrCodeDescLabel) {
        _qrCodeDescLabel = [UILabel new];
        _qrCodeDescLabel.textColor = UIColor.blackColor;
        _qrCodeDescLabel.font = is5S ? kWXNormalFont(10) : kWXNormalFont(12.f);
        _qrCodeDescLabel.text = @"长按二维码保存到本地";
        _qrCodeDescLabel.textAlignment = NSTextAlignmentCenter;
        [_qrCodeDescLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_qrCodeDescLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _qrCodeDescLabel;
}


- (UILabel *)fastCreatLabel {
    UILabel *fastLabel = [UILabel new];
    fastLabel.textColor = UIColor.blackColor;
    fastLabel.textAlignment = NSTextAlignmentCenter;
    fastLabel.numberOfLines = 0;
    fastLabel.font = (kIs_4Inch_Screen || kIs_47Inch_Screen) ? kWXNormalFont(12.f) : kWXNormalFont(14.f);
    
    [fastLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [fastLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    return fastLabel;
}

- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];

    if (isHorizonal) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }

    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor]; // 设置虚线颜色为blackColor
    if (isHorizonal) { // 设置虚线宽度
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [lineView.layer addSublayer:shapeLayer];
}
@end
