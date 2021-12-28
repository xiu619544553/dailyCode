//
//  main.c
//  九大经典排序算法
//
//  Created by hello on 2021/12/27.
//

#include <stdio.h>

void insertion_sort(int arr[], int length); // 插入排序

int shellSort(int arr[], int n);


void test1(char *p) {
    p = "b";
}

void test2(void) {
    char *str = "a";
    test1(str);
    
    printf("str = %s\n", str);
}

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    test2();
    
    
    int arr[] = {49,38,65,97,76,13,27,49,55,04};
    int len = sizeof(arr) / sizeof(int);
    
    // 插入排序
//    insertion_sort(arr, len);
    
    // 希尔排序
    shellSort(arr, len);
    
    
    
    for (int i = 0; i < len; i ++) {
        printf("arr[%d] = %d\n", i, arr[i]);
    }
    
    return 0;
}


#pragma mark - 1、插入排序 -- 直接插入排序

// 时间复杂度 O(n^2)
void insertion_sort(int arr[], int length) {
    
    int i = 0, j = 0, tmp = 0;
    
    for (i = 1; i < length; i ++) {
        
        tmp = arr[i];
        
        for (j = i; arr[j - 1] > tmp && j > 0; j --) {
            
            arr[j] = arr[j - 1];
        }
        
        arr[j] = tmp;
        
    }
}


#pragma mark - 2、插入排序 -- 希尔排序（shell sort）（缩小增量排序）   {49,38,65,97,76,13,27,49,55,04};

int shellSort(int arr[], int n) {
    
    for (int gap = n/2; gap > 0; gap /= 2) {
        
        printf("gap=%d\n", gap);
        
        for (int i = gap; i < n; i += 1) {
            
            int temp = arr[i];
            int j;
            
            printf("a[%d]=%d\n", i, temp);
            
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap) {
                arr[j] = arr[j - gap];
            }
                
            arr[j] = temp;
        }
    }
    return 0;
}
