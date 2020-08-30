//
//  UIColor+TKAdd.m
//  dailyCode
//
//  Created by hello on 2020/8/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "UIColor+TKAdd.h"

@implementation UIColor (TKAdd)

- (CGFloat)redValue {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)greenValue {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blueValue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alphaValue {
    return CGColorGetAlpha(self.CGColor);
}

@end
