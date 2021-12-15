//
//  main.c
//  买卖股票的最佳时机2
//
//  Created by hello on 2021/12/15.
//  https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/solution/leetcode121122mai-mai-gu-piao-de-zui-jia-a3sb/
/*
 给定一个数组 prices ，其中 prices[i]表示一支给定股票第 i 天的价格。
 设计一个算法来计算你所能获取的最大利润。
 你可以尽可能地完成更多的交易（多次买卖一支股票）。
 注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
 
 示例1
 || 输入：[7,1,5,3,6,4]
 || 输出：7
 || 解释：在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。

 示例2
 || 输入：[7,6,4,3,1]
 || 输出：0
 || 解释：在这种情况下，没有交易完成，所以最大利润为0。

 作者：dululuya
 链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/solution/leetcode121122mai-mai-gu-piao-de-zui-jia-a3sb/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

#include <stdio.h>


int totalProfit(int* prices, int pricesSize);


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    int prices1[] = {7, 1, 5, 3, 6, 4};
    int prices2[] = {7, 6, 4, 3, 1};
    
    int total1 = totalProfit(prices1, sizeof(prices1) / sizeof(prices1[0]));
    int total2 = totalProfit(prices2, sizeof(prices2) / sizeof(prices2[0]));
    
    printf("total1 = %d\n", total1);
    printf("total2 = %d\n", total2);
    
    return 0;
}




#define Max(a, b) ((a) > (b) ? (a) : (b))

int totalProfit(int* prices, int pricesSize) {
    
    int total = 0; // 总共利润
    
    for (int i = 1; i < pricesSize; i ++) {
        total += Max(prices[i] - prices[i - 1], 0);
    }
    
    return total;
}
