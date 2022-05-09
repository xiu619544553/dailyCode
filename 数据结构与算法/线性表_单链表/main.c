//
//  main.m
//  线性表_单链表
//
//  Created by hanxiuhui on 2020/4/1.
//  Copyright © 2020 TK. All rights reserved.
//

#include <stdio.h>
#include "stdlib.h"
#include "math.h"
#include "time.h"
#include "string.h"
#include "ctype.h"

/*
 作业
 
 1.C 集合 线性 树形 图形。
 2.C
 3.B
 4.D 数据项是数据最小的单位
 5.A
 6.C 内循环与外循环无关，内循环O(n)，外循环O(log2n（2为底）) --> O(nlog2n)
 7.C
 8.C
 9.B
 10.A
 11.D
 
 二、
 1.O(1)
 2.O(nm)
 3.O(n^2)
 4.O(logn)
 5.O(n^2)
 6.O(根号n)
 
 */

#include <stdio.h>
#include "stdlib.h"
#include "math.h"
#include "time.h"
#include "string.h"
#include "ctype.h"

#define ERROR 0
#define TRUE 1
#define FALSE 0
#define OK 1
#define MAXSIZE 20 // 存储空间初始分配量

typedef int Status;
typedef int ElemType;

// 结点
typedef struct Node {
    ElemType data;     // 数据域，存储当前结点的数据
    struct Node* next; // 指针域，指向下一个结点
}Node;

// 定义单向链表
typedef struct Node* LinkList;

// 1.初始化单向链表
Status initLinkList(LinkList* L) {
    *L = (LinkList)malloc(sizeof(Node)); // 初始化链表（头结点）
    if (*L == NULL) return ERROR;        // 初始化失败
    (*L)->next = NULL;                   // 头结点指针域指向 NULL
    return OK;
}

// 2.遍历
Status traverseLinkList(LinkList L) {
    LinkList p = L->next; // 获取首元结点
    while (p) {           // 遍历到尾结点时，条件就会不满足
        printf("%d\n", p->data);
        p = p->next;     // 下一个结点
    }
    printf("\n");
    return OK;
}

/// 3.在链表某个位置插入一个结点
/// @param L 链表
/// @param et 新结点的数据域
/// @param i 插入的位置
Status insertLinkList(LinkList* L, ElemType et, int i) {
    int j = 1; // 计数
    LinkList temp = *L; // 赋值为头结点。temp用来遍历的辅助变量
    
    while (temp && j < i) {
        temp = temp->next;   // 找到要插入位置结点的前驱结点
        ++j;
    }
    
    if (!temp || j > i) return ERROR;
    
    // 1.初始化新结点
    LinkList newL = (LinkList)malloc(sizeof(Node));
    newL->data = et;
    
    // 2.插入
    newL->next = temp->next; // 新结点的指针域指向被插入位置的结点
    temp->next = newL;       // 被插入位置的前驱结点指向新结点
    
    return OK;
}

/// 4.删除链表某个位置结点
/// @param L 单向链表
/// @param et 被删除的结点数据
/// @param i 指定要删除结点的位置
Status deleteLinkList(LinkList* L, ElemType* et, int i) {
    
    int j = 1; // 辅助变量
    LinkList temp = (*L)->next; // 首元结点
    
    while (temp->next && j < (i - 1)) {
        temp = temp->next;  // 找到要删除结点的前驱结点
        ++j;
    }
    
    if (!(temp->next) || j > i - 1) return ERROR;
    
    LinkList deleteL = temp->next; // 被删除的结点
    temp->next = deleteL->next;    // deleteL 的前驱结点指向deleteL 的后继
    *et = deleteL->data;           // 返回被删除的值
    free(deleteL);                 // 释放被删除的结点
    
    return OK;
}


/// 5.头插法 - 一般不用
/// @param L 单向链表地址
/// @param n 创建新结点的个数
void createListHead(LinkList* L, int n) {
    LinkList p;
    // 创建一个带头结点的单链表
    *L = (LinkList)malloc(sizeof(Node));
    (*L)->next = NULL;
    
    for (int i = 0; i < n; i ++) {
        p = (LinkList)malloc(sizeof(Node)); // 初始化
        p->data = i;          // 赋值
        p->next = (*L)->next; // 新结点指向原首元结点
        (*L)->next = p;       // 新结点作为首元结点
    }
}

// 6.尾插法 - 用的多
void createListTail(LinkList* L, int n) {
    LinkList p, r; // p新结点；r指向尾结点
    // 创建一个带头结点的单链表
    (*L) = (LinkList)malloc(sizeof(Node));
    (*L)->next = NULL;
    
    r = *L; // r初始值就是头结点
    for (int i = 0; i < n; i ++) {
        p = (LinkList)malloc(sizeof(Node));
        p->data = i;
        
        r->next = p; // 插入新结点
        r = p;       // 更新r
    }
    r->next = NULL;  // r的指针域为空
}

int main(int argc, const char * argv[]) {
    
    /*
     LinkList L1;
     struct Node* L2; // 指针变量指向一块 Node 类型的数据
     以上两行是等价的
     */
    
    // 定义变量
//    LinkList L1;
//    struct Node* L2;
//
//    // 初始化
//    L1 = (LinkList)malloc(sizeof(Node));
//    L2 = (LinkList)malloc(sizeof(Node));
//
//    // 赋值
//    L1->data = 1;
//    L2->data = 2;
//
//    printf("%d, %d\n", L1->data, L2->data);
    
    
    LinkList L1;
    Status iStatus;
    ElemType et;
    
    // 1.初始化
    iStatus = initLinkList(&L1);
    printf("初始化状态：%d", iStatus);
    
    // 2.插入
    for (int i = 0; i < 10; i ++) {
        insertLinkList(&L1, i, 1);
    }
    printf("插入后\n");
    traverseLinkList(L1);
    
    // 3.删除
    iStatus = deleteLinkList(&L1, &et, 3);
    printf("删除链表第3个位置值为：%d\n", et);
    traverseLinkList(L1);
    
    // 头插法
    createListHead(&L1, 10);
    printf("前插法：\n");
    traverseLinkList(L1);
    
    // 尾插法
    createListTail(&L1, 10);
    printf("尾插法：\n");
    traverseLinkList(L1);
    
    
    return 0;
}


