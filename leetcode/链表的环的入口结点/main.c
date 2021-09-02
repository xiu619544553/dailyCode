//
//  main.c
//  链表的环的入口结点
//
//  Created by hanxiuhui on 2021/8/31.
//

#include <stdio.h>
#include <stdlib.h>

/*
 
 1、如何判断一个链表是不是有环？
 2、如果链表为存在环，如果找到环的入口点？
 
 这个算是一个比较老的题目了，之前就看到过，一般通用的做法就是弄两个指针，一个走得快一点，一个走得慢一点。一般是弄一个走一步，一个走两步。这样如果他们相遇，则说明有环。
 
 那么在有环的基础上，怎么找到这个环的入口呢，一般网上也会给出解释，可能是我的理解力比较底，网上的解释中，总是用移动
 
 了s步，又是长度的，总是弄的我很晕，于是，给出我自己的解释好了，所有的都用移动了多少步来说明。
 
 走一步的指针叫slow，走两步的叫fast。
 
 相遇的时候，slow共移动了s步，fast共移动了2s步，这个是显而易见的。
 
 定义a如下： 链表头移动a步到达入口点。
 定义x如下： 入口点移动x步到达相遇点。
 定义r如下： 从环中的某一点移动r步，又到达的这一点，也就是转了一圈的意思。
 定义t如下： 从相遇点移动到入口点的移动步数
 定义L如下： 从链表头移动L步，又到达了相遇点。也就是遍历完链表之后，通过最后一个节点的指针，又移动到了链表中的某一点。
 
 其中 Ｌ　＝　a + r  =  a + x + t
 
 那么slow和fast相遇了，fast必然比slow多走了n个圈，也就是 n*r 步，那么
 
 s = a + x
 
 2s = s + n*r ， 可得  s = n*r
 
 将s=a+x，带入s =n*r，可得 a+x = n*r, 也就是 a+x = (n-1)*r + r
 
 从表头移动到入口点，再从入口点移动到入口点，也就是移动了整个链表的距离，即是 L =  a + r , 所以r = L - a
 
 所以   a+x = (n-1)*r + L - a ,   于是 a  = (n-1)*r + L - a - x = (n-1)*r + t
 
 也就是说，从表头到入口点的距离，等于从相遇点继续遍历又到表头的距离。
 
 所以，从表头设立一个指针，从相遇点设立一个指针，两个同时移动，必然能够在入口点相遇，这样，就求出了相遇点。
 */

struct ListNode {
    int val;
    struct ListNode *next;
};

#define ERROR 0
#define TRUE 1
#define FALSE 0
typedef int Status;


/// 单链表是否有环
/// @param L 单链表
Status hasCycle(struct ListNode *L) {
    
    // 异常
    if (L == NULL || (L->next) == NULL) return ERROR;
    
    struct ListNode *fast, *slow;
    
    fast = slow = L;
    
    while ((fast != NULL) && (slow != NULL)) {
        fast = L->next->next;
        slow = L->next;
        
        if (fast == slow) {
            return TRUE;
        }
    }
    
    return FALSE;
}

// MARK: 求环的入口
/*
 # 参考
 https://zhuanlan.zhihu.com/p/33663488
 
 
 # 解题思路
 L1 为链表头 head 到环入口的距离
 L2 为从环入口向前到相遇点的距离 (按照指针前进的方向计算)
 L3 为从相遇点向前到环入口的距离 (按照指针前进的方向计算)
 C 为环的周长
 N1 和 N2 分别为 slow 和 fast 在相遇时走过的圈数（向下取整）
 disSlow 和 disFast 分别为 slow 和 fast 在相遇时走过的距离
 
 
 disSlow = L1 + L2 + N1*C;
 disFast = L1 + L2 + N2*C;
 
 # 假设 disFast 是 disSlow 的2倍
 disFast = 2 * disSlow;
 L1 + L2 + N2 * C = 2 * (L1 + L2 + N1 * C);
 L1 = (N2 - 2 * N1) * C - L2;
 L1
 
 
 # Fast 是 Slow的2倍
 N2 >= 2*N1
 
 # 当 N2 == 2*N1 时，该单链表是一个环。
 
 */

int main(int argc, const char * argv[]) {
    
    
    
    return 0;
}


