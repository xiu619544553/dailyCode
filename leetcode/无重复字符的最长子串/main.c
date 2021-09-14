//
//  main.c
//  无重复字符的最长子串
//
//  Created by hanxiuhui on 2021/8/31.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。
 
 示例 1:
 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 
 示例 2:
 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 
 示例 3:
 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 
 示例 4:
 输入: s = ""
 输出: 0
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


int max(int a, int b);
int lengthOfLongestSubstring(char *s);


int main(int argc, const char * argv[]) {
    
    char string[20] = "abcdabcbb";
    
    size_t len = strlen(string);
    printf("len=%zu\n", len);
    
    int length = lengthOfLongestSubstring(string);
    printf("length: %d\n", length);
    
    
    return 0;
}

// MARK: 算法实现
int max(int a, int b) {
    return a > b ? a : b;
}

int lengthOfLongestSubstring(char *s) {
    
    int len = (int)strlen(s);
    
    if (len <= 1) {
        return len;
    }
    
    int left, right;
    int posmap[128] = {0};
    int maxlen = 0;
    
    left = 0;
    right = 1;
    maxlen = 1;
    posmap[s[left]] = 1;
    
    while (s[right] != '\0') {                   // ‘\0’是字符串的结束符号，由编译器自动加上
        
        if (posmap[s[right]] != 0) {
            maxlen = max(maxlen,right -left);
            if (left < posmap[s[right]]) {
                left = posmap[s[right]];
            }
        }
        
        posmap[s[right]] = right+1;
        right++;
    }
    
    maxlen = max(maxlen,right -left);
    return maxlen;
}

// MARK: 算法原理
/*
 
 滑动窗口讲解：
 因为题目告知我们的字符串由字母、数字、符合、空格组成，所以我们使用一个128（保证ASCLL码中的所有元素都可以被记录）大小的int型数组int map[128]来记录遍历到的字符串中每一个字符的位置，由于map初始化为{0}，为了避免第一个字母的位置和初始化的0产生歧义，所以我们记录字符串的位置从1开始，即1~n。

 滑动窗口的关键步骤：
    ①维护当前窗口（当前不重复的子串）的大小：
    我们使用两个位置指示器：left和right来维护一个不重复的字符串，但是这里要注意，left是不重复字符串的左边界，而right不是右边界，right-1才是右边界，right是正待处理的字符的位置，它有可能在[left,right-1]范围中的字符出现过了。
    ②滑动到正确位置：
    当right指向的字母已经在当前的不重复子串中出现过了,(通过map[s[right]] != 0来判断), 由于[left,right-1]已经是一个不重复的子串了，但是由于它不一定是最长的，可能后面还有一个比它长且也是不重复的子串，所以我们需要滑动到构成下一个不重复的子串的左边界，这个左边界就是当前[left,right-1]中的那个和right指示的字符相同的字符的下一个位置，因为只有将它“排除在外”，才能构成新的不重复子串。

    ③代码里一个要理解清楚的地方：
 
    if (left < hashmap[s[right]]) {
        left = hashmap[s[right]];
    }
 
 这就是滑动到新的左边界的步骤，这个为什么要加一个判断？

 比如字符串 "abcba"的遍历：

 初始化：

 int map[128] = {0}；
 int left = 0;
 map[‘a’] = 1;
 int right =1;

 遍历开始：

 left = 0; right = 1; map[‘b’] = 2;
 left = 0; right = 2; map[‘c’] = 3;
 left = 0; right = 3; 此时map[‘b’]已经 !=0( = 2)；,所以right所指的第二个b和当前不重复子串“abc”会构成重复，所以我们要滑动，那么left滑动到重复字符b的下一个位置c，即，left = 2（left=map[‘b]’）;

 所以这一步骤的变化后：
 left = 2,map[‘b]更新为4，right = 5，**此时！**right指向了最后的’a’, 此时left = 2，而map['a]由于前一个窗口的遍历，将它变为了1，而我们的新窗口left=2,所以map['a]'虽然不等于0，但是也不表示和我们的新窗口里的某个元素重复。所以这个if(left < hashmap[s[right]])是非常之有必要的，它保证我们是向右边真正地滑动。这里一定要好好地理解。
 */
