//
//  main.c
//  链表的环的入口结点
//
//  Created by hanxiuhui on 2021/8/31.
//

#include <stdio.h>
#include <stdlib.h>

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


int main(int argc, const char * argv[]) {
    
    
    
    return 0;
}
