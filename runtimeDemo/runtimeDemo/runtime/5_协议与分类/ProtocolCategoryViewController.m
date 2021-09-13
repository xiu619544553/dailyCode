//
//  ProtocolCategoryViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/13.
//

#import "ProtocolCategoryViewController.h"
#import "RuntimeCategoryClass.h"
#import "RuntimeCategoryClass+Category.h"
#import <objc/runtime.h>

@interface ProtocolCategoryViewController ()

@end

@implementation ProtocolCategoryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
#pragma mark - 测试objc_class中的方法列表是否包含分类中的方法
    
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(RuntimeCategoryClass.class, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        const char *name = sel_getName(method_getName(method));
        NSLog(@"RuntimeCategoryClass's method: %s", name);
        
        if (strcmp(name, sel_getName(@selector(method2)))) {
            NSLog(@"分类方法method2在objc_class的方法列表中");
        }
    }
}

@end
