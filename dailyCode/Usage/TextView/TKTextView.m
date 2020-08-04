//
//  TKTextView.m
//  dailyCode
//
//  Created by hello on 2020/8/4.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTextView.h"
#import <objc/runtime.h>

@interface TKTextView ()
@property (nonatomic, strong) NSArray *menuSelectors;
@end

@implementation TKTextView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        /*
         自定义 UITextView 选中后的 Menu
         1、继承 UITextView，在 TextView子类的初始化方法中设置 Menu，则 Menu中不会保留系统自带的 item；并且重写自定义的 Menu中的方法
         2、如果想保留系统自带的 items，则需要在控制器中设置 Menu；
         */
        UIMenuItem *peiMenuItem = [[UIMenuItem alloc]initWithTitle:@"更换颜色" action:@selector(changeTextColor:)];
        UIMenuItem *allMenuItem = [[UIMenuItem alloc]initWithTitle:@"改变字体" action:@selector(changeFont:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setMenuItems:@[peiMenuItem, allMenuItem]];
        
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(changeTextColor:)) {
        return YES;
    } else if(action == @selector(changeFont:)) {
        return YES;
    }
    return NO;
}

- (void)changeTextColor:(id)sender {
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attri addAttributes:@{
        NSForegroundColorAttributeName : self.textColor ?: UIColor.blackColor,
        NSFontAttributeName : self.font ?: [UIFont systemFontOfSize:20.f]
    } range:NSMakeRange(0, self.text.length)];
    
    [attri addAttributes:@{
        NSForegroundColorAttributeName : kRandomColor
    } range:self.selectedRange];
    
    self.attributedText = attri;
}

- (void)changeFont:(id)sender {
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attri addAttributes:@{
        NSForegroundColorAttributeName : self.textColor ?: UIColor.blackColor,
        NSFontAttributeName : self.font ?: [UIFont systemFontOfSize:20.f]
    } range:NSMakeRange(0, self.text.length)];
    
    [attri addAttributes:@{
        NSFontAttributeName : kFontForPFMedium((13 + arc4random_uniform(8)))
    } range:self.selectedRange];
    
    
    self.attributedText = attri;
}

//- (void)mycopy:(id)text {
//
//    NSString *string = [self.text substringWithRange:self.selectedRange];
//    if (string.length) {
//        [UIPasteboard generalPasteboard].string = string;
//    }
//}

///*
// 请求接收响应器在用户界面中启用或禁用指定的命令。
//
// 如果响应器类实现了请求的操作，则此方法的默认实现返回YES，如果没有实现，则调用下一个响应器。子类可以重写此方法以基于当前状态启用菜单命令;例如，如果有选择，您可以启用Copy命令;如果剪贴板不包含具有正确的剪贴板表示类型的数据，您可以禁用Paste命令。如果响应器链中没有响应器返回YES，则菜单命令被禁用。注意，如果您的类对一个命令返回NO，则响应链上的另一个响应器可能仍然返回YES，从而启用该命令。
//
// 对于相同的操作，可以多次调用此方法，但每次使用不同的发送方。你应该为任何类型的发送者做好准备，包括nil。
// */
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//
//    if (_allowSelectors && _allowSelectors.count > 0) {
//        return [_allowSelectors containsObject:NSStringFromSelector(action)];
//    }
//
//
//    return NO;
//
////    BOOL flag = [super canPerformAction:action withSender:sender];
////    DLog(@"\nflag: %d \naction: %@   \nsender: %@", flag, NSStringFromSelector(action), sender);
////    return flag;
//}
//
//- (id)targetForAction:(SEL)action withSender:(id)sender {
//
//    id obj = [super targetForAction:action withSender:sender];
//
//    DLog(@"\nobj: %@ \naction: %@   \nsender: %@", obj, NSStringFromSelector(action), sender);
//
//    return obj;
//}

@end
