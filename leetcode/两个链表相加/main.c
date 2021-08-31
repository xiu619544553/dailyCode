//
//  main.c
//  两个链表相加
//
//  Created by hanxiuhui on 2021/8/31.
//

#include <stdio.h>
#include <stdlib.h>




/*
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
 请你将两个数相加，并以相同形式返回一个表示和的链表。
 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 
 示例 1：
 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 
 示例 2：
 输入：l1 = [0], l2 = [0]
 输出：[0]
 
 示例 3：
 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
 
 */

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

typedef struct ListNode* LinkList;


struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2){
    if ((l1 == NULL) && (l2 == NULL)) return NULL;
    
    // 余数、合、值
    int remainder = 0, sum = 0, val = 0;
    
    // 尾结点
    struct ListNode *tailNode1, *tailNode2;

    tailNode1 = l1;
    tailNode2 = l2;
    
    // 新链表
    struct ListNode *newNode = (struct ListNode *)malloc(sizeof(struct ListNode));
    
    // r指向新链表的尾结点
    struct ListNode *r;
    
    int i = 0;
    
    // 遍历
    while (tailNode1 || tailNode2 || (remainder != 0)) {
        
        if (tailNode1) sum += tailNode1->val;
        if (tailNode2) sum += tailNode2->val;
        if (remainder > 0) sum += remainder;
        
        val = sum % 10;
        remainder = sum/10;
        
        if (i == 0) {
            newNode->val = val;
            newNode->next = NULL;
            r = newNode;
        } else {
            // 新结点
            struct ListNode *newRecordNode = (struct ListNode *)malloc(sizeof(struct ListNode));
            newRecordNode->val = val;
            newRecordNode->next = NULL;
            
            r->next = newRecordNode;
            r = newRecordNode;
        }
        
        if (tailNode1) tailNode1 = tailNode1->next;
        if (tailNode2) tailNode2 = tailNode2->next;
        
        ++i;
        sum = 0;
    }
    
    return newNode;
}

void appendNode(struct ListNode *linkList, int n) {
    if (linkList == NULL) return;
    
    struct ListNode *newNode = (struct ListNode *)malloc(sizeof(struct ListNode));
    newNode->val = n;
    newNode->next = NULL;
    
    struct ListNode *tailNode;
    tailNode = linkList;
    
    while ((tailNode->next) != NULL) {
        tailNode = tailNode->next;
    }
    tailNode->next = newNode;
}


// 2.遍历
void traverseLinkList(struct ListNode *L) {
    struct ListNode *p = L;
    while (p) {           // 遍历到尾结点时，条件就会不满足
        printf("%d\n", p->val);
        p = p->next;     // 下一个结点
    }
}

int main(int argc, const char * argv[]) {
    
    printf("result = %d\n", 10%10);
    printf("7/10 = %d\n", 10/10);
    
    
    // [2,4,3]
    struct ListNode *linkList1 = (struct ListNode *)malloc(sizeof(struct ListNode));
    linkList1->val = 2;
    linkList1->next = NULL;
    
    appendNode(linkList1, 4);
    appendNode(linkList1, 3);
//
//    traverseLinkList(linkList1);
    
    
    // [5,6,4]
    struct ListNode *linkList2 = (struct ListNode *)malloc(sizeof(struct ListNode));
    linkList2->val = 5;
    linkList2->next = NULL;
    
    appendNode(linkList2, 6);
    appendNode(linkList2, 4);
    
    
    // [7,0,8]
    printf("输出结果\n");
    struct ListNode *result = addTwoNumbers(linkList1, linkList2);
    traverseLinkList(result);
    
    return 0;
}
