//
//  main.m
//  链式栈
//
//  Created by hanxiuhui on 2020/4/12.
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
#define MAXSIZE 10 // 栈容量

typedef int Status;
typedef int ElemType;

// 栈里的结点
typedef struct StackNode {
    ElemType data;          // 栈内结点的数据
    struct StackNode *next; // 指向它的前一个结点
}StackNode, *LinkStackNode;

// 链式栈结构
typedef struct {
    LinkStackNode top; // 栈顶指针
    int count;         // 栈内结点数量
}LinkStack;

// 初始化
Status Init_Stack(LinkStack *s) {
    s->top = NULL;
    s->count = 0;
    return OK;
}

// 判空
Status IS_Empty(LinkStack s) {
    return (s.count == 0) ? TRUE : FALSE;
}

// 置空
Status Clear(LinkStack *s) {
    
    if (s->count == 0) {
        return OK;
    } else {
        
        LinkStackNode temp;
        
        while (s->top) {
            temp = s->top;
            s->top = temp->next;
            free(temp);
        }
        s->count = 0;
    }
    
    printf("\n");
    return OK;
}

// 遍历
void Traverse(LinkStack s) {
    if (s.count == 0) return;
    
    LinkStackNode temp;
    temp = s.top;
    
    while (temp) {
        printf("%5d", temp->data);
        temp = temp->next;
    }
    printf("\n");
}

// 返回栈的长度
int Length(LinkStack s) {
    return s.count;
}

/// 入栈
/// @param s 链表栈
/// @param data 数据
Status Push(LinkStack *s, ElemType data) {
    
    // 创建新的结点
    LinkStackNode temp = (LinkStackNode)malloc(sizeof(StackNode));
    if (!temp) {
        printf("初始化新结点失败");
        return ERROR;
    }
    temp->data = data;       // 给新结点数据域赋值
    
    temp->next = s->top;     // 新结点的指针域指向栈顶
    s->top = temp;           // 将新结点作为栈顶
    s->count ++;             // 结点数量加1
    
    return OK;
}


/// 出栈
/// @param s 链表栈
/// @param data 返回出栈的栈顶数据
Status Pop(LinkStack *s, ElemType *data) {
    
    if (s->count == 0) {
        printf("s 为空栈\n");
        return ERROR;
    }
    
    LinkStackNode temp;
    temp = s->top;       // 记录栈顶结点
    s->top = temp->next; // 重置栈顶，指针下移
    s->count --;         // 结点数量减1
    
    *data = temp->data;  // 返回出栈的数据
    free(temp);          // 释放原栈顶结点
    
    return OK;
}

// 获取栈顶元素
Status Top(LinkStack s, ElemType *data) {
    if (s.count == 0) {
        printf("s 为空栈\n");
        return ERROR;
    } else {
        *data = s.top->data;
        return OK;
    }
}

int main(int argc, const char * argv[]) {
    
    LinkStack s;
    ElemType data;
    
    // 初始化
    Init_Stack(&s);
    
    // 入栈
    for (int i = 0; i < 10; i++) {
        Push(&s, i);
    }
    Traverse(s);
    
    
    // 出栈
    Pop(&s, &data);
    printf("出栈元素：%d\n", data);
    
    
    // 获取栈顶元素
    Top(s, &data);
    printf("栈顶元素：%d\n", data);
    
    return 0;
}
