//
//  UIColor+TKAdd.h
//  dailyCode
//
//  Created by hello on 2020/8/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TKAdd)

/// 0-1
@property (nonatomic, assign, readonly) CGFloat redValue;
@property (nonatomic, assign, readonly) CGFloat greenValue;
@property (nonatomic, assign, readonly) CGFloat blueValue;
@property (nonatomic, assign, readonly) CGFloat alphaValue;

@end

NS_ASSUME_NONNULL_END
