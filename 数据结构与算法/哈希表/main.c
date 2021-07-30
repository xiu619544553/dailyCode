//
//  main.c
//  哈希表
//
//  Created by hello on 2021/7/30.
//  参考 https://www.cnblogs.com/tongongV/p/11038578.html
//  哈希表的目的是根据数据的部分内容（关键字），直接计算出存放完整数据的内存地址。
//  为了解决根据关键字快速找到元素存放地址，哈希表应运而生
//  它通过某种算法（哈希函数）直接根据关键字计算出元素的存放地址，无需遍历，效率很高

#include <stdio.h>

struct hashEntry {
    const char* key;
    char* value;
    struct hashEntry* next;
};

typedef struct hashEntry entry;


#define BUCKETCOUNT 16
struct hashTable {
    entry bucket[BUCKETCOUNT];
};

typedef struct hashTable table;


// 初始化哈希表
void initHashTable(table* t) {
    if (t == NULL) return;
    
    int i;
    for (i = 0; BUCKETCOUNT; i ++) {
        t->bucket[i].key   = NULL;
        t->bucket[i].value = NULL;
        t->bucket[i].next  = NULL;
    }
}

// 释放哈希表
void freeHashTable(table* t) {
    if (t == NULL) return;
    
}

int main(int argc, const char * argv[]) {
    
    
    
    
    
    return 0;
}
