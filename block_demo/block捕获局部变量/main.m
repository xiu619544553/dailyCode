//
//  main.m
//  block捕获局部变量
//
//  Created by hello on 2021/11/5.
//

#import <Foundation/Foundation.h>

// MARK: block访问局部变量.cpp

typedef void (^MyBlock)(void);

int main(int argc, const char * argv[]) {
    
    int age = 10;
    MyBlock block = ^{
        NSLog(@"age = %d", age);
    };
    age = 18;
    block();
    
    return 0;
}
