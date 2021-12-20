//
//  main.c
//  删除链表的倒数第 N 个结点
//
//  Created by hello on 2021/12/16.
//

#include <stdio.h>
#include <stdlib.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    
    
    
    return 0;
}



/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

//输入：head = [1,2,3,4,5], n = 2
//输出：[1,2,3,5]

//输入：head = [1], n = 1
//输出：[]

struct ListNode {
    int val;
    struct ListNode *next;
};

// 链表长度
int getLength(struct ListNode *head) {
    int len = 0;
    while (head->next) {
        len ++;
        head = head->next;
    }
    return len;
}

struct ListNode* removeNthFromEnd(struct ListNode* head, int n) {
    
    // 链表长度
    int len = getLength(head);
    
    // 创建新节点，作为头结点
    struct ListNode *temp = malloc(sizeof(struct ListNode));
    temp->val = 0;
    temp->next = head;
    
    // 寻找要被删除结点的前驱结点
    struct ListNode *targetNode = temp;
    for (int i = 0; i < len - n + 1; i ++) {
        targetNode = targetNode->next;
    }
    
    // 修改结点指向
    targetNode->next = targetNode->next->next;
    
    struct ListNode *result = temp->next;
    free(temp);
    
    return result;
}
