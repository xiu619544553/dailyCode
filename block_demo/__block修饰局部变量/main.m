//
//  main.m
//  __block修饰局部变量
//
//  Created by hello on 2021/11/5.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    __block int x = 2;
    
    NSLog(@"x1---%d---%p", x, &x);
    void (^tkBlock)(void) = ^void() {
        x = 3;
        NSLog(@"x2---%d---%p", x, &x);
    };
    
    // 执行block
    tkBlock();
    
    // 打印block返回值
    NSLog(@"x3---%d---%p", x, &x);
    
    /*
     输出日志：
     2021-11-05 11:59:41.994375+0800 block_demo[10535:130866] x1---2---0x7ffeefbff448
     2021-11-05 11:59:41.994889+0800 block_demo[10535:130866] x2---3---0x10060e438
     2021-11-05 11:59:41.995013+0800 block_demo[10535:130866] x3---3---0x10060e438
     
     结论：__block把变量x，从栈存储位置移动到了堆。
     */
    
    return 0;
}
