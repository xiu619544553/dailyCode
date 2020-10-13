//
//  OptionalViewController.m
//  test
//
//  Created by hello on 2020/6/24.
//  Copyright © 2020 TK. All rights reserved.
//

#import "OptionalViewController.h"

@interface OptionalViewController ()

@end

@implementation OptionalViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NS_OPTIONS";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self recognizeOrientation:UIControlEventTouchDown | UIControlEventTouchDownRepeat];
}

- (void)recognizeOrientation:(UIControlEvents)controlEventType{
    
    if (controlEventType & UIControlEventTouchDown) {
        NSLog(@"UIControlEventTouchDown: %@", @(controlEventType & UIControlEventTouchDown));
    }
    
    if (controlEventType & UIControlEventTouchDownRepeat) {
        NSLog(@"UIControlEventTouchDownRepeat: %@", @(controlEventType & UIControlEventTouchDownRepeat));
    }
    
    if (controlEventType & UIControlEventTouchDragInside) {
        NSLog(@"UIControlEventTouchDragInside");
    }
    
    if (controlEventType & UIControlEventTouchDragOutside) {
        NSLog(@"UIControlEventTouchDragOutside");
    }
    
    if (controlEventType & UIControlEventTouchDragEnter) {
        NSLog(@"UIControlEventTouchDragEnter");
    }
    
    if (controlEventType & UIControlEventTouchDragExit) {
        NSLog(@"UIControlEventTouchDragExit");
    }
    
    if (controlEventType & UIControlEventTouchUpInside) {
        NSLog(@"UIControlEventTouchUpInside");
    }
    
    if (controlEventType & UIControlEventTouchCancel) {
        NSLog(@"UIControlEventTouchCancel");
    }
    
    if (controlEventType & UIControlEventValueChanged) {
        NSLog(@"UIControlEventValueChanged");
    }
    
    if (controlEventType & UIControlEventPrimaryActionTriggered) {
        NSLog(@"UIControlEventPrimaryActionTriggered");
    }
    
    if (controlEventType & UIControlEventEditingDidBegin) {
        NSLog(@"UIControlEventEditingDidBegin");
    }
    
    if (controlEventType & UIControlEventEditingChanged) {
        NSLog(@"UIControlEventEditingChanged");
    }
    
    if (controlEventType & UIControlEventEditingDidEnd) {
        NSLog(@"UIControlEventEditingDidEnd");
    }
    
    if (controlEventType & UIControlEventEditingDidEndOnExit) {
        NSLog(@"UIControlEventEditingDidEndOnExit");
    }
    
}
@end
