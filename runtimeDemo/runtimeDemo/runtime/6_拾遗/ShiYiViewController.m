//
//  ShiYiViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/13.
//

#import "ShiYiViewController.h"
#import <objc/runtime.h>

@implementation ShiYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
#pragma mark - 库相关
//    unsigned int outCount;
//
//    NSLog(@"UIView所在的动态库：%s", class_getImageName(UIView.class));
//
//    const char **clses = objc_copyClassNamesForImage(class_getImageName(UIView.class), &outCount);
//    for (int i = 0; i < outCount; i ++) {
//        NSLog(@" 获取指定库或框架中所有类的类名：%s",clses[i]);
//    }
    
    
#pragma mark - 块操作
    
//    // 测试代码
//    IMP imp = imp_implementationWithBlock(^(id obj, NSString *str) {
//        NSLog(@"%@", str);
//    });
//    class_addMethod(MyRuntimeBlock.class, @selector(testBlock:), imp, "v@:@");
//    MyRuntimeBlock *runtime = [[MyRuntimeBlock alloc] init];
//    [runtime performSelector:@selector(testBlock:) withObject:@"hello world!"];

    
}


@end
