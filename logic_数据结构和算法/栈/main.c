//
//  main.m
//  栈
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

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
#define MAXSIZE 10 // 栈容量

typedef int Status;
typedef int DataType;

// 定义栈结构
typedef struct {
    int top; // -1，表示未空栈
    DataType data[MAXSIZE];
}SeqStack;

// 初始化栈
SeqStack* Init_Stack() {
    SeqStack *s = (SeqStack *)malloc(sizeof(SeqStack));
    if (s) {
        s->top = -1;
        return s;
    } else {
        printf("初始化栈失败..\n");
        return NULL;
    }
}

/// 遍历
Status Traverse(SeqStack* s) {
    if (s == NULL || s->top == - 1) {
        printf("空栈...\n");
        return ERROR;
    } else {
        printf("遍历栈中的元素：");
        for (int i = 0; i <= s->top; i ++) {
            printf("%5d", s->data[i]);
        }
        printf("\n");
        return OK;
    }
}

// 置空
Status Clear(SeqStack* s) {
    if (s == NULL) {
        return ERROR;
    } else {
        s->top = -1;
        return OK;
    }
}

// 判空
Status Is_Empty(SeqStack* s) {
    if (s && s->top != -1) {
        return FALSE;
    } else {
        printf("空栈...\n");
        return TRUE;
    }
}

/// 入栈
/// @param s 栈
/// @param data 入栈的数据
Status Push(SeqStack* s, DataType data) {
    // 空栈 或 栈已满
    if (s == NULL) {
        printf("空栈...\n");
        return ERROR;
    } else if (s->top == MAXSIZE - 1) {
        printf("栈已满...\n");
        return ERROR;
    } else {
        s->top ++;
        s->data[s->top] = data;
        return OK;
    }
}

/// 出栈
/// @param s 栈
/// @param data 返回出栈的数据
Status Pop(SeqStack* s, DataType *data) {
    if (s == NULL || s->top == - 1) {
        printf("空栈...\n");
        return ERROR;
    } else {
        *data = s->data[s->top];
        s->top --;
        return OK;
    }
}

// 取栈顶元素
Status Get_Top(SeqStack* s, DataType *top) {
    if (s == NULL || s->top == - 1) {
        printf("空栈...\n");
        return ERROR;
    } else {
        *top = s->data[s->top];
        return OK;
    }
}


int main(int argc, const char * argv[]) {
    printf("栈...\n");
    
    SeqStack* s = Init_Stack();
    
    // 入栈
    for (int i = 0; i < 11; i ++) {
        Push(s, i);
    }
    
    // 遍历
    Traverse(s);
    
    // 出栈
    DataType data;
    Pop(s, &data);
    printf("出栈：%d\n", data);
    
    // 遍历
    Traverse(s);
    
    // 取栈顶
    Get_Top(s, &data);
    printf("取栈顶：%d\n", data);
    
    return 0;
}

