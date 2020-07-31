//
//  LayoutSubView1.m
//  test
//
//  Created by hello on 2020/7/3.
//  Copyright © 2020 TK. All rights reserved.
//

#import "LayoutSubView1.h"

@implementation LayoutSubView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    DLog(@"...layoutSubviews");
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    DLog(@"...drawRect");
}

@end
