//
//  main.m
//  线性表-单向循环链表
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


#define ERROR 0
#define TRUE 1
#define FALSE 0
#define OK 1
#define MAXSIZE 20 // 存储空间初始分配量

typedef int Status;   // Status是函数的类型,其值是函数结果状态代码
typedef int ElemType; // ElemType类型根据实际情况而定，这里假设为int
typedef int ElemPlace;// 元素位置

// 定义结点
typedef struct Node {
    ElemType data;     // 数据域
    struct Node* next; // 指针域
}Node;

// 定义单向循环链表
typedef struct Node* LinkList;


/*
 单向循环链表创建，2种情况
    1、第一次创建：新结点，新结点 next->自己
    2、已经创建，新增数据，要找到尾结点，尾结点指针域指向新结点，新结点指针域首元结点
 */
Status createList(LinkList* L) {
    int input;
    LinkList temp = NULL;   // 新结点
    LinkList target = NULL; // 原尾结点
    printf("输入结点，输入 0 结束\n");
    
    while (1) {
        
        scanf("%d", &input);   // 输出链表要保存的数据
        if (input == 0) break; // 输入0，退出
        
        if (*L == NULL) { // 空表
            
            *L = (LinkList)malloc(sizeof(Node)); // 初始化单向循环链表
            if (*L == NULL) return ERROR;        // 是否初始化成功
            (*L)->data = input;
            (*L)->next = (*L);
            
        } else { // 不是空表
            
            // 遍历链表，找尾结点
            for (target = (*L); target->next != (*L); target = target->next);
            
            temp = (LinkList)malloc(sizeof(Node)); // 创建新结点
            if (temp == NULL) return ERROR;        // 是否初始化成功
            temp->data = input; // 新结点赋值
            temp->next = (*L);  // 新结点指针域指向首元结点，新结点将作为尾结点
            
            target->next = temp; // 原尾结点的指针域指向新的尾结点
        }
    }
    
    return OK;
}

Status createList2(LinkList *L) {
    int input;
    LinkList r_tail = NULL; // 记录尾结点
    LinkList temp = NULL;   // 新结点
    printf("输入结点，输入 0 结束\n");
    
    while (1) {
        scanf("%d", &input);   // 输出链表要保存的数据
        if (input == 0) break; // 输入0，退出

        if (*L == NULL) { // 空表
            *L = (LinkList)malloc(sizeof(Node)); // 初始化单向循环链表
            if (*L == NULL) return ERROR;        // 是否初始化成功
            (*L)->data = input;
            (*L)->next = (*L);
            r_tail = (*L);
        } else {
            temp = (LinkList)malloc(sizeof(Node)); // 创建新结点
            if (temp == NULL) return ERROR;        // 是否初始化成功

            temp->data = input; // 新结点赋值
            temp->next = (*L);  // 新结点指针域指向首元结点

            r_tail->next = temp;// 原尾结点指针域指向新尾结点
            r_tail = temp;      // 记录尾结点
        }
    }

    return OK;
}

// 遍历单向循环链表
void traverseLinkList(LinkList L) {
    if (L == NULL) return;
    
    LinkList temp;
    temp = L;
    do {
        printf("%5d", temp->data);
        temp = temp->next;
    } while (temp != L); // 退出条件：再次找到回到首元结点就退出
    printf("\n");
}

/*
 插入
 情况1：插入位置在首元结点
 情况2：插入位置在其他位置
 */
Status insertLinkList(LinkList *L, ElemType et, int place) {
    LinkList temp, target;
    
    if (*L == NULL) return ERROR;
    
    if (place == 1) { // 插入位置为1，则属于首元结点
        
        temp = (LinkList)malloc(sizeof(Node)); // 创建新结点
        if (temp == NULL) return ERROR;
        temp->data = et;
        
        // 遍历，获取尾结点
        for (target = *L; target->next != *L; target = target->next);
        
        temp->next = *L; // 新结点的指针域指向原来的首元结点
        target->next = temp; // 尾结点的指针域指向插入的结点
        *L = temp; // 指定新结点作为新的首元结点
        
    } else { // 插入位置在非首元结点
        
        int i; // 记录遍历的次数
        
        temp = (LinkList)malloc(sizeof(Node)); // 创建新结点
        if (temp == NULL) return ERROR;
        temp->data = et;
        
        // 找到被插入位置的前驱结点
        for (i = 1, target = *L;
             target->next != *L && i != place - 1;
             target = target->next, i++);
        
        temp->next = target->next; // 新结点的指针域指向被插入位置的原结点
        target->next = temp;       // 被插入位置的原结点的前驱结点指向新结点
    }
    
    return OK;
}

// 删除
Status deleteLinkList(LinkList* L, ElemType* data, int place) {
    if (*L == NULL || place < 1) return ERROR;
    
    int i;
    LinkList temp, target;
    
    if (place == 1) { // 删除首元结点
        
        // 找尾结点
        for (target = *L; target->next != *L; target = target->next);
        
        temp = *L;         // 保存首元结点，最后释放
        *L = (*L)->next;   // 更新首元结点
        target->next = *L; // 更新尾结点的指针域
        
    } else { // 删除其他位置的节点
        
        // 找到被插入位置的前驱结点
        for (i = 1, target = *L; target->next != *L && i != place - 1; i++) {
            target = target->next;
        }
        printf("%d、 %d\n", i, target->data);
        
        if (target->next == *L && i != place) {
            printf("第 %d 位置不存在结点", place);
            return ERROR;
        }
        
        temp = target->next;       // 要被删除的结点
        target->next = temp->next; // 更新删除结点的前驱结点的指针域
    }

    *data = temp->data; // 被删除的数据
    free(temp);         // 释放删除结点的内存
    
    return OK;
}

// 单向循环查询某个值
ElemPlace findValue(LinkList L, ElemType value) {
    ElemPlace i = 1;
    
    LinkList temp;
    temp = L;
    while (temp->data != value && temp->next != L) {
        temp = temp->next;
        i++;
    }
    
    if (temp->data != value) {
        return -1; // 未找到
    }
    
    return i;
}

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
   
    int num;
    int place;
    int status;
    LinkList L1;
    
    createList(&L1);
    printf("原始的链表：\n");
    traverseLinkList(L1);
    
    printf("输入要插入的数据和位置，用空格隔开：");
    scanf("%d %d", &num, &place);
    status = insertLinkList(&L1, num, place);
    printf("插入状态：%d\n", status);
    traverseLinkList(L1);

    printf("输入要插入的数据和位置，用空格隔开：");
    scanf("%d %d", &num, &place);
    status = insertLinkList(&L1, num, place);
    printf("插入状态：%d\n", status);
    traverseLinkList(L1);

    printf("输入要插入的数据和位置，用空格隔开：");
    scanf("%d %d", &num, &place);
    status = insertLinkList(&L1, num, place);
    printf("插入状态：%d\n", status);
    traverseLinkList(L1);
     
    printf("输入要删除的位置：");
    scanf("%d", &place);
    status = deleteLinkList(&L1, &num, place);
    printf("删除状态：%d; 被删除的数据为：%d\n", status, num);
    traverseLinkList(L1);

    printf("输入要删除的位置：");
    scanf("%d", &place);
    status = deleteLinkList(&L1, &num, place);
    printf("删除状态：%d; 被删除的数据为：%d\n", status, num);
    traverseLinkList(L1);

    printf("输入要删除的位置：");
    scanf("%d", &place);
    status = deleteLinkList(&L1, &num, place);
    printf("删除状态：%d; 被删除的数据为：%d\n", status, num);
    traverseLinkList(L1);
    
    
    printf("输入你要查找的值：");
    scanf("%d", &num);
    place = findValue(L1, num);
    printf("查找值的位置：%d\n", place);
    
    
    printf("输入你要查找的值：");
    scanf("%d", &num);
    place = findValue(L1, num);
    printf("查找值的位置：%d\n", place);
}




