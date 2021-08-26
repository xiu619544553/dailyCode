//
//  main.c
//  2.1_数组_从已排序数组中删除重复项
//
//  Created by hanxiuhui on 2021/8/25.
//



#include <stdio.h>

// MARK: 2.1.1 从已排序数组中删除重复项
/*
 # 题目
 2.1.1 Remove Duplicates from Sorted Array
 
 Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.
 Do not allocate extra space for another array, you must do this in place with constant memory.
 For example, Given input arrayA = [1,1,2],
 Your function should return length= 2, and A is now [1,2].
 
 
 译:
 从已排序数组中删除重复项
 
 给定一个已排序的数组，在适当的位置删除重复项，使每个元素只出现一次，并返回新的长度。
 不要为另一个数组分配额外的空间，你必须在固定内存的地方这样做。
 例如，给定input arrayA = [1,1,2,]，
 你的函数应该返回length= 2, A现在是[1,2]。
 */
// 时间复杂度 O(n)，空间复杂度O(1)
int removeDuplicates(int *array, int count) {
    
    if (array == NULL) return 0;
    
    // 用于标记当前可能被修改的元素的下标
    int index = 0;
    
    for (int i = 1; i < count; ++i) {
        if (array[index] != array[i]) {
            array[++index] = array[i];
        }
    }
    
    return index + 1;
}


// MARK: 2.1.2 删除已排序数组中重复元素，每个元素最多允许重复2次
int removeDuplicates2(int *array, int count) {
    if (count <= 2) return count;
    
    int index = 2;
    for (int i = 2; i < count; ++i) {
        if (array[i] != array[index - 2]) {
            
            printf("前.index = %d\n", index);
            
            array[index++] = array[i];
            
            printf("后.index = %d\n", index);
        }
    }
    
    return index;
}


int main(int argc, const char * argv[]) {
    
    
    // 删除已排序数组重复项
    int arrayA[] = {1, 1, 2, 2, 3, 3};
    int oldCount = sizeof(arrayA)/sizeof(arrayA[0]);
    int newCount = removeDuplicates(arrayA, oldCount);
    
    printf("数组元素个数：%d\n", newCount);
    for (int i = 0; i < newCount; ++i) {
        printf("元素：%d\n", arrayA[i]);
    }
    
    
    
    
    // 删除已排序数组中重复元素，每个元素最多允许重复2次
    int arrayB[] = {1, 1, 1, 2, 2, 3};
    int bOldCount = sizeof(arrayB)/sizeof(arrayB[0]);
    int bNewCount = removeDuplicates2(arrayB, bOldCount);
    printf("数组元素个数：%d\n", bNewCount);
    for (int i = 0; i < bNewCount; ++i) {
        printf("b.array.element = %d\n", arrayB[i]);
    }
    
    
    
    return 0;
}

