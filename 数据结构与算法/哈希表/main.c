//
//  main.c
//  哈希表
//
//  Created by hello on 2021/7/30.
//  参考 https://www.cnblogs.com/tongongV/p/11038578.html
//  哈希表的目的是根据数据的部分内容（关键字），直接计算出存放完整数据的内存地址。
//  为了解决根据关键字快速找到元素存放地址，哈希表应运而生
//  它通过某种算法（哈希函数）直接根据关键字计算出元素的存放地址，无需遍历，效率很高

/*
 先说一下原理。
 先是有一个bucket数组，也就是所谓的桶。

 哈希表的特点就是数据与其在表中的位置存在相关性，也就是有关系的，通过数据应该可以计算出其位置。

 这个哈希表是用于存储一些键值对(key -- value)关系的数据，其key也就是其在表中的索引，value是附带的数据。

 通过散列算法，将字符串的key映射到某个桶中，这个算法是确定的，也就是说一个key必然对应一个bucket。

 然后是碰撞问题，也就是说多个key对应一个索引值。举个例子：有三个key:key1,key3,key5通过散列算法keyToIndex得到的索引值都为2，也就是这三个key产生了碰撞，对于碰撞的处理，采取的是用链表连接起来，而没有进行再散列。
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// MARK: 定义节点数据
struct hashEntry {
    const char *key;
    char *value;
    struct hashEntry* next;
};

// MARK: 定义哈希表
#define BUCKETCOUNT 16
struct hashTable {
    entry bucket[BUCKETCOUNT];
};

// 节点
typedef struct hashEntry entry;
// 哈希表
typedef struct hashTable table;

#define Undefined -1


// MARK: 初始化哈希表
void initHashTable(table *t) {
    if (t == NULL) return;
    
    int i;
    for (i = 0; BUCKETCOUNT; i ++) {
        t->bucket[i].key   = NULL;
        t->bucket[i].value = NULL;
        t->bucket[i].next  = NULL;
    }
}

// MARK: 释放哈希表
void freeHashTable(table* t) {
    if (t == NULL) return;
    
    int i;
    entry *e, *ep;
    for (i = 0; i < BUCKETCOUNT; i ++) {
        
        e = &(t->bucket[i]);
        while (e->next != NULL) {
            ep = e->next;
            e->next = ep->next;
            ep->next = NULL;
            ep->value = NULL;
            ep = NULL;
        }
    }
}

// MARK: 哈希散列算法

// MARK: 哈希散列方法函数
int keyToIndex(const char *key) {
    
    if (key == NULL) return Undefined;
    
    int index, len, i;
    
    // 字符串长度
    len = strlen(key);
    index = (int)key[0];
    
    for (i == 1; i < len; i ++) {
        index *= 1103515245 + (int)key[i];
    }
    
    index >>= 27;
    index &= (BUCKETCOUNT - 1);
    
    return index;
}

int main(int argc, const char * argv[]) {
    
    
    
    
    
    return 0;
}
