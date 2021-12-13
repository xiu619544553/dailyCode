//
//  main.c
//  三数之和
//
//  Created by hello on 2021/12/10.
//

#include <stdio.h>
#include <stdlib.h>

int sum(int *nums, int len, int dest);

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    
//    int dest = 12;
//    int nums[] = {5, 3, 4, 2, 6};
//    int result = sum(nums, sizeof(nums) / sizeof(nums[0]), dest);
//    printf("result = %d\n", result);
    
    return 0;
}

// 暴力破解
// 时间复杂度：O(n*n*n)
int sum(int *nums, int len, int dest) {
    
    for (int i = 0; i < len; i ++) {
        
        for (int j = i + 1; j < len; j ++) {
            
            for (int k = j + 1; k < len; k ++) {
                
                if (nums[i] + nums[j] + nums[k] == dest) {
                    printf("i=%d，j=%d，k=%d\n", i, j, k);
                    return 1;
                }
            }
        }
    }
    
    
    return -1;
}


/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int cmp(const void *a,const void *b){
    return *(int*)a - *(int*)b;
}

// 返回一个二维数组，count 是 returnSize
int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    
    *returnSize = 0;
    if(numsSize < 3)
        return NULL;
    
    qsort(nums, numsSize, sizeof(int), cmp);
    
    int **ans = (int **)malloc(sizeof(int *) * numsSize * numsSize);
    *returnColumnSizes = (int *)malloc(sizeof(int) * numsSize * numsSize);
    
    int i,j,k,sum;
    for(k = 0;k < numsSize - 2; k++){
        if(nums[k] > 0)
            return ans;
        if(k > 0 && nums[k] == nums[k-1])
            continue;
        i = k + 1;
        j = numsSize - 1;
        while(i < j) {
            sum = nums[i] + nums[j] + nums[k];
            if(sum == 0){
                ans[*returnSize] = (int*)malloc(sizeof(int)*3);
                (*returnColumnSizes)[*returnSize] = 3;
                ans[*returnSize][0] = nums[k];
                ans[*returnSize][1] = nums[i];
                ans[*returnSize][2] = nums[j];
                *returnSize += 1;
                
                // 去重
                while(i < j && nums[i] == nums[i + 1]) {
                    i ++;
                }
                
                while(i < j && nums[j] == nums[j - 1]) {
                    j --;
                }
                
            } else if(sum > 0) { // 若和大于 0，说明 nums[j] 太大，j 左移
                j --;
            } else { // 若和小于 0，说明 nums[i] 太小，i 右移
                i ++;
            }
                
        }
    }
    return ans;
}

//算法流程：
//特判，对于数组长度 n，如果数组为 null 或者数组长度小于 3，返回 []。
//对数组进行排序。
//遍历排序后数组：
//    若 nums[i]>0：因为已经排序好，所以后面不可能有三个数加和等于 00，直接返回结果。
//    对于重复元素：跳过，避免出现重复解
//    令左指针 L=i+1，右指针 R=n-1，当 L<R 时，执行循环：
//        当 nums[i]+nums[L]+nums[R]==0nums[i]+nums[L]+nums[R]==0，执行循环，判断左界和右界是否和下一位置重复，去除重复解。并同时将 L,R 移到下一位置，寻找新的解
//        若和大于 0，说明 nums[R] 太大，R 左移
//        若和小于 0，说明 nums[L] 太小，L 右移
//
//class Solution:
//    def threeSum(self, nums: List[int]) -> List[List[int]]:
//
//        n=len(nums)
//        res=[]
//
//
//        if(not nums or n<3): // 条件判断
//            return []
//
//        nums.sort() // 对数组排序
//
//        res=[]
//
//        for i in range(n):
//            if(nums[i]>0):
//                return res
//            if(i>0 and nums[i]==nums[i-1]):
//                continue
//            L=i+1
//            R=n-1
//            while(L<R):
//                if(nums[i]+nums[L]+nums[R]==0):
//                    res.append([nums[i],nums[L],nums[R]])
//                    while(L<R and nums[L]==nums[L+1]):
//                        L=L+1
//                    while(L<R and nums[R]==nums[R-1]):
//                        R=R-1
//                    L=L+1
//                    R=R-1
//                elif(nums[i]+nums[L]+nums[R]>0):
//                    R=R-1
//                else:
//                    L=L+1
//        return res

//作者：wu_yan_zu
//链接：https://leetcode-cn.com/problems/3sum/solution/pai-xu-shuang-zhi-zhen-zhu-xing-jie-shi-python3-by/
//来源：力扣（LeetCode）
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
