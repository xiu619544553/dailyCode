//
//  ViewController.m
//  TaggedPointer
//
//  Created by hello on 2022/8/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
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

@end
