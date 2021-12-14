//
//  main.c
//  三数之和
//
//  Created by hello on 2021/12/10.
//

#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b);
int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes);

int main(int argc, const char * argv[]) {
    
    
    // 示例
    int nums[] = {-1, 0, 1, 2, -1, -4};
    
    // 二维数组元素个数
    int returnSize = 0;
    
    int columnSize = 0;
    int *prColumn = &columnSize;
    
    // 二维数组
    int **ans = threeSum(nums, sizeof(nums) / sizeof(nums[0]), &returnSize, &prColumn);
//    int **ans = threeSum1(nums, sizeof(nums) / sizeof(nums[0]), &returnSize, &prColumn);
    
    
    // 遍历二维数组
    for (int i = 0; i < returnSize; i ++) {

        int *element = (int *)ans[i];

        for (int j = 0; j < 3; j ++) {
            if (j < 2) {
                printf("%d  ", element[j]);
            } else {
                printf("%d\n", element[j]);
            }

        }
    }

    printf("columnSize = %d\n", columnSize);
    
//    int numsSize = sizeof(nums) / sizeof(nums[0]);
//    qsort(nums, numsSize, sizeof(int), cmp1);
//
//    for (int i = 0; i < numsSize; i ++) {
//        printf("%d\n", nums[i]);
//    }
    
    return 0;
}


#pragma mark -------

int cmp(const void *a, const void *b) {
    // a是 int* 类型的指针变量，* (int *)a 是取值
    return (* (int *)a - * (int *)b);
}

/// 返回一个二维数组。时间复杂度 O(N^2)
/// @param nums 外部要处理的数组
/// @param numsSize nums数组的元素数量
/// @param returnSize 二维数组元素数量
/// @param returnColumnSizes 二维数组中的单个元素是一维数组，该字段表示一维数组的元素数量
int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    
    *returnSize = 0;
    if(numsSize < 3) { return NULL; }
    
    // 快排：给 nums 排序
    qsort(nums, numsSize, sizeof(int), cmp);
    
    // 二维数组：ans是最终的结果
    int basicSize = 8; // 用来扩容的两个参数
    int **ans = (int **)malloc(sizeof(int *) * basicSize);
    (*returnColumnSizes) = (int *)malloc(sizeof(int *) * basicSize);
    
    // target 当前遍历的位置，sum = nums[target] + nums[left] + nums[right];
    int target = 0, sum = 0;
    // left、right是左右指针
    int left = 0, right = 0;
    
    for(target = 0; target < numsSize - 1; target ++) {
        
        // 起始位置大于0，后续元素肯定是大于0的，直接返回 ans
        if(nums[target] > 0) {
            return ans;
        }
        
        // 去重：对 target 去重处理
        if(target > 0 && nums[target] == nums[target - 1]) { continue; }
        
        // 左指针右移，右指针左移
        left = target + 1;
        right = numsSize - 1;
        
        while(left < right) {
            
            sum = nums[left] + nums[right] + nums[target];
            if(sum == 0) { // 成立条件 sum=0
                ans[*returnSize] = (int *)malloc(sizeof(int) * 3); // 二维数组的元素是一维数组，给一维数组分配空间
                (*returnColumnSizes)[*returnSize] = 3;
                ans[*returnSize][0] = nums[target];
                ans[*returnSize][1] = nums[left];
                ans[*returnSize][2] = nums[right];
                
//                printf("==== %d，%d，%d\n", ans[*returnSize][0], ans[*returnSize][1], ans[*returnSize][2]);
                
                // 答案的数组，累加
                (*returnSize) ++;
                
                // 去重：对 left、right 去重处理
                while(left < right && nums[left] == nums[left + 1]) { left ++; }
                while(left < right && nums[right] == nums[right - 1]) { right --; }
                
                if ((*returnSize) == basicSize) { // 扩容
                    basicSize *= 2;
                    ans = (int **)realloc(ans, sizeof(int *) * basicSize);
                    (*returnColumnSizes) = (int *)realloc((*returnColumnSizes), sizeof(int *) * basicSize);
                }
                
                left ++;
                right --;
                
            } else if(sum > 0) { // sum > 0，说明 nums[right] 太大，right 左移
                right --;
            } else { // sum > 0，说明 nums[left] 太小，left 右移
                left ++;
            }
        }
    }
    
    return ans;
}
