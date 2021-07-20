//
//  main.m
//  循环队列
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

typedef struct Queue{
    int front;              // 队头指针
    int rear;               // 队尾指针
    ElemType data[MAXSIZE]; // 存储队列元素
}Queue;


// 1、初始化
Status InitQueue(Queue *Q) {
    Q->front = Q->rear = 0;
    return OK;
}

// 2、清空
Status ClearQueue(Queue *Q) {
    Q->front = Q->rear = 0;
    printf("队列已清空\n");
    return OK;
}

// 3、队列长度
int Length(Queue Q) {
//    if (Q.front == Q.rear) {
//        printf("空队列");
//        return 0;
//    } else {
//        if (Q.rear > Q.front) {
//            return Q.rear - Q.front;
//        } else {
//            return MAXSIZE - (Q.front - Q.rear);
//        }
//    }
    return (Q.rear - Q.front + MAXSIZE) % MAXSIZE;
}

// 4、获取对头
Status GetFront(Queue Q, ElemType *e) {
    if (Q.front == Q.rear) {
        printf("空队列\n");
        return ERROR;
    } else {
        *e = Q.data[Q.front];
        return OK;
    }
}

// 5、出队
Status Pop(Queue *Q, ElemType *e) {
    if (Q->front == Q->rear) {
        printf("空队列\n");
        return ERROR;
    } else {
        *e = Q->data[Q->front];  // 返回出队的数据
        Q->front = (Q->front + 1) % MAXSIZE; // 队头指针向后移动，若到最后则转向数组头部0位置
        return OK;
    }
}

// 6、入队
Status Push(Queue *Q, ElemType e) {
    if ((Q->rear + 1) % MAXSIZE == Q->front) {
        printf("队列已满，入队失败\n");
        return ERROR;
    } else {
        Q->data[Q->rear] = e; // 在队尾处插入元素
        Q->rear = (Q->rear + 1) % MAXSIZE; // 队尾指针向后移动，若到最后则转向数组头部0位置
        return OK;
    }
}

// 7、遍历
Status Traverse(Queue Q) {
    if (Q.front == Q.rear) {
        printf("空队列\n");
        return ERROR;
    } else {
        
        int next; // 记录元素的下标
        next = Q.front;
        
        while (next != Q.rear) { // 当元素下标等于队尾时，跳出循环
            printf("%d  ", Q.data[next]);
            next = (next + 1) % MAXSIZE; // 计算元素的下标
        }
        
        return OK;
    }
}

// 8、空队列
Status IsEmpty(Queue Q) {
    return Q.front == Q.rear ? TRUE : FALSE;
}


int main(int argc, const char * argv[]) {
    
    int length;
    Queue Q;
    ElemType e;
    
    // 初始化
    InitQueue(&Q);
    
    // 入队列
    for (int i = 0; i < 10; i ++) {
        Push(&Q, i);
    }
    Traverse(Q);
    
    
    // 获取头
    GetFront(Q, &e);
    printf("获取头元素：%d\n", e);
    
    
    // 队列长度
    length = Length(Q);
    printf("队列长度：%d\n", length);
    
    
    // 出队列
    Pop(&Q, &e);
    printf("出队列元素：%d\n", e);
    Traverse(Q);
    
    
    // 清空
    ClearQueue(&Q);
    Traverse(Q);
    
    
    return 0;
}
