//
//  main.c
//  九大经典排序算法
//
//  Created by hello on 2021/12/27.
//

#include <stdio.h>
#include <stdlib.h>

void insertion_sort(int arr[], int length); // 插入排序
int shellSort(int arr[], int n);            // 希尔排序
void mergeSort(int arr[], int left, int right);    // 归并排序


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
//    shellSort(arr, len);
    
    // 归并排序
    mergeSort(arr, 0, len - 1);
    
    
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


#pragma mark - 2、插入排序 -- 希尔排序（shell sort）（缩小增量排序）

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


#pragma mark - 3、归并排序
// 参考：https://zhuanlan.zhihu.com/p/36075856


/// 合并两个有序数组
/// @param arr 全量数组
/// @param left array[left]~array[mid] 为第一组
/// @param mid 中位数
/// @param right array[mid+1]~array[right] 为第二组
void merge(int arr[], int left, int mid, int right) {
    
    int i = left, j = mid + 1; // // i为左边数组的起点, j为右边数组的起点，mid是左侧数组的终点，right是右侧数组的终点
    int k = 0; // k用于指向temp数组当前放到哪个位置
    
    // 开辟临时数组，存放排序后的元素
    int tempLen = (right - left + 1);
    int *temp = (int *)malloc(tempLen * sizeof(int));
    if (temp == NULL) {
        printf("malloc error.\n");
        return;
    }
    
    while (i <= mid && j <= right) { // 将两个有序序列循环比较, 填入数组temp
        if (arr[i] < arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
        }
    }
    
    while (i <= mid) { temp[k++] = arr[i++]; }   // 如果比较完毕, 第一组还有数剩下, 则全部填入temp
    while (j <= right) { temp[k++] = arr[j++]; } // 如果比较完毕, 第二组还有数剩下, 则全部填入temp
    
    for (k = 0, i = left; k < tempLen; k ++, i ++) { // 将排好序的数填回到array数组的对应位置
        arr[i] = temp[k];
    }
    
    // 释放
    free(temp);
}

// 归并排序
// 时间复杂度：O(nlogn)
void mergeSort(int arr[], int left, int right) {
    if (left < right) {
        int mid = (left + right) / 2;
        mergeSort(arr, left, mid);      // 递归归并左边元素
        mergeSort(arr, mid + 1, right); // 递归归并右边元素
        merge(arr, left, mid, right);   // 再将二个有序数列合并
    }
}
