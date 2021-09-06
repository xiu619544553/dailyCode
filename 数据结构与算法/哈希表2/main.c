//
//  main.c
//  哈希表2
//
//  Created by hanxiuhui on 2021/8/12.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct hashtable_entry {
    char* key;
    void* value;
};

struct hashtable {
    unsigned int size;
    unsigned int capacity;
    struct hashtable_entry* body;
};

#define HASHTABLE_INITIAL_CAPACITY 4


void hashtable_resize(struct hashtable* t, unsigned int capacity);
struct hashtable_entry* hashtable_body_allocate(unsigned int capacity);


/**
 * Compute the hash value for the given string.
 * Implements the djb k=33 hash function.
 */
unsigned long hashtable_hash(char* str)
{
    unsigned long hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;  /* hash * 33 + c */
    return hash;
}

/**
 * Find an available slot for the given key, using linear probing.
 */
unsigned int hashtable_find_slot(struct hashtable* t, char* key)
{
    int index = hashtable_hash(key) % t->capacity;
    while (t->body[index].key != NULL && strcmp(t->body[index].key, key) != 0) {
        index = (index + 1) % t->capacity;
    }
    return index;
}

/**
 * Return the item associated with the given key, or NULL if not found.
 */
void* hashtable_get(struct hashtable* t, char* key)
{
    int index = hashtable_find_slot(t, key);
    if (t->body[index].key != NULL) {
        return t->body[index].value;
    } else {
        return NULL;
    }
}

/**
 * Assign a value to the given key in the table.
 */
void hashtable_set(struct hashtable* t, char* key, void* value)
{
    int index = hashtable_find_slot(t, key);
    if (t->body[index].key != NULL) {
        /* Entry exists; update it. */
        t->body[index].value = value;
    } else {
        t->size++;
        /* Create a new  entry */
        if ((float)t->size / t->capacity > 0.8) {
            /* Resize the hash table */
            hashtable_resize(t, t->capacity * 2);
            index = hashtable_find_slot(t, key);
        }
        t->body[index].key = key;
        t->body[index].value = value;
    }
}

/**
 * Remove a key from the table
 */
void hashtable_remove(struct hashtable* t, char* key)
{
    int index = hashtable_find_slot(t, key);
    if (t->body[index].key != NULL) {
        t->body[index].key = NULL;
        t->body[index].value = NULL;
        t->size--;
    }
}

/**
 * Create a new, empty hashtable
 */
struct hashtable* hashtable_create()
{
    struct hashtable* new_ht = malloc(sizeof(struct hashtable));
    new_ht->size = 0;
    new_ht->capacity = HASHTABLE_INITIAL_CAPACITY;
    new_ht->body = hashtable_body_allocate(new_ht->capacity);
    return new_ht;
}

/**
 * Allocate a new memory block with the given capacity.
 */
struct hashtable_entry* hashtable_body_allocate(unsigned int capacity)
{
    // calloc fills the allocated memory with zeroes
    return (struct hashtable_entry*)calloc(capacity, sizeof(struct hashtable_entry));
}

/**
 * Resize the allocated memory.
 */
void hashtable_resize(struct hashtable* t, unsigned int capacity)
{
    if (capacity >= t->size) return;
    
    unsigned int old_capacity = t->capacity;
    struct hashtable_entry* old_body = t->body;
    t->body = hashtable_body_allocate(capacity);
    t->capacity = capacity;

    // Copy all the old values into the newly allocated body
    for (int i = 0; i < old_capacity; i++) {
        if (old_body[i].key != NULL) {
            hashtable_set(t, old_body[i].key, old_body[i].value);
        }
    }
}

/**
 * Destroy the table and deallocate it from memory. This does not deallocate the contained items.
 */
void hashtable_destroy(struct hashtable* t)
{
    free(t->body);
    free(t);
}


int main(int argc, const char * argv[]) {
    
    
    struct hashtable* t = hashtable_create();
    
    hashtable_set(t, "iPhone", "Apple");
    
    return 0;
}
