//
//  main.c
//  电话号码的字母组合
//
//  Created by hello on 2021/12/15.
//  https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number/
//  https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number/solution/dian-hua-hao-ma-de-zi-mu-zu-he-by-leetcode-solutio/
/*
 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。
 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母
 
 示例 1：
 输入：digits = "23"
 输出：["ad","ae","af","bd","be","bf","cd","ce","cf"]
 
 示例 2：
 输入：digits = ""
 输出：[]
 
 示例 3：
 输入：digits = "2"
 输出：["a","b","c"]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

char** letterCombinations(char* digits, int* returnSize);

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
//    char str1[] = "abc";
//    char str2[] = "abc\n";
//
//    printf("str1 = %lu\n", strlen(str1)); // str1 = 3
//    printf("str2 = %lu\n", strlen(str2)); // str2 = 4
//
//    printf("str1 = %s\n", str1); // str1 = abc
//    printf("str2 = %s\n", str2); // str2 = abc
//
//    char str3[] = {'a', 'b', 'c', '\0'};
//    printf("str3.len = %lu\n", strlen(str3)); // str3 = 3
//    printf("str3 = %s\n", str3); // str3 = abc
    
    
//    const char src[50] = "http://www.runoob.com";
//    char dest[50];
//
//    memcpy(dest, src, strlen(src) + 1);
//
//    printf("dest = %s\n", dest);
    
    
    int returnSize = 0;
    char digits[] = "234";
    char **result = letterCombinations(digits, &returnSize);

    printf("returnSize = %d\n", returnSize);

    for (int i = 0; i < returnSize; i ++) {

        char *ele = result[i];
        printf("ele = %s\n", ele);

    }
    
    return 0;
}

char phoneMap[11][5] = {"\0", "\0", "abc\0", "def\0", "ghi\0", "jkl\0", "mno\0", "pqrs\0", "tuv\0", "wxyz\0"};

char* digits_tmp; // 输入的数字
int digits_size;  // 数字的长度

char** combinations;   // 字符串数组
int combinations_size; // 字符串数组的个数

char* combination;     // 字符串数组中单个字符串
int combination_size;  // 字符串数组中单个字符串的个数

void backtrack(int index);
char** letterCombinations(char* digits, int* returnSize);



/// 回溯算法
/// @param index 深度（可以理解为输入的电话号码的下标）
void backtrack(int index) {

    if (index == digits_size) { // 迭代退出条件
        
        int len = sizeof(char) * (combination_size + 1);
        char *tmp = malloc(len);
        memcpy(tmp, combination, len);
        combinations[combinations_size] = tmp;
        combinations_size ++;
        
    } else {

        char digit = digits_tmp[index];
        char *letters = phoneMap[digit - '0'];
        int len = (int)strlen(letters);
        
        for (int i = 0; i < len; i ++) {
            
            combination[combination_size] = letters[i];
            combination[++combination_size] = 0;
            
            // 深度优先搜索
            backtrack(index + 1);
            
            combination[--combination_size] = 0;
        }
    }
}

/// 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。
/// @param digits 2-9 电话号码
/// @param returnSize 字母组合的个数
char** letterCombinations(char* digits, int* returnSize) {

    combinations_size = 0;
    combination_size  = 0;
    digits_tmp = digits;
    digits_size = (int)strlen(digits);
    
    if (digits_size <= 0) {
        *returnSize = 0;
        return combinations;
    }

    int count = (int)pow(digits_size, 4);
    
    combination = malloc(sizeof(char *) * digits_size);
    combinations = malloc(sizeof(char *) * count);
    
    backtrack(0);
    
    *returnSize = combinations_size;
    
    return combinations;
}


// 2 abc
// 3 def


/// 回溯算法
/// @param index 深度（输入数字的下标）
void backtrack1(int index) {
    if (index == digits_size) {
        // 创建临时变量，combination_size 是字母字符占用空间，1 是 '\0' 占用的内存空间
        char* tmp = malloc(sizeof(char) * (combination_size + 1));
        // 将 combination 指定字节内容拷贝到 tmp
        memcpy(tmp, combination, sizeof(char) * (combination_size + 1));
        // combinations_size++：完成赋值=后，才会+1。
        combinations[combinations_size++] = tmp;
    } else {
        char digit = digits_tmp[index];
        char* letters = phoneMap[digit - '0'];
        int len = strlen(letters);

        for (int i = 0; i < len; i++) {
            combination[combination_size++] = letters[i];
            combination[combination_size] = 0;

            // 深度优先搜索
            backtrack(index + 1);

            combination[--combination_size] = 0;
        }
    }
}


/// 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。
/// @param digits 2-9 的字符串
/// @param returnSize 字母组合的个数
char** letterCombinations1(char* digits, int* returnSize) {

    combinations_size = combination_size = 0;
    digits_tmp = digits;
    digits_size = strlen(digits);

    if (digits_size == 0) {
        *returnSize = 0;
        return combinations;
    }

    int num = 1;
    for (int i = 0; i < digits_size; i++) {
        num *= 4;
    }

    combinations = malloc(sizeof(char*) * num);
    combination = malloc(sizeof(char*) * digits_size);

    backtrack1(0);
    *returnSize = combinations_size;
    return combinations;
}
