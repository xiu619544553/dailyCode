//
//  TKThread.m
//  fps_demo
//
//  Created by hello on 2021/11/26.
//

#import "TKThread.h"

@implementation TKThread

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
}

@end
