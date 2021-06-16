//
//  TKTestShadowCell.m
//  dailyCode
//
//  Created by hello on 2020/12/11.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTestShadowCell.h"

@interface TKTestShadowCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *testV;

@end

@implementation TKTestShadowCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColor.grayColor;
        
        [self.contentView addSubview:self.testV];
        [self.contentView addSubview:self.nameLabel];
        
        
        NSInteger height = [NSObject getRandomNumberFrom:50 to:300];
        NSInteger width = [NSObject getRandomNumberFrom:(kScreenWidth)/3 to:kScreenWidth - 30.f];
        
        [self.testV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15.f);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.bottom.equalTo(self.contentView).offset(-15.f);
        }];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.testV);
        }];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.testV setCornerByRoundingCorners:UIRectCornerAllCorners cornerRadius:10.f borderColor:UIColor.redColor];
}

#pragma mark - setter

- (void)setName:(NSString *)name {
    _name = name;
    
    _nameLabel.text = name;
}

#pragma mark - getter

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:25.f];
    }
    return _nameLabel;
}

- (UIView *)testV {
    if (!_testV) {
        _testV = [[UIView alloc] init];
        _testV.backgroundColor = UIColor.whiteColor;
    }
    return _testV;
}
@end
