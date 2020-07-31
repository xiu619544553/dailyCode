//
//  WXUClassOrderSuccessView.h
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXUClassOrderSuccessView : UIView


- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

/// 初始化方法
/// @param isCorrectionGoods 是否人工批改商品
- (instancetype)initWithIsCorrectionGoods:(BOOL)isCorrectionGoods;

/// 查看课程
@property (nonatomic, copy) void(^watchCourseBtnClickHandler)(void);
@end

NS_ASSUME_NONNULL_END
