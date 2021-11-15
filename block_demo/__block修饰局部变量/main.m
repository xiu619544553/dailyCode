//
//  main.m
//  __block修饰局部变量
//
//  Created by hello on 2021/11/5.
//

#import <Foundation/Foundation.h>

typedef void (^MyBlock)(void);

int main(int argc, const char * argv[]) {
    
    __block int age = 10;
    
    NSLog(@"1---%d---%p", age, &age);
    void (^tkBlock)(void) = ^void() {
        age = 20;
        NSLog(@"2---%d---%p", age, &age);
    };
    
    // 执行block
    tkBlock();
    
    // 打印block返回值
    NSLog(@"3---%d---%p", age, &age);
    
    /*
     输出日志：
     2021-11-15 10:06:31.683336+0800 __block修饰局部变量[14738:85460] 1---10---0x7ffeefbff438
     2021-11-15 10:06:31.684054+0800 __block修饰局部变量[14738:85460] 2---20---0x10076ca98
     2021-11-15 10:06:31.684180+0800 __block修饰局部变量[14738:85460] 3---20---0x10076ca98
     
     结论：变量 age 从栈存储位置移动到了堆。
     */
    
    return 0;
}
