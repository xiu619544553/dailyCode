//
//  TKRunLoopViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/25.
//  Copyright © 2021 TK. All rights reserved.
//  CF源码：https://opensource.apple.com/tarballs/CF/

#import "TKRunLoopViewController.h"

@interface TKRunLoopViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TKRunLoopViewController

void observerCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    switch (activity) {
        case kCFRunLoopEntry: // 即将进入loop
            NSLog(@"kCFRunLoopEntry - 即将进入loop");
            break;
            
        case kCFRunLoopBeforeTimers: // 即将处理timers
            NSLog(@"kCFRunLoopBeforeTimers - 即将处理timers");
            break;
    
        case kCFRunLoopBeforeSources: // 即将处理sources
            NSLog(@"kCFRunLoopBeforeSources - 即将处理sources");
            break;
        
        case kCFRunLoopBeforeWaiting: // 即将休眠
            NSLog(@"kCFRunLoopBeforeWaiting - 即将休眠");
            break;
        
        case kCFRunLoopAfterWaiting: // 从休眠中唤醒
            NSLog(@"kCFRunLoopAfterWaiting - 从休眠中唤醒");
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 方式一
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
//                                                            kCFRunLoopAllActivities,
//                                                            YES,
//                                                            0,
//                                                            observerCallBack,
//                                                            NULL);
//
//    CFRunLoopAddObserver(CFRunLoopGetCurrent(),
//                         observer,
//                         kCFRunLoopCommonModes);
//
//
//    CFRelease(observer);
    
    [self.view addSubview:self.textView];
    
    // 方式二
    CFRunLoopObserverRef observer1 = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(),
                                                                        kCFRunLoopAllActivities,
                                                                        YES,
                                                                        0,
                                                                        ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopEntry -- %@", mode);
            } break;
                
                
            case kCFRunLoopExit: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopExit -- %@", mode);
            } break;
                
                
            default:
                break;
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer1, kCFRunLoopCommonModes);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

#pragma mark - getter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _textView.text = @"ABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefwABCDEFUwfewfewefwewf wefwwefw";
    }
    return _textView;
}
@end
