//
//  main.c
//  线性表_顺序存储
//
//  Created by hanxiuhui on 2020/4/1.
//  Copyright © 2020 TK. All rights reserved.
//

#include <stdio.h>
#include "stdlib.h"
#include "math.h"
#include "time.h"

// 线性表 - 顺序存储（逻辑相邻，物理存储相邻）
#define MAXSIZE 100
#define ERROR 0
#define OK 1
#define TRUE 1
#define FALSE 0

typedef int ElemType;
typedef int Status;
typedef int Index;

typedef struct Node {
    ElemType *data; // 数据
    int length;     // 长度
}sqlist;

// 1.初始化 - 为什么用星号 *L --> 因为我们要对它进行修改
Status initList(sqlist *L) {
    // 给 data 分配内存空间
    L->data = malloc(sizeof(ElemType) * MAXSIZE);
    // 容错：内存空间是否开辟成功
    if (!L->data) return ERROR;
    // 初始化数组长度，默认为0
    L->length = 0;
    return OK;
}

/// 2.遍历顺序存储结构中的数据。不需要修改 sqlist，所以不需要传入其地址，传入值即可。
/// @param L 要修改的数组
Status traverseList(sqlist L) {
    if (L.length == 0) return 0;
    int i = 0;
    for (i = 0; i < L.length; i ++) {
        printf("遍历：%d\n", L.data[i]);
    }
    printf("\n");
    return OK;
}

/// 3.插入数据
/// @param L 被插入的数组
/// @param loc 插入的位置
/// @param et 插入的元素
Status insertList(sqlist *L, int loc, ElemType et) {
    // 是否已存在
    // 数组已满
    if (L->length == MAXSIZE) return ERROR;
    // 位置是否合法
    if (loc < 1 || loc > L->length + 1) return ERROR;
    // 插入数据不在表尾，则先移动出空余位置
    if (loc <= L->length) {
        int j;
        for (j = L->length - 1; j >= loc - 1; j --) {
            // 插入位置及之后的位置后移动1位
            L->data[j + 1] = L->data[j];
        }
    }
    
    // 插在表尾：将新元素 et 放入第 loc 个位置
    L->data[loc - 1] = et;
    // 长度+1
    L->length += 1;
    
    return OK;
}

/// 4.删除数据
/// @param L 线性表
/// @param loc 要删除第几个元素
Status deleteList(sqlist *L, int loc) {
    // 线性表为空
    if (L->length == 0) return ERROR;
    
    // loc 不合法判断
    if (loc < 1 || loc > L->length + 1) return ERROR;
    
    for (int j = loc; j < L->length; j ++) {
        // 被删除元素之后的元素向前移动
        L->data[j - 1] = L->data[j];
    }
    
    // 表长度-1
    L->length -= 1;
    return OK;
}


/// 5.查找某个位置的元素
/// @param L 线性表
/// @param loc 要查找第几个元素
ElemType findList(sqlist L, int loc) {
    if (L.length == 0) return ERROR;
    if (loc > L.length) return ERROR;
    return L.data[loc - 1];
}

/// 清空线性表。线性表清空不需要释放内存，只需要将 length 设置为 0
/// @param L 线性表
Status clearList(sqlist *L) {
    L->length = 0;
    return OK;
}

int main(int argc, const char * argv[]) {
    
    
    sqlist L1;
    Status iStatus;
    
    printf("&L1 = %#X\n", &L1); // &L1 = 0XEFBFF400
    
    // 初始化
    iStatus = initList(&L1);
    printf("初始化状态：%d\n", iStatus);
    
    // 插入
    insertList(&L1, 1, 10);
    insertList(&L1, 1, 2);
    insertList(&L1, 1, 5);
    insertList(&L1, 1, 90);
    
    // 遍历
    traverseList(L1);
    
    // 删除
    deleteList(&L1, 2);
    
    printf("--------\n");
    
    // 遍历
    traverseList(L1);
    
    
    printf("第1个元素=%d\n", findList(L1, 1));
    printf("第2个元素=%d\n", findList(L1, 2));
    
    
    
    
    return 0;
}
