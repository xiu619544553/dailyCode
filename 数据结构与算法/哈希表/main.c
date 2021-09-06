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

#define Undefined -1

// MARK: 定义节点数据
struct HashEntry {
    const char* key;
    char* value;
    struct HashEntry* next;
};
typedef struct HashEntry Entry;


// MARK: 定义哈希表
#define BUCKETCOUNT 16
struct HashTable {
    Entry* bucket;
};
typedef struct HashTable Table;


// MARK: 初始化哈希表
void initHashTable(Table *t) {
    if (t == NULL) return;
    
    t = malloc(sizeof(Entry));
    t->bucket = (Entry *)calloc(BUCKETCOUNT, sizeof(Entry));
    
    for (int i = 0; i < BUCKETCOUNT; i ++) {
        t->bucket[i].key = NULL;
        t->bucket[i].value = NULL;
        t->bucket[i].next = NULL;
    }
}

// MARK: 释放哈希表
void freeHashTable(Table* t) {
    if (t == NULL) return;
    
    free(t->bucket);
    free(t);
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
int insertEntry(Table *t, const char *key, char *value) {
    
    if (t == NULL || key == NULL || value == NULL) return Undefined;
    
    int index, vlen1, vlen2;
    Entry *e, *ep;
    
    // 通过散列算法，计算 index
    index = keyToIndex(key);
    
    if ((t->bucket[index].key) == NULL) { // 哈希表中不存在 key，则将 key 和 value 存储进哈希表
        
        // strdup 在堆上分配足以保存str的内存，并拷贝str内容到新分配位置，防止外部通过指针篡改值
        t->bucket[index].key = strdup(key);
        t->bucket[index].value = strdup(value);
        
    } else { // 哈希表中存在 key
        
        e = ep = &(t->bucket[index]);
        Entry entry = t->bucket[index];
        printf(entry.key);
        
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
        e = (Entry *)malloc(sizeof(Entry));
        e->key = strdup(key);
        e->value = strdup(value);
        e->next = NULL;
        
        ep->next = e;
    }
    
    return index;
}

// 因为这个哈希表中保存的是键值对，所以这个方法是从哈希表中查找key对应的value的。要注意，这里返回的是value的地址，不应该对其指向的数据进行修改，否则可能会有意外发生。
// 找到了则返回 value的地址；没找到则返回 NULL
const char *findValueByKey(const Table *t, const char *key) {
    
    if (t == NULL || key == NULL) return NULL;
    
    int index;
    const Entry *e;
    
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

/// 移除元素
/// @param t 哈希表
/// @param key 关键字
/// @return 这个函数用于将哈希表中key对应的节点移除，如果其不存在，那就返回NULL。如果存在，就返回这个节点的地址。注意，这里并没有释放节点，如果不需要了，应该手动释放它。
Entry *removeEntry(Table *t, char *key) {
    
    if (t == NULL || key == NULL) return NULL;
    
    int index;
    Entry *e;
    Entry *ep; // 查找的时候将 ep 作为返回值
    
    index = findValueByKey(t, key);
    e = &(t->bucket[index]);
    
    while (e != NULL) {
        
        if (0 == strcmp(key, e->key)) {
            
            // 如果要找的元素在桶的第一个
            if (e == (&(t->bucket[index]))) {
                
                ep = e->next; // 把 e->next 的地址赋予指针变量 ep
                if (ep != NULL) { // 如果这个桶元素个数>=2
                    // 交换第一个和第二个，然后移除第二个
                    Entry temp = *e; // 值拷贝
                    *e = *ep; // 相当于链表的头结点已被移除
                    *ep = temp; // 这就是移除下来的链表头结点
                    ep->next = NULL;
                }
                else {
                    // 这个桶只有第一个元素
                    ep = (Entry *)malloc(sizeof(Entry));
                    *ep = *e;
                    e->key = NULL;
                    e->value = NULL;
                    e->next = NULL;
                }
                
            }
            else {
                // 如果不是桶的第一个元素
                // 找到它的前一个
                ep = &(t->bucket[index]);
                while (ep->next != e) {
                    ep = ep->next;
                }
                
                ep->next = e->next;
                e->next = NULL;
                ep = e;
            }
            
            return ep;
            
        }
        else {
            e = e->next;
        }
    }
    
    return NULL;
}

/// 打印哈希表
/// @param t 哈希表。这个函数用于打印哈希表的内容的。
void printTable(Table* t)
{
    int i;
    Entry* e;
    if (t == NULL)return;
    for (i = 0; i<BUCKETCOUNT; ++i) {
        printf("\nbucket[%d]:\n" , i);
        e = &(t->bucket[i]);
        while (e->key != NULL) {
            printf("\t%s\t=\t%s\n" , e->key , e->value);
            if (e->next == NULL)break;
            e = e->next;
        }
    }
}

int main(int argc, const char * argv[]) {
    
    /*
     功 能: 将字符串拷贝到新建的位置处
     strdup()在内部调用了malloc()为变量分配内存，不需要使用返回的字符串时，需要用free()释放相应的内存空间，否则会造成内存泄漏。
     返回一个指针,指向为复制字符串分配的空间;如果分配空间失败,则返回NULL值。
     
     strdup(const char *__s1)
     */
    Table t;
    initHashTable(&t);
    printTable(&t);
    
    
    insertEntry(&t , "电脑型号" , "华硕 X550JK 笔记本电脑");
    insertEntry(&t , "操作系统" , "Windows 8.1 64位 (DirectX 11)");
    insertEntry(&t , "处理器" , "英特尔 Core i7 - 4710HQ @ 2.50GHz 四核");
    insertEntry(&t , "主板" , "华硕 X550JK(英特尔 Haswell)");
    insertEntry(&t , "内存" , "4 GB(Hynix / Hyundai)");
    insertEntry(&t , "主硬盘" , "日立 HGST HTS541010A9E680(1 TB / 5400 转 / 分)");
    insertEntry(&t , "显卡" , "NVIDIA GeForce GTX 850M       (2 GB / 华硕)");
    insertEntry(&t , "显示器" , "奇美 CMN15C4(15.3 英寸)");
    insertEntry(&t , "光驱" , "松下 DVD - RAM UJ8E2 S DVD刻录机");
    insertEntry(&t , "声卡" , "Conexant SmartAudio HD @ 英特尔 Lynx Point 高保真音频");
    insertEntry(&t , "网卡" , "瑞昱 RTL8168 / 8111 / 8112 Gigabit Ethernet Controller / 华硕");
    insertEntry(&t , "主板型号" , "华硕 X550JK");
    insertEntry(&t , "芯片组" , "英特尔 Haswell");
    insertEntry(&t , "BIOS" , "X550JK.301");
    insertEntry(&t , "制造日期" , "06 / 26 / 2014");
    insertEntry(&t , "主人" , "就是我");
    insertEntry(&t , "价格" , "六十张红色毛主席");
    insertEntry(&t , "主硬盘" , "换了个120G的固态");
    
    Entry* e = removeEntry(&t , "主板型号");
    if (e != NULL) {
        puts("找到后要释放");
        free(e->key);
        free(e->value);
        free(e);
        e = NULL;
    }
    
    printTable(&t);
    
    const char* keys[] = { "显示器" , "主人","没有" , "处理器" };
    for (int i = 0; i < 4; ++i) {
        const char* value = findValueByKey(&t , keys[i]);
        if (value != NULL) {
            printf("find %s\t=\t%s\n" ,keys[i], value);
        }
        else {
            printf("not found %s\n",keys[i]);
        }
    }
    
    
    freeHashTable(&t);
    getchar();
    
    
    return 0;
}
