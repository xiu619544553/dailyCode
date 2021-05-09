//
//  main.m
//  线性表-双向链表
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

/*
 双向链表不建议头插法，建议使用尾插法。
 头插法插入的数据是倒序的。
 */
Status createLinkList(LinkList *L) {
    // 1.创建
    *L = (LinkList)malloc(sizeof(Node));
    if (*L == NULL) return ERROR;
    
    (*L)->prior = NULL;
    (*L)->next = NULL;
    (*L)->data = -1;
    
    // 2.新增结点
    LinkList p = *L;
    for (int i = 0; i < 10; i++) {
    
        LinkList temp = (LinkList)malloc(sizeof(Node));
        if (temp == NULL) return ERROR;
        temp->prior = NULL;
        temp->next  = NULL;
        temp->data = i;
        
        // 建立双向链表关系
        p->next = temp;
        temp->prior = p;
        p->next = temp;
        p = temp; // 尾结点
    }
    
    return OK;
}

// 遍历
void traverseList(LinkList L) {
    LinkList temp = L->next;
    if (temp == NULL) {
        printf("");
        return;
    }
    while (temp) {
        printf("%5d", temp->data);
        temp = temp->next;
    }
    printf("\n");
}

Status insertLinkList(LinkList *L, ElemType et, int place) {
    if (place < 1) return ERROR; // 非法位置
    
    // 1.初始化新结点
    LinkList temp;
    temp = (LinkList)malloc(sizeof(Node));
    if (temp == NULL) return ERROR;
    temp->data  = et;
    temp->prior = NULL;
    temp->next  = NULL;
    
    // 2.找到插入位置的前驱结点
    LinkList p = (*L); // 方便使用
    for (int j = 1; j < place && p; j ++) {
        p = p->next;
    }
    
    // 3.place 越界
    if (p == NULL) return ERROR;
    
    // 4.插入
    if (p->next == NULL) { // 插入的结点在尾指针之后
        
        p->next = temp;
        temp->prior = p;
        
    } else { // 插入的place小于等于链表长度
        p->next->prior = temp; // 被插入
        temp->next = p->next;
        p->next = temp;
        temp->prior = p;
    }
    
    return OK;
}

// 删除
Status deleteLinkList(LinkList *L, ElemType *et, int place) {
    if (*L == NULL || place < 1) return ERROR;
    
    int k = 1;
    LinkList p = (*L);
    
    while (k == place && p != NULL) {
        p = p->next;
        k++;
    }
    
    // 找到删除结点的前驱
    while (k < place && p != NULL) {
        p = p->next;
        k++;
    }
    
    // 越界
    if (k > place || p == NULL) return ERROR;
    
    // 被删除的结点
    LinkList delTemp = p->next;
    *et = delTemp->data;
    
    p->next = delTemp->next;
    
    // 删除结点不是尾结点
    if (delTemp->next != NULL) {
        delTemp->next->prior = p;
    }
    free(delTemp);
    
    return OK;
}

// 删除某个结点
Status deleteEInLinkList(LinkList *L, ElemType data) {
    if (*L == NULL) return ERROR;
    
    LinkList p = (*L)->next; // 从首元结点开始删除
    while (p) {
        if (p->data == data) {
            // 删除一个
            p->prior->next = p->next; // p的前驱结点的指针域 指向 p的后继结点
            if (p->next != NULL) {    // p 不是尾结点
                p->next->prior = p->prior; // p后继结点的前驱结点 指向 p的前驱结点
            }
            free(p);
        }
        p = p->next;
    }
    
    return OK;
}

// 更新某个位置的节点
Status updateLinkList(LinkList *L, ElemType *data, int place) {
    
    
    
    
    return OK;
}


int main(int argc, const char * argv[]) {
    printf("Hello, World!\n");
    
    ElemType data;
    LinkList L;
    
    createLinkList(&L);
    printf("初始化双向链表：");
    traverseList(L);
    
    // 越界插入
    insertLinkList(&L, 4, 90);
    printf("越界插入双向链表：");
    traverseList(L);
    
    // 正常插入
    insertLinkList(&L, 5, 1);
    printf("正常插入双向链表：");
    traverseList(L);
    
    // 删除某个位置结点
    deleteLinkList(&L, &data, 2);
    printf("初删除某个位置结点：");
    traverseList(L);
    
    // 删除指定结点
    deleteEInLinkList(&L, 1);
    printf("删除指定结点：");
    traverseList(L);
    
    return 0;
}
