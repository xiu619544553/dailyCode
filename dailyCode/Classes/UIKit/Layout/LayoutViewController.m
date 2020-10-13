//
//  LayoutViewController.m
//  test
//
//  Created by hello on 2020/7/3.
//  Copyright © 2020 TK. All rights reserved.
//

#import "LayoutViewController.h"
#import "LayoutSubView1.h"

@interface LayoutViewController ()
@property (nonatomic, strong) LayoutSubView1 *subV1;
@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.whiteColor;
    

    
    /*
     1、调用 addSubView方法时会触发
        iOS 10.3.1【如果视图调用的 init未设置 frame则不会触发；如果调用的 initWithFrame则会触发】
        iOS 13，只要设置了 frame属性，不论是否为0，都会触发
     2、设置 view 的 frame 时会触发，但是需要 frame发生变化
     3、滚动scrollView会触发（创建的View的父视图时scrollView，并且进行滚动时）
     4、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
     5、init 初始化不会触发 layoutSubviews；initWithFrame 初始化时会触发(frame=CGRectZero也会触发)
     6、直接调用 [self setNeedsLayout]（这个方法不会立即刷新，如果需要立即刷新还需要调用[self layoutIfNeeded]）
     */
    
    // 子视图初始化时调用 init 方法，未设置 frame，则子视图的 layoutSubviews、drawRect 均不会调用
//    _subV1 = [[LayoutSubView1 alloc] initWithFrame:CGRectZero];
//    _subV1.frame = CGRectZero;
    _subV1 = [[LayoutSubView1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _subV1.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:_subV1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [UIView animateWithDuration:0.25 animations:^{
       

        self->_subV1.frame = CGRectMake(100, 100, 100, 100);
        
//        _subV1.frame = CGRectMake(200, 200, 200, 200);
    }];
    
}
@end
