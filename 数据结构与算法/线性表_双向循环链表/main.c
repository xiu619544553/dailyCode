//
//  main.m
//  线性表_双向循环链表
//
//  Created by hanxiuhui on 2020/4/3.
//  Copyright © 2020 TK. All rights reserved.
//

#include <stdio.h>
#include "string.h"
#include "ctype.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"

#define ERROR 0
#define TRUE 1
#define FALSE 0
#define OK 1

typedef int Status;
typedef int ElemType;

// 定义结点
typedef struct Node{
    ElemType data;     // 数据域
    struct Node* prior;// 前驱结点
    struct Node* next; // 后继结点
}Node;

typedef struct Node* LinkList;

// 1.初始化双向循环链表
Status initLinkList(LinkList *L) {
    *L = (LinkList)malloc(sizeof(Node));
    if ((*L) == NULL) return ERROR;
    (*L)->next  = *L; // 后继指向自身
    (*L)->prior = *L; // 前驱指向自身
    (*L)->data  = -1;
    
    return OK;
}

// 遍历
void traverseList(LinkList L) {
    LinkList temp = L->next;
    if (temp == NULL) {
        printf("");
        return;
    }
    while (temp != L) {
        printf("%5d", temp->data);
        temp = temp->next;
    }
    printf("\n");
}

// 插入
Status insertList(LinkList *L, ElemType data, int place) {
    if (*L == NULL || place < 1) return ERROR;
    
    LinkList p = (*L);
    int i = 1;
    
    // 找到被插入位置
    while (i < place) {
        p = p->next;
        i++;
    }
    if (i > place) return ERROR;
    
    LinkList temp = (LinkList)malloc(sizeof(Node));
    if (temp == NULL) return ERROR;
    temp->data = data;
    
    temp->prior = p;
    temp->next  = p->next;
    p->next = temp;
    
    // 被插入位置不是尾结点
    if (*L != temp->next) {
        temp->next->prior = temp;
    }
    
    return OK;
}


// 删除
Status deleteList(LinkList *L, ElemType *data, int place) {
    if (*L == NULL || place < 1) return ERROR;
    
    int i = 1;
    LinkList temp = (*L)->next;
    
    // 删除的只剩下头结点了，则释放
    if (temp->next == *L) {
        free(*L);
        return OK;
    }
    
    // 删除其他  A B C。B是被删除的
    while (i < place) {
        
    }
        
    
    return OK;
}


int main(int argc, const char * argv[]) {
    printf("Hello, World!\n");
    
    
    LinkList L;
    initLinkList(&L);
    for (int i = 0; i < 10; i++) {
        insertList(&L, i, 1);
    }
    printf("初始化后添加元素：");
    traverseList(L);
    
    
    
    
    
    
    
    
    return 0;
}

