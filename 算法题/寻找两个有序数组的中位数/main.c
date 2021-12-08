//
//  main.m
//  寻找两个有序数组的中位数
//
//  Created by hello on 2021/12/6.
//  https://leetcode-cn.com/problems/median-of-two-sorted-arrays/solution/xiang-xi-tong-su-de-si-lu-fen-xi-duo-jie-fa-by-w-2/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

// 解法一
double find1MedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size);

// 解法二
double find2MedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size);

int Min(int a, int b);
// 解法三
double find3MedianSortedArrays(int *nums1, int len1, int *nums2, int len2);
int getKth(int *nums1, int start1, int end1, int *nums2, int start2, int end2, int k);


int main(int argc, const char * argv[]) {
    
    int num1[] = {1, 2, 3, 4};
    int num2[] = {10, 11};
    
    int len1 = sizeof(num1) / sizeof(num1[0]);
    int len2 = sizeof(num2) / sizeof(num2[0]);
    
    double result = find1MedianSortedArrays(num1, len1, num2, len2);
    printf("result = %.1f\n", result);
    
    double result2 = find2MedianSortedArrays(num1, len1, num2, len2);
    printf("result2 = %.1f\n", result2);
    
    double result3 = find3MedianSortedArrays(num1, len1, num2, len2);
    printf("result3 = %.1f\n", result3);
    
    
    
    return 0;
}

// MARK: - 解法一
// 解法一：先合并2个数组，然后根据奇数、偶数，返回中位数
// 时间复杂度：遍历全部数组 (m+n)(m+n)
// 空间复杂度：开辟了一个数组，保存合并后的两个数组 O(m+n)
double find1MedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    
    int count = nums1Size + nums2Size;
    if (count <= 0) { // 异常
        return -1;
    }
    
    // 开辟一个新数组
    int temps[count];
    memset(temps, 0, count);
    
    if (nums1Size == 0) {
        if (nums2Size % 2 == 0) {
            return (nums2[nums2Size/2 - 1] + nums2[nums2Size/2]) / 2.0;
        } else {
            return nums2[nums2Size/2];
        }
    }
    
    if (nums2Size == 0) {
        if (nums1Size % 2 == 0) {
            return (nums1[nums1Size/2 - 1] + nums1[nums1Size/2]) / 2.0;;
        } else {
            return nums1[nums1Size/2];
        }
    }
    
    int temp = 0;
    int i = 0, j = 0;
    while (temp != (nums1Size + nums2Size)) {
        
        if (i == nums1Size) {
            while (j != nums2Size) {
                temps[temp++] = nums2[j++];
            }
            break;
        }
        
        if (j == nums2Size) {
            while (i != nums1Size) {
                temps[temp++] = nums1[i++];
            }
            break;
        }
        
        if (nums1[i] < nums2[j]) {
            temps[temp++] = nums1[i++];
        } else {
            temps[temp++] = nums2[j++];
        }
    }
    
    if (temp % 2 == 0) {
        return (temps[temp/2 - 1] + temps[temp/2]) / 2.0;
    } else {
        return temps[temp/2];
    }
}


// MARK: - 解法二
// 时间复杂度依旧是 O(m+n)O(m+n)
// 所以空间复杂度是 O(1）O(1）
double find2MedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    
    int left = -1, right = -1;
    int aStart = 0, bStart = 0;
    int len = nums1Size + nums2Size;
    
    for (int i = 0; i <= len / 2; i ++) {
        left = right;
        
        if (aStart < nums1Size && (bStart >= nums2Size || nums1[aStart] < nums2[bStart])) {
            right = nums1[aStart++];
        } else {
            right = nums2[bStart++];
        }
    }
    
    if (len % 2 == 0) {
        return (left + right) / 2.0;
    } else {
        return right;
    }
}

/// 二分法
/// @param numbers 有序数组
/// @param len 数组长度
/// @param dest 目标值
int binarySerach(int *numbers, int len, int dest) {
    int min = 0;
    int max = len - 1;
    int mid = (min + max) / 2;
    
    while (min <= max) {
        
        if (dest == numbers[mid]) {
            return mid;
        }
        
        if (dest > numbers[mid]) {
            min = mid + 1;
        }
        
        if (dest < numbers[mid]) {
            max = mid - 1;
        }
        
        mid = (min + max) / 2;
    }
    return -1;
}

// MARK: - 解法三
// 时间复杂度：O(log(m+n）
// 空间复杂度：O(1)
double find3MedianSortedArrays(int *nums1, int len1, int *nums2, int len2) {
    
    if ((len1 + len2) % 2 == 0) { // 偶数
        // 数组有偶数个元素时，中位数是中间两个数的和。left就是中间位置左侧元素的下标，right就是中间位置右侧元素的下标。
        int left = (len1 + len2) / 2;
        int right = left + 1;
        return (getKth(nums1, 0, len1 - 1, nums2, 0, len2 - 1, left) + getKth(nums1, 0, len1 - 1, nums2, 0, len2 - 1, right)) * 0.5;
    } else { // 奇数
        return getKth(nums1, 0, len1 - 1, nums2, 0, len2 - 1, (len1 + len2 + 1) / 2);
    }
}

// k 表示第几个数，数组下标是 k - 1
int getKth(int *nums1, int start1, int end1, int *nums2, int start2, int end2, int k) {
    // 本次要操作部分的数组的长度
    int len1 = end1 - start1 + 1;
    int len2 = end2 - start2 + 1;
    
    // 让 len1 的长度小于 len2，这样就能保证如果有数组空了，一定是 len1
    // 如果 len1 > len2，则互换 nums1和nums2的位置，让 nums1变为 nums2，nums2变为nums1，确保 len1 < len2
    // 这行代码的作用在👇一行中起到了作用：数组空了，一定是 len1
    if (len1 > len2) return getKth(nums2, start2, end2, nums1, start1, end1, k);
    
    // 数组1元素已经为空了（数组元素均不符合条件，被排除了）。此时中位数就在数组2中，index = start2 + k - 1;
    // len1=0的前置条件就是 上面👆语句，必须保证 len1 < len2。
    if (len1 == 0) return nums2[start2 + k - 1];
    
    if (k == 1) { // 第一个数
        return Min(nums1[start1], nums2[start2]);
    }
    
    // Min(len1, k / 2) 是为了防止数组越界
    int i = start1 + Min(len1, k / 2) - 1;
    int j = start2 + Min(len2, k / 2) - 1;
    
    // 如果nums1[i] > nums2[j]，表示nums2数组中`j索引及其之前的元素`，逻辑上全部淘汰，即下次从 `j+1``开始。
    // k = k - (j - start2 + 1); 更新 `k` 值，即减去被排除掉的元素。
    if (nums1[i] > nums2[j]) {
        return getKth(nums1, start1, end1, nums2, j + 1, end2, k - (j - start2 + 1));
    } else {
        return getKth(nums1, i + 1, end1, nums2, start2, end2, k - (i - start1 + 1));
    }
}

int Min(int a, int b) {
    return (a > b ? b : a);
}

