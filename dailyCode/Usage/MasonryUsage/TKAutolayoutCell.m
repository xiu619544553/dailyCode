//
//  TKAutolayoutCell.m
//  test
//
//  Created by hello on 2020/7/22.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKAutolayoutCell.h"
#import <Masonry.h>

@interface TKAutolayoutCell ()

@property (nonatomic, strong) UIView *backShadowView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation TKAutolayoutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews {
    [self.contentView addSubview:self.backShadowView];
    [self.backShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10.0f, 15.0f, 10.f, 15.0f));
    }];
    
    [self.backShadowView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20.0f);
        make.left.mas_equalTo(15.0f);
        make.right.mas_lessThanOrEqualTo(-15.0f);
    }];
    
    [self.backShadowView addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.0f);
        make.left.mas_equalTo(15.0f);
        make.right.mas_lessThanOrEqualTo(-15.0f);
    }];
    
    [self.backShadowView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(15.0f);
        make.left.mas_equalTo(15.0f);
        make.right.mas_lessThanOrEqualTo(-15.0f);
        make.bottom.mas_equalTo(-20.0f);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    DLog(@"layoutSubviews");
    
    // fix bug: iPad Air - iPad12.4.7 - backShadowView 获取不到 frame 问题
//    self.backShadowView.frame = (CGRect){15.f, 10.f, [self.backShadowView systemLayoutSizeFittingSize:CGSizeMake(self.frame.size.width - 30.f, CGFLOAT_MAX)]};
    
    self.backShadowView.frame = CGRectMake(15.f, 10.f, self.frame.size.width - 30.f, self.frame.size.height - 20.f);
    
    DLog(@"\n%@   \n%@", NSStringFromCGSize(self.frame.size), NSStringFromCGSize([self.backShadowView systemLayoutSizeFittingSize:CGSizeMake(self.frame.size.width - 30.f, CGFLOAT_MAX)]));


    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.backShadowView.bounds cornerRadius:8];

    self.backShadowView.layer.masksToBounds = NO;
    self.backShadowView.layer.shadowColor = [UIColor colorWithRed:190.0f / 255.0f green:193.0f / 255.0f blue:205.0f / 255.0f alpha:0.4f].CGColor;
    self.backShadowView.layer.shadowOffset = CGSizeMake(0, 3.0f);
    self.backShadowView.layer.shadowOpacity = 1.f;
    self.backShadowView.layer.shadowRadius = 10.f;
    self.backShadowView.layer.shadowPath = shadowPath.CGPath;
    self.backShadowView.layer.shouldRasterize = YES;
    self.backShadowView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark - Setters

- (void)updateDataWithTitle:(NSString *)title desc:(NSString *)desc info:(NSString *)info {
    
    self.titleLabel.text = title;
    
    self.descriptionLabel.text = @"加急批改  非作文题批改 | 有效期2021/05/24";
    
    self.infoLabel.text = info;
    
    DLog(@"setter");
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Getters

- (UIView *)backShadowView {
    if (!_backShadowView) {
        _backShadowView = [[UIView alloc] initWithFrame:CGRectZero];
        _backShadowView.backgroundColor = [UIColor whiteColor];
        _backShadowView.layer.cornerRadius = 10.0f;
        _backShadowView.clipsToBounds = YES;
    }
    
    return _backShadowView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descriptionLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
    }
    
    return _descriptionLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _infoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
    }
    
    return _infoLabel;
}
@end
