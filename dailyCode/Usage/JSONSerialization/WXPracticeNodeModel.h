//
//  WXPracticeNodeModel.h
//  test
//
//  Created by hello on 2020/6/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXPracticeNodeModel : NSObject

/// 练习册层级id
@property (nonatomic, copy) NSString *cate_id;
/// 练习册id
@property (nonatomic, copy) NSString *practice_id;
///  练习册层级的名称
@property (nonatomic, copy) NSString *name;
/// 练习册层级 level2
@property (nonatomic, copy) NSString *type;
/// 当前层级总题目数量
@property (nonatomic, copy) NSString *total_count;
/// 当前层级已经做完的题目数量
@property (nonatomic, copy) NSString *done_count;
/// 当前层级正确的题目数量
@property (nonatomic, copy) NSString *correct_count;
/// 上次做到位置
@property (nonatomic, copy) NSString *is_last_study;
/// 题目类型 1: 纯客观题, 2: 纯主观题, 3: 主客观混合
@property (nonatomic, copy) NSString *question_type;
/// 目录关联的知识点正确率
@property (nonatomic, copy) NSString *kpoint_rate;
/// 目录关联的知识点正确率变化趋势, -1: 下降, 0: 无变化, 1: 上升
@property (nonatomic, copy) NSString *rate_trend;
/// 层级下的子层级
@property (nonatomic, strong) NSArray <WXPracticeNodeModel *> *children;
@end

NS_ASSUME_NONNULL_END
