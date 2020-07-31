//
//  TreeTableViewCell.m
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TreeTableViewCell.h"
#import "NodeModel.h"

#import <Masonry.h>

@interface TreeTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *arrowImgv;
@end

@implementation TreeTableViewCell

#pragma mark - Init Methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.arrowImgv];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15.f);
        }];
        
        [_arrowImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10.f);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - setter

- (void)setNodeModel:(NodeModel *)nodeModel {
    _nodeModel = nodeModel;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ : %@", nodeModel.type, nodeModel.name];
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat leftOffset = 15.f;
        if (nodeModel.level == NodelLevel2) {
            leftOffset += 15.f;
        } else if (nodeModel.level == NodelLevel3) {
            leftOffset += 30.f;
        }
        make.left.equalTo(self.contentView).offset(leftOffset);
    }];
    
    
    if (nodeModel.children && nodeModel.children.count > 0) {
        NSString *imageName = nodeModel.isExpand ? @"up_icon" : @"down_icon";
        _arrowImgv.image = [UIImage imageNamed:imageName];
    } else {
        _arrowImgv.image = nil;
    }
}

#pragma mark - getter

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UIImageView *)arrowImgv {
    if (!_arrowImgv) {
        _arrowImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_icon"]];
        _arrowImgv.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgv;
}
@end
