//
//  main.m
//  栈与递归的关系
//
//  Created by hanxiuhui on 2020/4/13.
//  Copyright © 2020 TK. All rights reserved.
//

#include <stdio.h>
#include "string.h"
#include "ctype.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"


int Fbi(int i) {
    if (i < 2) {
        return i == 0 ? 0 : 1;
    }
    return Fbi(i-1) + Fbi(i-2);
}

int main(int argc, const char * argv[]) {
    
    printf("斐波拉契数列...\n");
    for (int i = 0; i < 10; i ++) {
        printf("%d  ", Fbi(i));
    }
    printf("\n");
    
    return 0;
}
