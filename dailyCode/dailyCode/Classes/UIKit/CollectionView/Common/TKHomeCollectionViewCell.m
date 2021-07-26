//
//  TKHomeCollectionViewCell.m
//  dailyCode
//
//  Created by hello on 2020/7/31.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKHomeCollectionViewCell.h"

@interface TKHomeCollectionViewCell ()

@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *customBackgroundView;

@end

@implementation TKHomeCollectionViewCell

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.layer.cornerRadius = 6.f;
        self.contentView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.customBackgroundView];
        [self.contentView addSubview:self.detailLabel];
        
        [_customBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f));
        }];
    }
    return self;
}

#pragma mark - Override Methods

- (void)setHighlighted:(BOOL)highlighted {
    _customBackgroundView.backgroundColor = highlighted ? UIColor.groupTableViewBackgroundColor : UIColor.whiteColor;
}

#pragma mark - setter

- (void)setDetail:(NSString *)detail {
    if (!detail || detail.length == 0) return;
    
    _detail = detail;
    
    _detailLabel.text = detail;
}

#pragma mark - getter

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = kFontForPFMedium(15.f);
    }
    return _detailLabel;
}

- (UIView *)customBackgroundView {
    if (!_customBackgroundView) {
        _customBackgroundView = [UIView new];
        _customBackgroundView.backgroundColor = UIColor.whiteColor;
    }
    return _customBackgroundView;
}
@end
