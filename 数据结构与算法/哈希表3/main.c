//
//  main.c
//  哈希表3
//
//  Created by hello on 2021/12/10.
//  https://zhuanlan.zhihu.com/p/141539102

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int Status;

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
#define MAXSIZE 100 //存储空间初始分配量
#define SUCCESS 1
#define UNSUCCESS 0

//定义散列表长为数组的长度
#define HASHSIZE 12
#define NULLKEY -32768

typedef struct {
    //数据元素存储基址，动态分配数组
    int *elem;
    //当前数据元素个数
    int count;
}HashTable;
int m = 0; /* 散列表表长，全局变量 */


#pragma mark - 1、初始化散列表
// 初始化散列表
Status InitHashTable(HashTable *H) {
    
    // ① 设置H.count初始值; 并且开辟m个空间
    m = HASHSIZE;
    H -> count = m;
    H -> elem = (int *)malloc(m * sizeof(int));
    
    // ② 为H.elem[i] 动态数组中的数据置空(-32768)
    for(int i = 0; i < m; i++) {
        H -> elem[i] = NULLKEY;
    }
    
    return OK;
}

#pragma mark - 2.散列函数

// 散列函数
int Hash(int key) {
    // 除留余数法
    return key % m;
}

#pragma mark - 3.插入关键字进散列表

// 插入关键字进散列表
void InsertHash(HashTable *H, int key) {
    // ① 求散列地址
    int addr = Hash(key);
    
    // ② 如果不为空，则冲突
    while (H -> elem[addr] != NULLKEY) {
        // 开放定址法的线性探测
        addr = (addr + 1) % m;
    }
    
    // ③ 直到有空位后插入关键字
    H -> elem[addr] = key;
}

#pragma mark - 4. 散列表查找关键字

// 散列表查找关键字
Status SearchHash(HashTable H,int key,int *addr) {
    // ① 求散列地址
    *addr = Hash(key);
    
    // ② 如果不为空，则冲突
    while(H.elem[*addr] != key) {
        // ③ 开放定址法的线性探测
        *addr = (*addr + 1) % m;
        
        // ④H.elem[*addr] 等于初始值或者循环有回到了原点.则表示关键字不存在;
        if (H.elem[*addr] == NULLKEY || *addr == Hash(key)) {
            // 则说明关键字不存在
            return UNSUCCESS;
        }
    }
    
    return SUCCESS;
}

int main(int argc, const char * argv[]) {
    
    int arr[HASHSIZE] = {12, 67, 56, 16, 25, 37, 22, 29, 15, 47};
    int i, p, key, result;
    
    HashTable H;
    
    // 1.初始化散列表
    InitHashTable(&H);
    // 2.向散列表中插入数据
    for(i = 0; i < m; i ++) {
        InsertHash(&H,arr[i]);
    }
        
    // 3.在散列表查找key=39
    key = 39;
    result = SearchHash(H,key,&p);
    if (result) {
        printf("查找 %d 的地址为：%d \n",key,p);
    } else {
        printf("查找 %d 失败。\n",key);
    }
        
    // 4.将数组中的key,打印出所有在散列表的存储地址
    for(i = 0; i < m; i ++) {
        key = arr[i];
        SearchHash(H, key, &p);
        printf("查找 %d 的地址为：%d \n", key, p);
    }
    
    return 0;
}
