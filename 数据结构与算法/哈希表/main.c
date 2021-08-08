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

/*
 关于用到的 C语言函数介绍：
 
 1、char *strdup(const char *__s1);
    * 功能：strdup 在堆上分配足以保存 __s1 的内存，并拷贝 __s1 内容到新分配位置。一般和free（）函数成对出现
 
 2、int strcmp(const char *__s1, const char *__s2);
    * 功能：strcmp函数是 string compare(字符串比较)的缩写，用于比较两个字符串并根据比较结果返回整数。基本形式为 strcmp(str1,str2)，
    若 str1=str2，则返回零；
    若 str1<str2，则返回负数；
    若 str1>str2，则返回正数。
 
 3、void *memcpy(void *__dst, const void *__src, size_t __n);
    * 功能：从源内存地址的起始位置开始拷贝若干个字节到目标内存地址中。即从 __src 中拷贝 __n 个字节到目标 __dst中。
    * 参数
        __dst -- 指向用于存储复制内容的目标数组，类型强制转换为 void* 指针。
        __src -- 指向要复制的数据源，类型强制转换为 void* 指针。
        __n   -- 要被复制的字节数。
    * 返回值
        该函数返回一个指向目标存储区 __dst 的指针。
 
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

typedef struct hashEntry entry;

// MARK: 定义哈希表
#define BUCKETCOUNT 16
struct hashTable {
    entry bucket[BUCKETCOUNT];
};

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
    len = (int)strlen(key);
    
    // 默认值
    index = (int)key[0];
    
    for (i = 1; i < len; i ++) {
        index *= 1103515245 + (int)key[i];
    }
    
    index >>= 27;
    index &= (BUCKETCOUNT - 1);
    
    return index;
}

// MARK: 插入数据

/// 向哈希表中插入数据
/// @param t 哈希表
/// @param key key
/// @param value value
/// @return 插入数据的下标。如果返回值是 -1，则标识插入失败
int insertEntry(table *t, const char *key, char *value) {
    
    if (t == NULL || key == NULL || value == NULL) return Undefined;
    
    int index, vlen1, vlen2;
    entry *e, *ep;
    
    // 通过散列算法，计算 index
    index = keyToIndex(key);
    
    if (t->bucket[index].key == NULL) { // 哈希表中不存在 key，则将 key 和 value 存储进哈希表
        
        // strdup 在堆上分配足以保存str的内存，并拷贝str内容到新分配位置，防止外部通过指针篡改值
        t->bucket[index].key = strdup(key);
        t->bucket[index].value = strdup(value);
        
    } else { // 哈希表中存在 key
        
        e = ep = &(t->bucket[index]);
        
        while (e != NULL) { // 先从已知的开始找
            
            if (strcmp(e->key, key) == 0) { // 找到 key
                
                vlen1 = strlen(value);
                vlen2 = strlen(e->value);
                
                if (vlen1 > vlen2) {
                    e->value = NULL;
                    e->value = (char *)malloc(vlen1 + 1);
                }
                
                memcpy(e->value, value, vlen1 + 1);
                
                return index;
            }
            
            ep = e;
            e = e->next;
        }
        
        // 没有在当前桶中找到
        // 创建条目加入
        e = (entry *)malloc(sizeof(entry));
        e->key = strdup(key);
        e->value = strdup(value);
        e->next = NULL;
        
        ep->next = e;
    }
    
    return index;
}

// 因为这个哈希表中保存的是键值对，所以这个方法是从哈希表中查找key对应的value的。要注意，这里返回的是value的地址，不应该对其指向的数据进行修改，否则可能会有意外发生。
// 找到了则返回 value的地址；没找到则返回 NULL
const char *findValueByKey(const table *t, const char *key) {
    
    if (t == NULL || key == NULL) return NULL;
    
    int index;
    const entry *e;

    index = keyToIndex(key);
    e = &(t->bucket)[index];
    
    // 这个桶没有元素
    if (e->key == NULL) return NULL;
    
    while (e != NULL) {
        if (0 == strcmp(e->key, key)) {
            // 找到
            return e->value;
        }
        // 未找到，则会一直查找，直到找到或者找到尾指针为止
        e = e->next;
    }
    
    return NULL;
}


int main(int argc, const char * argv[]) {
    
    /*
     功 能: 将字符串拷贝到新建的位置处
     strdup()在内部调用了malloc()为变量分配内存，不需要使用返回的字符串时，需要用free()释放相应的内存空间，否则会造成内存泄漏。
     返回一个指针,指向为复制字符串分配的空间;如果分配空间失败,则返回NULL值。
     
     strdup(const char *__s1)
     */
    
    
    
    return 0;
}
