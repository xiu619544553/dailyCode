//
//  ViewController.m
//  TaggedPointer
//
//  Created by hello on 2022/8/10.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __FUNCTION__);
    
//    [self test1];
    
//    [self test2];
    
//    [self test3];
    
    [self test4];
    
//    [self test5];
}

// 对象的内存
- (void)test1 {
    __weak NSNumber *weakNumber;
    __weak NSString *weakString;
    __weak NSDate *weakDate;
    __weak NSObject *weakObj;
    int num = 123;

    @autoreleasepool {
        weakObj = [[NSObject alloc] init];
        weakNumber = [NSNumber numberWithInt:num];
        weakString = [NSString stringWithFormat:@"string%d", num];
        weakDate   = [NSDate dateWithTimeIntervalSince1970:0];
    }
    NSLog(@"weakObj is %@", weakObj);
    NSLog(@"weakNumber is %@", weakNumber);
    NSLog(@"weakString is %@", weakString);
    NSLog(@"weakDate is %@", weakDate);
}

- (void)test2 {
    NSNumber *number1 = @1;                          //0xb000000000000012
    NSNumber *number2 = @2;                          //0xb000000000000022
    NSNumber *number3 = @(0xFFFFFFFFFFFFFFF);        //0x1c0022560
    NSNumber *number4 = @(1.2);                      //0x1c0024b80
    int num4 = 5;
    NSNumber *number5 = @(num4);                     //0xb000000000000052
    long num5 = 6;
    NSNumber *number6 = @(num5);                     //0xb000000000000063
    float num6 = 7;
    NSNumber *number7 = @(num6);                     //0xb000000000000074
    double num7 = 8;
    NSNumber *number8 = @(num7);                     //0xb000000000000085

    //值：0xb000000000000012 0xb000000000000022 0x1c0022560 0x1c0024b80 0xb000000000000052 0xb000000000000063 0xb000000000000074 0xb000000000000085
        NSLog(@"%p %p %p %p %p %p %p %p", number1, number2, number3, number4, number5, number6, number7, number8);
}

- (void)test3 {
    
    NSString *str1 = @"a";                                          // 0x1049cc248
    NSString *str2 = [NSString stringWithFormat:@"a"];              // 0xa000000000000611
    NSString *str3 = [NSString stringWithFormat:@"bccd"];           // 0xa000000646363624
    NSString *str4 = [NSString stringWithFormat:@"c"];              // 0xa000000000000631
    NSString *str5 = [NSString stringWithFormat:@"cdasjkfsdljfiwejdsjdlajfl"]; // 0x1c02418f0
    NSLog(@"%@ %@ %@ %@ %@",
          [str1 class],   // __NSCFConstantString
          [str2 class],   // NSTaggedPointerString
          [str3 class],   // NSTaggedPointerString
          [str4 class],   // NSTaggedPointerString
          [str5 class]);  // __NSCFString
}

- (void)test4 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i<1000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abcdefghijk"];
        });
    }
}

- (void)test5 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i<1000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }
}
@end
