//
//  ResponderChainRootView.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "ResponderChainRootView.h"
#import "CustomBtn.h"

static NSInteger btnTagIncrement = 10000;

@implementation ResponderChainRootView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.systemTealColor;
        
        
        for (int i = 0; i < 5; i ++) {
            CustomBtn *testBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
            testBtn.backgroundColor = UIColor.systemPinkColor;
            testBtn.tag = btnTagIncrement + i;
            [testBtn setTitle:[NSString stringWithFormat:@"index=%@", @(i)] forState:UIControlStateNormal];
            [testBtn addTarget:self action:@selector(testBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:testBtn];
            
            
            CGFloat width = (frame.size.width - 40.f)/3.f;
            CGFloat x = 10 * ((i % 3) + 1) + (i % 3) * width;
            CGFloat y = i/3 * 50.f + (i/3 + 1) * 20 + 100;
            testBtn.frame = CGRectMake(x, y, (frame.size.width - 40.f)/3.f, 50.f);
        }
        
        
    }
    return self;
}

- (void)testBtnAction:(UIButton *)sender {
    DLog(@"btn.tag=%ld", (long)sender.tag);
}

#pragma mark - Override Methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    DLog(@"view=%@", view ? @"view有值" : @"view为空");
    
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL flag = [super pointInside:point withEvent:event];
    
    DLog(@"flag=%@", flag ? @"YES" : @"NO");
    
    return flag;
}
@end
