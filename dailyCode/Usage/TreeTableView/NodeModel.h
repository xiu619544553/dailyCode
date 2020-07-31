//
//  NodeModel.h
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NodelLevel) {
    NodelLevelUndefine,
    NodelLevel1,
    NodelLevel2,
    NodelLevel3
};

NS_ASSUME_NONNULL_BEGIN

@interface NodeModel : NSObject

#pragma mark - 手动添加字段
/// 级别
@property (nonatomic, assign) NodelLevel level;
/// 是否展开
@property (nonatomic, assign) BOOL isExpand;

#pragma mark - 服务器返回字段
/// 练习册层级id
@property (nonatomic, copy)NSString *cate_id;
/// 练习册id
@property (nonatomic, copy)NSString *practice_id;
///  练习册层级的名称
@property (nonatomic, copy)NSString *name;
/// 练习册层级 level2  level3  level4
@property (nonatomic, copy)NSString *type;
/// 当前层级总题目数量
@property (nonatomic, copy)NSString *total_count;
/// 当前层级已经做完的题目数量
@property (nonatomic, copy)NSString *done_count;
/// 当前层级正确的题目数量
@property (nonatomic, copy)NSString *correct_count;
/// 上次做到位置
@property (nonatomic, copy)NSString *is_last_study;
/// 题目类型 1: 纯客观题, 2: 纯主观题, 3: 主客观混合
@property (nonatomic, copy)NSString *question_type;
/// 层级下的子层级
@property (nonatomic, strong)NSArray<NodeModel *> *children;
@end

NS_ASSUME_NONNULL_END
