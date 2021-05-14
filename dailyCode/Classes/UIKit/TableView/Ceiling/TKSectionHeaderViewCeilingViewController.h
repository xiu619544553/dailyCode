//
//  TKSectionHeaderViewCeilingViewController.h
//  dailyCode
//
//  Created by hello on 2021/5/14.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/*
 
 ① - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 我们称该方法返回的视图为 sectionHeaderView
 ② UITableView.UITableViewStylePlain --> sectionHeaderView 默认是支持吸顶效果
 
 该控制器旨在实现效果：控制 sectionHeaderView 的悬浮
 
 */
@interface TKSectionHeaderViewCeilingViewController : TKBaseViewController

@end

NS_ASSUME_NONNULL_END
