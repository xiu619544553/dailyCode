//
//  TKLiftHeaderInSectionView.m
//  dailyCode
//
//  Created by hello on 2020/9/1.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKLiftHeaderInSectionView.h"

@interface TKLiftHeaderInSectionView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TKLiftHeaderInSectionView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.inset(15.f);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

#pragma mark - setter

- (void)setTitle:(NSString *)title {
    
    if (title == nil || title.length == 0) return;
    
    _title = title;
    
    self.titleLabel.text = title;
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLabel;
}
@end
