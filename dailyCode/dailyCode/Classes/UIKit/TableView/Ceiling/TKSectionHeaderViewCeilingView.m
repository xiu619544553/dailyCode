//
//  TKSectionHeaderViewCeilingView.m
//  dailyCode
//
//  Created by hello on 2021/5/14.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKSectionHeaderViewCeilingView.h"

@implementation TKSectionHeaderViewCeilingView

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configData];
    }
    return self;
}

#pragma mark - Private Methods

- (void)configData {
    _isCeiling = YES;
    
    self.textLabel.font = kFontForDINBold(20.f);
    self.textLabel.textColor = UIColor.blackColor;
    self.contentView.backgroundColor = UIColor.lightGrayColor;
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame {
    if (_isCeiling) { // 默认支持吸顶
        [super setFrame:frame];
    } else {
        // 关键代码
        // 设置不吸顶，则需要重新设置 viewForHeaderInSection 的 frame，让其跟随 tableView 滑动
        [super setFrame:[self.tableView rectForHeaderInSection:_section]];
    }
}

- (void)setSection:(NSInteger)section {
    _section = section;
    
    self.textLabel.text = [NSString stringWithFormat:@"头视图 - %@", @(section)];
}

@end
