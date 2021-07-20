//
//  main.m
//  链式循环队列
//
//  Created by hanxiuhui on 2020/4/13.
//  Copyright © 2020 TK. All rights reserved.
//

#include <stdio.h>
#include "string.h"
#include "ctype.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"

#define OK 1
#define ERROR 0
#define FALSE 0
#define TRUE 1
#define MAXSIZE 10

typedef int Status;
typedef int ElemType;

typedef struct QueueNode{
    ElemType data;
    struct QueueNode *next;
}QueueNode, *QueueNodePtr;

// 队列链表结构
typedef struct {
    QueueNodePtr front; // 对头
    QueueNodePtr rear;  // 队尾
}LinkQueue;

// 初始化
Status InitQueue(LinkQueue *Q) {
    // 创建头结点
    Q->front = Q->rear = (QueueNodePtr)malloc(sizeof(QueueNode));
    if (!Q->front) return ERROR;
    Q->front->next = NULL; // 头结点的指针域指向空
    return OK;
}

// 销毁队列 - 头结点也要清空
Status DestoryQueue(LinkQueue *Q) {
    if (!Q->front->next) return ERROR; // 空队列

    QueueNodePtr temp;
    while (Q->front->next) {
        temp = Q->front->next;
        Q->front->next = temp->next;
        free(temp);
    }
    free(Q->front);
    return OK;
}

// 清空
Status Clear(LinkQueue *Q) {
    
    if (!Q->front->next) return ERROR; // 空队列

    QueueNodePtr temp;
    while (Q->front->next) {
        temp = Q->front->next;
        Q->front->next = temp->next;
        free(temp);
    }
    
    return OK;
}

// 长度
Status Length(LinkQueue Q, int *length) {
    if (Q.front == Q.rear) {
        printf("空队列\n");
        return ERROR;
    }
    
    int len = 1;
    QueueNodePtr temp;
    temp = Q.front->next;
    while (temp) {
        temp = temp->next;
        len ++;
    }
    *length = len;
    
    return OK;
}

// 判空
Status IsEmpty(LinkQueue Q) {
    return (Q.front == Q.rear) ? TRUE : FALSE;
}

// 入队
Status Push(LinkQueue *Q, ElemType e) {
    QueueNodePtr temp = (QueueNodePtr)malloc(sizeof(QueueNode));
    if (!temp) return ERROR;
    temp->data = e;
    temp->next = NULL;
    
    Q->rear->next = temp; // 原尾结点指针域指向插入的数据
    Q->rear = temp; // 更新尾结点
    
    return OK;
}

// 出队
Status Pop(LinkQueue *Q, ElemType *E) {
    if (Q->front == Q->rear) return ERROR;
    
    QueueNodePtr temp;
    temp = Q->front->next; // 记录出队结点
    *E = temp->data;
    
    Q->front->next = temp->next; // 重置首元结点
    if (Q->rear == temp) {
        Q->rear = Q->front;
    }
    free(temp);
    
    return OK;
}


// 头
Status GetHead(LinkQueue Q, ElemType *E) {
    if (Q.front == Q.rear) {
        printf("空队列\n");
        return ERROR;
    }
    *E = Q.front->next->data;
    return OK;
}


// 遍历
Status Traverse(LinkQueue Q) {
    if (Q.front == Q.rear) {
        printf("空队列\n");
        return ERROR;
    }
    
    QueueNodePtr temp;
    temp = Q.front->next;
    while (temp) {
        printf("%d  ", temp->data);
        temp = temp->next;
    }
    printf("\n");
    
    return OK;
}



int main(int argc, const char * argv[]) {
    
    int len;
    LinkQueue Q;
    ElemType E;
    
    // 初始化
    InitQueue(&Q);
    
    // 入队
    for (int i = 0; i < 10; i ++) {
        Push(&Q, i);
    }
    Traverse(Q);
    
    
    // 出队
    Pop(&Q, &E);
    printf("出队: %d\n", E);
    Traverse(Q);
    
    
    // 长度
    Length(Q, &len);
    printf("长度: %d\n", len);
    
    
    // 清除
    Clear(&Q);
    Traverse(Q);
    
    
    // 销毁
    
    
    return 0;
}
