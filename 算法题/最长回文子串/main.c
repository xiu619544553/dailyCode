//
//  main.m
//  最长回文子串
//
//  Created by hello on 2021/12/8.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

char * longestPalindrome(char * s);
void oddPalindrome(char *s, int len, int *sublen, int *start);
void evenPalindrome(char *s, int len, int *sublen, int *start);


//作者：penn-10
//链接：https://leetcode-cn.com/problems/longest-palindromic-substring/solution/cyu-yan-zui-chang-hui-wen-zi-chuan-by-penn-10/
//来源：力扣（LeetCode）
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
//char * longestPalindrome(char * s) {
//    int N = strlen(s), start = 0, len = 0;  // N 字符串长度， start 子串起始位置， len 子串长度
//    for (int i = 0; i < N; i++) {   // 奇数长度的回文子串
//        int left = i - 1, right = i + 1;
//        while (left >= 0 && right < N && s[left] == s[right]){
//            left--; right++;            // 以 i 为中心，向两侧延伸，直到不再满足回文
//        }                               // left+1 ~ right-1 则为以i为中心的最大回文子串
//
//        // 若更长，则保存该子串信息。
//        // 关于：right - left - 1。因为 while结束时，left多减了1，right多加了1，所以此处是 (right - 1) - (left + 1) + 1 = right - left - 1
//        if (right - left - 1 > len) {
//            start = left + 1;
//            len = right - left - 1;
//        }
//    }
//
//    for (int i = 0; i < N; i++) {   // 偶数长度的回文子串
//        int left = i, right = i + 1;    // 以 i+0.5 为中心，向两侧延伸
//        while (left >= 0 && right < N && s[left] == s[right]) {
//            left--, right++;
//        }
//        if (right - left - 1 > len) {
//            start = left + 1;
//            len = right - left - 1;
//        }
//    }
//
//    s[start + len] = '\0';      // 原地修改返回
//
//    return s + start;           // 更改字符串数组首地址
//}

int main(int argc, const char * argv[]) {
    
    char str[] = "abcbmn";
    char *result = longestPalindrome(str);
    printf("result = %s\n", result);
    
    
    return 0;
}

#pragma mark - 求最大回文字符串
// 求最大回文字符串
char* longestPalindrome(char * s) {

    int len = (int)strlen(s); // 字符串长度
    int sublen = 0; // 子串长度
    int start  = 0; // 子串起始位置

    // 奇数长度的回文字符串
    oddPalindrome(s, len, &sublen, &start);
    
    // 偶数长度的回文字符串
    evenPalindrome(s, len, &sublen, &start);
    
    s[start + sublen] = '\0'; // 修改原字符串

    return (s + start); // 指针偏移，数组首元素指向子串起始位置
}

// 奇数长度的回文字符串
void oddPalindrome(char *s, int len, int *sublen, int *start) {
    for (int i = 0; i < len; i ++) {

        // 以 i 为中心，向两侧延伸
        int left = i - 1;
        int right = i + 1;

        // 直到不再满足回文
        while ((left >= 0) && (right < len) && (s[left] == s[right])) {
            left --;
            right ++;
        }

        // left+1 ~ right-1 则为以i为中心的最大回文子串
        // 计算新的子串的长度。计算式需要注意，while时，left进行了减减操作，right进行了加加操作。所以复原符合条件的left和right：newSublen = (right - 1) (left + 1) + 1;
        int newSublen = right - left - 1;
        if (newSublen > *sublen) {
            *start = left + 1;   // while进行了减减操作后，此时的left是不满足while条件的，所以进行还原操作
            *sublen = newSublen; // 子串长度
        }
    }
}

// 偶数长度的回文字符串
void evenPalindrome(char *s, int len, int *sublen, int *start) {
    for (int i = 0; i < len; i ++) { // 奇数长度的回文字符串

        // 以 i+0.5 为中心，向两侧延伸
        int left = i;
        int right = i + 1;

        // 直到不再满足回文
        while ((left >= 0) && (right < len) && (s[left] == s[right])) {
            left --;
            right ++;
        }

        // left+1 ~ right-1 则为以i为中心的最大回文子串
        // 计算新的子串的长度。计算式需要注意，while时，left进行了减减操作，right进行了加加操作。所以复原符合条件的left和right：newSublen = (right - 1) (left + 1) + 1;
        int newSublen = right - left - 1;
        if (newSublen > *sublen) {
            *start = left + 1;   // while进行了减减操作后，此时的left是不满足while条件的，所以进行还原操作
            *sublen = newSublen; // 子串长度
        }
    }
}










































