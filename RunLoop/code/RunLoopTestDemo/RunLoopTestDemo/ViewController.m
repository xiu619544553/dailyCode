//
//  ViewController.m
//  RunLoopTestDemo
//
//  Created by hello on 2021/11/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                                            kCFRunLoopAllActivities,
                                                            YES,
                                                            0,
                                                            &observerCallBack,
                                                            NULL);
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(),
                         observer,
                         kCFRunLoopDefaultMode);
    
    CFRelease(observer);
}

void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"回调");
}

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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
            NSLog(@"定时器");
        }];
    } else {
        // Fallback on earlier versions
    }
}
@end
