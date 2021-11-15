//
//  main.m
//  block_demo
//
//  Created by hello on 2021/11/4.
//

#import <Foundation/Foundation.h>

// 全局block
void (^block0)(void) = ^{
    NSLog(@"Global Block");
};

int main(int argc, const char * argv[]) {
    
//#pragma mark - 全局Block，它的实例存储在全局数据区
//    block0();
//    NSLog(@"%@",[block0 class]); // __NSGlobalBlock__
//
//
//#pragma mark - Block没有截获自动变量，Block的结构体实例还是 __NSGlobalBlock__
//    void (^block1)(void) = ^{
//        NSLog(@"xxx");
//    };
//    block1();
//    NSLog(@"block1.class = %@", [block1 class]); // __NSGlobalBlock__
//
//
//#pragma mark - Block截获自动变量，Block的结构体实例是 __NSMallocBlock__
//    int a = 1;
//    void (^block2)(void) = ^{
//        NSLog(@"%d", a);
//    };
//    block2();
//    NSLog(@"block2.class = %@", [block2 class]); // __NSMallocBlock__
    
    
    // main1.cpp
__block int val = 0;
void (^block)(void) = [^{ ++val; } copy];
++val;
block();
    
    // main2.cpp
    __block int val = 0;
    void (^block)(void) = ^{
        ++val;
    };
    ++val;
    block();
    

    
    
    
    return 0;
}



