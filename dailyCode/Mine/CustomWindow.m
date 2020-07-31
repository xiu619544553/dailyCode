//
//  CustomWindow.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "CustomWindow.h"

@implementation CustomWindow

#pragma mark - Override Methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    
//    DLog(@"view=%@", view ? @"view有值" : @"view为空");
    
    
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
//    BOOL flag = [super pointInside:point withEvent:event];
//    DLog(@"flag=%@", flag ? @"YES" : @"NO");
    
    return [super pointInside:point withEvent:event];
}

@end
