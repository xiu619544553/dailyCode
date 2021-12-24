//
//  main.c
//  括号生成
//
//  Created by hello on 2021/12/23.
//

/*
 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。

 示例 1：
 输入：n = 3
 输出：["((()))","(()())","(())()","()(())","()()()"]
 
 示例 2：
 输入：n = 1
 输出：["()"]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/generate-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char ** generateParenthesis(int n, int* returnSize);

int main(int argc, const char * argv[]) {
    
    int returnSize = 0;
    char **strs = generateParenthesis(4, &returnSize);
    
    for (int i = 0; i < returnSize; i ++) {

        printf("i = %d，str = %s\n", i, strs[i]);

    }
    
    
    
    return 0;
}



/// 回溯算法
/// @param index 索引
/// @param lc 左括号个数
/// @param rc 右括号个数
/// @param n 括号一共有n对
/// @param str 每种组合
/// @param result 保存括号组合
/// @param returnSize result 二维数组的个数
void generate(int index, int lc, int rc, int n, char *str, char **result, int *returnSize) {
    
    // 当前长度已达2n
    if (index == 2 * n) {
        
        result[(*returnSize)] = (char *)calloc(2 * n + 1, sizeof(char));
        strcpy(result[(* returnSize)], str);
        (* returnSize) ++;
        return;
        
    } else {
        
        // 如果左括号数量不大于 n，可以放一个左括号
        if (lc < n) {
            str[index] = '(';
            generate(index + 1, lc + 1, rc, n, str, result, returnSize);
        }
        
        // 如果右括号数量小于左括号的数量，可以放一个右括号
        if (rc < lc) {
            str[index] = ')';
            generate(index + 1, lc, rc + 1, n, str, result, returnSize);
        }
        
    }
}

char ** generateParenthesis(int n, int* returnSize) {
    
    char *str = (char *)calloc(2 * n + 1, sizeof(char));
    // 卡特兰数: 1, 1, 2, 5, 14, 42, 132, 429, 1430。题目中已给出提示
    char **result = (char **)calloc(sizeof(char *), 1430);
    
    generate(0, 0, 0, n, str, result, returnSize);
    
    return result;
}


































//
//
//// 回溯法求解
//#define MAX_SIZE 1430  // 卡特兰数: 1, 1, 2, 5, 14, 42, 132, 429, 1430。leetcode提示 1 <= n <= 8，所以 MAX_SIZE 取值 1430 就可以满足。
//void generate(int left, int right, int n, char *str, int index, char **result, int *returnSize) {
//
//    if (index == 2 * n) { // 当前长度已达2n
//        result[(*returnSize)] = (char*)calloc((2 * n + 1), sizeof(char));
//
//        strcpy(result[(*returnSize)++], str);
//
//        printf("*returnSize = %d\n", *returnSize);
//
//        return;
//    }
//
//    // 如果左括号数量不大于 n，可以放一个左括号
//    if (left < n) {
//        str[index] = '(';
//        generate(left + 1, right, n, str, index + 1, result, returnSize);
//    }
//
//    // 如果右括号数量小于左括号的数量，可以放一个右括号
//    if (right < left) {
//        str[index] = ')';
//        generate(left, right + 1, n, str, index + 1, result, returnSize);
//    }
//}
///**
// * Note: The returned array must be malloced, assume caller calls free().
// */
//char** generateParenthesis(int n, int *returnSize) {
//    char *str = (char *)calloc(2 * n + 1, sizeof(char));
//    char **result = (char **)calloc(sizeof(char *), MAX_SIZE);
//    *returnSize = 0;
//    generate(0, 0, n, str, 0, result, returnSize);
//    return result;
//}
