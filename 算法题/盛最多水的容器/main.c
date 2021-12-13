//
//  main.c
//  盛最多水的容器
//
//  Created by hello on 2021/12/13.
//

#include <stdio.h>

int maxArea(int* height, int heightSize);



int main(int argc, const char * argv[]) {
    
    int height[] = {1,8,6,2,5,4,8,3,7};
    int area = maxArea(height, sizeof(height)/sizeof(height[0]));
    printf("area = %d\n", area);
    
    return 0;
}


#define Min(a, b) (((a) > (b)) ? (b) : (a))
#define Max(a, b) (((a) > (b)) ? (a) : (b))

// 盛最多水的容器
// 时间复杂度：O(n)
/*
 两个指针一个指向开头一个指向结尾，此时容器的底是最大的，
 然后随着指针向内移动，容器的底随之变小，在这种情况下想要让容器盛水变多，就只有在容器的高上下功夫。
 那我们该如何决策哪个指针移动呢？我们能够发现不管是左指针向右移动一位，还是右指针向左移动一位，容器的底都是一样的，都比原来减少了
 这种情况下我们想要让指针移动后的容器面积增大，就要使移动后的容器的高尽量大，所以我们选择指针所指的高较小的那个指针进行移动，这样我们就保留了容器较高的那条边，放弃了较小的那条边，以获得有更高的边的机会。
 */
int maxArea(int* height, int heightSize) {

    int area = 0;
    int left = 0, right = heightSize - 1;
    
    while (left < right) {
        area = Max(area, Min(height[left], height[right]) * (right - left));
        if (height[left] > height[right]) {
            right --;
        } else {
            left ++;
        }
    }
    
    return area;
}
