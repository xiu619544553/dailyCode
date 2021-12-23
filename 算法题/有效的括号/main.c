//
//  main.c
//  有效的括号
//
//  Created by hello on 2021/12/22.
//

/*
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 有效字符串需满足：
 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 
 示例 1：
 输入：s = "()"
 输出：true
 
 示例 2：
 输入：s = "()[]{}"
 输出：true
 
 示例 3：
 输入：s = "(]"
 输出：false
 
 示例 4：
 输入：s = "([)]"
 输出：false
 
 示例 5
 输入：s = "{[]}"
 输出：true

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

#include <stdio.h>
#include <stdbool.h>
#include <string.h>

bool isValid(char * s);

int main(int argc, const char * argv[]) {
    
    char strs[] = "([)]";
    int len = strlen(strs);
    
    bool result = isValid(strs);
    printf("result = %d\n", result);
    
    return 0;
}

char pairs(char c) {
    if (c == '}') return '{';
    if (c == ']') return '[';
    if (c == ')') return '(';
    return 0;
}

/// 以栈数据结构解题
bool isValid(char * s) {
    
    int len = strlen(s);
    if (len % 2 == 1) {
        return false;
    }

    // 初始化数组
    char stack[len];
    memset(stack, 0, len);

    // 栈顶指针
    int top = 0;

    for (int i = 0; i < len; i ++) {

        char subc = pairs(s[i]);
        
        if (subc) {
            // top == 0：表示当前给定字符首位置的括号是右括号
            // subc != stack[top - 1]  未按照正确的顺序闭合
            if (top == 0 || subc != stack[top - 1]) {
                return false;
            } else {
                // 出栈
                top --;
            }
            
        } else {
            // 入栈
            stack[top] = s[i];
            top ++;
        }

    }

    // 当 top == 0，表示所有括号都是成对的，且是按照正确顺序闭合的
    return top == 0;
}




