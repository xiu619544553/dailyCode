//
//  TKLiftTableHeaderView.h
//  dailyCode
//
//  Created by hello on 2020/9/2.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TKLiftTableHeaderActionBlock)(NSUInteger index);

@interface TKLiftTableHeaderView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) TKLiftTableHeaderActionBlock actionBlock;

@end

NS_ASSUME_NONNULL_END
