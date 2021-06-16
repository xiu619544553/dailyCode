//
//  TKSectionHeaderViewCeilingView.h
//  dailyCode
//
//  Created by hello on 2021/5/14.
//  Copyright © 2021 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKSectionHeaderViewCeilingView : UITableViewHeaderFooterView

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) UITableView *tableView;

/// 是否设置其吸顶。默认为YES，吸顶。
@property (nonatomic, assign) BOOL isCeiling;

@end

NS_ASSUME_NONNULL_END
