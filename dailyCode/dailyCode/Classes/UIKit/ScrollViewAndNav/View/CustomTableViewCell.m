//
//  CustomTableViewCell.m
//  test
//
//  Created by hello on 2020/5/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "MSWeakTimer.h"
#import <Masonry.h>

@interface CustomTableViewCell ()
@property (nonatomic, strong) UIImageView *skuImgV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation CustomTableViewCell

#pragma mark - Event Methods

- (void)testBtnAction:(UIButton *)sender {
    NSLog(@"%s", __func__);
}


#pragma mark - Init Methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _skuImgV = [[UIImageView alloc] init];
        _skuImgV.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self.contentView addSubview:_skuImgV];
        [_skuImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(15.f);
            make.size.sizeOffset(CGSizeMake(150.f, 100.f));
        }];
        
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.skuImgV.mas_right).offset(10.f);
            make.right.offset(-10.f);
            make.top.equalTo(self.skuImgV);
        }];
        
        _tagLabel = [UILabel new];
        _tagLabel.layer.cornerRadius = 4.f;
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.borderColor = UIColor.blueColor.CGColor;
        _tagLabel.layer.borderWidth = 1.f;
        _tagLabel.numberOfLines = 0;
        [self.contentView addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10.f);
        }];
        
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testBtn setTitle:@"UIButton" forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(testBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _testBtn.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_testBtn];
        [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagLabel.mas_bottom).offset(20);
            make.left.offset(10.f);
            make.size.sizeOffset(CGSizeMake(200.f, 50.f));
        }];
        
        _countLabel = [UILabel new];
        _countLabel.numberOfLines = 0;
        [self.contentView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-20.f);
            make.bottom.equalTo(self.testBtn.mas_bottom);
            make.right.offset(-15.f);
        }];
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColor.blackColor;
        [self.contentView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(5.f);
        }];
    }
    return self;
}

- (void)setName:(NSString *)name
            tag:(NSString *)tag
          count:(NSString *)count {
    self.nameLabel.text = name;
    self.tagLabel.text  = tag;
    self.countLabel.text = count;
}

@end
