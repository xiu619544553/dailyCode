//
//  TKLiftTableViewCell.m
//  dailyCode
//
//  Created by hello on 2020/9/1.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKLiftTableViewCell.h"

@interface TKLiftTableViewCell ()
@property (nonatomic, strong) UIView *randomColorView;
@end

@implementation TKLiftTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.randomColorView];
        [self.randomColorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(10.f, 15.f, 10.f, 15.f));
        }];
        
    }
    return self;
}

#pragma mark - getter

- (UIView *)randomColorView {
    if (!_randomColorView) {
        _randomColorView = [UIView new];
        _randomColorView.layer.cornerRadius = 6.f;
        _randomColorView.backgroundColor = kRandomColor;
    }
    return _randomColorView;
}
@end
