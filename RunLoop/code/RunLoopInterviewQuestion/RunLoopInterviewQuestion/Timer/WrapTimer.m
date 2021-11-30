//
//  WrapTimer.m
//  fps_demo
//
//  Created by hello on 2021/11/25.
//

#import "WrapTimer.h"

@interface WrapTimer ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WrapTimer

- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval repeats:repeats block:block];
}

- (void)dealloc {
    NSLog(@"释放Timer");
    if (_timer) {
        [_timer invalidate];
    }
}

@end
