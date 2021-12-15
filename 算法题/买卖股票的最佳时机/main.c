//
//  main.c
//  买卖股票的最佳时机
//
//  Created by hello on 2021/12/15.
//

#include <stdio.h>


/*
 给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。
 你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。
 返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。

 示例 1：
 输入：[7,1,5,3,6,4]
 输出：5
 解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
      注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
 
 示例 2：
 输入：prices = [7,6,4,3,1]
 输出：0
 解释：在这种情况下, 没有交易完成, 所以最大利润为 0。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

int maxProfit(int* prices, int pricesSize);

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    int prices1[] = {7, 1, 5, 3, 6, 4};
    int max1 = maxProfit(prices1, sizeof(prices1) / sizeof(prices1[0]));
    printf("max1 = %d\n", max1);
    
    int prices2[] = {7, 6, 4, 3, 1};
    int max2 = maxProfit(prices2, sizeof(prices2) / sizeof(prices2[0]));
    printf("max2 = %d\n", max2);
    
    return 0;
}

// 转化为最大连续子列和问题
// 示例：int prices[] = {7,1,5,3,6,4};
// 转化为求 int diff[] = {-6, 4, -2, 3, -2};
// 时间复杂度：O(n)
int maxProfit(int* prices, int pricesSize) {
    
    int max = 0; // 最大利润
    int subSum = 0;  // 子列差值的和
    
    for (int i = 1; i < pricesSize; i ++) {
        
        // 计算当前股价与前一日股价的差值（趋势）
        subSum += prices[i] - prices[i - 1];
        
        if (subSum > max) {
            max = subSum; // 更大的结果
        }
        
        if (subSum < 0) { // 说明股价是下降趋势，它只会让后面的数字变得更小，则置为0，即从下一个股价开始计算。
            subSum = 0;
        }
    }
    
    return max;
}

/*
 0-1背包问题
 有一个背包，最多能承载150斤的重量，现在有7个物品：
  index    [1   2   3   4   5   6   7]
 重量分别为 [35, 30, 60, 50, 40, 10, 25]，
 价值分别为 [10, 40, 30, 50, 35, 40, 30]，
 
 问题：如何选择才能使得我们的背包背走最多价值的物品？
 
 
 明确到底什么是最优解？
 明确什么是子问题的最优解？
 分别求出子问题的最优解再堆叠出全局最优解？
 */
