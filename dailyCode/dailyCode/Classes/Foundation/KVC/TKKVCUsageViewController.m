//
//  TKKVCUsageViewController.m
//  dailyCode
//
//  Created by hello on 2021/7/27.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKKVCUsageViewController.h"
#import "TKKVCPerson.h"

@interface TKKVCUsageViewController ()

@end

@implementation TKKVCUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    /*
     文件：NSKeyValueCoding.h
     分类：NSObject+NSKeyValueCoding
     
     
     NSArray<Model> *models;
     NSArray *questionIds = [models valueForKeyPath:@"question_id"];
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    TKKVCPerson *person1 = [TKKVCPerson new];
//    /*
//     输出日志：
//     2021-07-27 14:09:30.863217+0800 iOSDemo[42505:233305] -[TKKVCPerson setNickName:]
//
//     结论：- (void)setValue:(nullable id)value forKey:(NSString *)key; 底层调用了 setter 方法完成的设置。
//     */
//    [person1 setValue:@"Alex" forKey:@"nickName"];
//
//
//    /*
//     setValue 没有找到 setAge 方法，KVC机制会检查 + (BOOL)accessInstanceVariablesDirectly 返回值。
//        * 默认返回YES，KVC机制会搜索该类里面有没有名为 <key> 的成员变量，无论该变量是在类接口处定义，还是在类实现处定义，也无论用了什么样的修饰访问符，只要存在以 <key> 命名的变量，KVC都会对齐赋值.
//        * 如果重写了该方法且返回了NO，开发者一般不会这么做，那么这一步 KVC 会执行 setValue:forUndefinedKey，抛出异常 NSUnknownKeyException
//
//     2021-07-27 14:15:21.242442+0800 iOSDemo[42985:239964] +[TKKVCPerson accessInstanceVariablesDirectly]
//     2021-07-27 14:15:21.242585+0800 iOSDemo[42985:239964] 10
//     */
//    [person1 setValue:@10 forKey:@"age"];
//    NSLog(@"%ld", [person1 readAge]);
//
//    NSLog(@"person1.nickName = %@", person1.nickName);
    

}

@end
