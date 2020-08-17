//
//  UIButton+TKAdd.m
//  dailyCode
//
//  Created by hello on 2020/8/6.
//  Copyright © 2020 TK. All rights reserved.
//

#import "UIButton+TKAdd.h"
#import <objc/runtime.h>

@implementation UIButton (TKAdd)

@end

@implementation UIButton (TKExpandClickArea)

#pragma mark - setter & getter

static char touchInsetsKey;

- (void)setTouchInsets:(UIEdgeInsets)touchInsets {
    objc_setAssociatedObject(self, &touchInsetsKey, [NSValue valueWithUIEdgeInsets:touchInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)touchInsets {
    NSValue *value = objc_getAssociatedObject(self, &touchInsetsKey);
    if (value) {
        return value.UIEdgeInsetsValue;
    }
    return UIEdgeInsetsZero;
}

#pragma mark - Override Methods

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIEdgeInsets insets = self.touchInsets;
    
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return [super pointInside:point withEvent:event];
    } else {
        CGRect rect = self.bounds;
        rect = CGRectMake(rect.origin.x - insets.left,
                          rect.origin.y - insets.top,
                          rect.size.width + insets.left + insets.right,
                          rect.size.height + insets.top + insets.bottom);
        
        return CGRectContainsPoint(rect, point);
    }
}

@end
