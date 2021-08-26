//
//  main.c
//  哈希表2
//
//  Created by hanxiuhui on 2021/8/12.
//

#include <stdio.h>
#include <stdlib.h>

struct ListNode;
typedef struct ListNode *Position;

struct HashTbl;
typedef struct HashTbl *HashTable;

typedef char *ElementType;


HashTable initTable(int TableSize);
void destroyTable(HashTable H);
Position find(ElementType Key, HashTable H);
void insert(ElementType Key, HashTable H);
ElementType retrieve(Position P);

struct ListNode {
    ElementType Element;
    Position    Next;
};

typedef Position List;
struct HashTbl {
    int TableSize;
    List *TheLists;
};

#define MinTableSize 1

// 初始化
HashTable initTable(int TableSize) {
    
    if (TableSize < MinTableSize) {
        return NULL;
    }
    
    HashTable H;
    int i;
    
    // allocate table
    H = malloc(sizeof(struct HashTbl));
    
}



int main(int argc, const char * argv[]) {
    
    
    
    return 0;
}
