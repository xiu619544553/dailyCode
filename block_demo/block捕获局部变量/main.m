//
//  main.m
//  block捕获局部变量
//
//  Created by hello on 2021/11/5.
//

#import <Foundation/Foundation.h>

// MARK: block访问局部变量.cpp

int main(int argc, const char * argv[]) {
    
    // 声明一个局部变量用于 block的捕获
    int x = 2;
    
    // 声明一个局部变量NSNumber对象用于block捕获
    NSNumber *number = @(3);
    
    
    NSLog(@"x1---%d---%p", x, &x);
    
    // 声明一个名字为bdBlock，无参数，返回值为浮点型的block
    float (^bdBlock)(void) = ^float() {
        return x * number.floatValue;
    };
    
    // 执行block
    float res = bdBlock();
    
    // 打印block返回值
    NSLog(@"res is %.2f", res);
    
    return 0;
}
