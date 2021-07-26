//
//  TKDynamicSpaceSectionHeaderView.m
//  dailyCode
//
//  Created by hello on 2021/7/26.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKDynamicSpaceSectionHeaderView.h"

@interface TKDynamicSpaceSectionHeaderView ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TKDynamicSpaceSectionHeaderView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        self.contentLabel = ({
            UILabel *lb = [UILabel new];
            lb.font = [UIFont boldSystemFontOfSize:20.f];
            lb.textAlignment = NSTextAlignmentCenter;
            [self addSubview:lb];
            
            lb;
        });
    }
    return self;
}

#pragma mark - Override Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentLabel.frame = self.bounds;
}

#pragma mark - setter

- (void)setContent:(NSString *)content {
    _content = content;
    
    _contentLabel.text = content;
}

@end
