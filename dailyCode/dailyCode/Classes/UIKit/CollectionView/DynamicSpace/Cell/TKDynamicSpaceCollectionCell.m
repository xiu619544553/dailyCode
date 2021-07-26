//
//  TKDynamicSpaceCollectionCell.m
//  dailyCode
//
//  Created by hello on 2021/7/21.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKDynamicSpaceCollectionCell.h"

@interface TKDynamicSpaceCollectionCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TKDynamicSpaceCollectionCell

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        self.contentLabel = ({
            UILabel *lb = [UILabel new];
            lb.font = [UIFont systemFontOfSize:16.f];
            lb.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:lb];
            
            lb;
        });
    }
    return self;
}

#pragma mark - Override Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentLabel.frame = self.contentView.bounds;
}

#pragma mark - setter

- (void)setContent:(NSString *)content {
    _content = content;
    
    _contentLabel.text = content;
}

@end
