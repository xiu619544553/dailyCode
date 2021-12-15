//
//  main.c
//  合并两个有序链表
//
//  Created by hello on 2021/12/14.
//

#include <stdio.h>
#include <stdlib.h>

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeTwoLists(struct ListNode* l1, struct ListNode* l2){
    
    struct ListNode *l3 = (struct ListNode *)malloc(sizeof(struct ListNode)); // 创建新的链表l3
    struct ListNode *tail = l3; // l3尾结点
    
    // l1和l2同时存在时，需要遍历对比他们数据域的大小。
    while (l1 && l2 ) {
        
        if (l1->val > l2->val) {
            tail->next = l2;
            l2 = l2->next;     // l2头结点后移
        } else {
            tail->next = l1;
            l1 = l1->next;
        }
        
        tail = tail->next; // l3 尾结点后移
    }
    
    // 当l1或l2只有一个有值，不需要比较他们的数据域，直接指定next
    if (l1) {
        tail->next = l1;
    } else if (l2) {
        tail->next = l2;
    } else {
        tail->next = NULL;
    }
    
    // 返回链表首元结点
    return l3->next;
}



int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    
    
    return 0;
}
