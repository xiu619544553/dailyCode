//
//  main.m
//  KCObjc
//
//  Created by TK on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "TKPerson.h"


// 引入打印函数
extern void _objc_autoreleasePoolPrint(void);

// 单个 @autoreleasepool
void singleAutoreleasePool(void);

// 嵌套 @autoreleasepool
void nestedAutoreleasePool(void);

// 复杂情况 @autoreleasepool
void complexAutoreleasePool(void);


int main(int argc, const char * argv[]) {
    
    // 单个 @autoreleasepool
//    singleAutoreleasePool();
    
    // 嵌套 @autoreleasepool
    nestedAutoreleasePool();
//
//    // 复杂情况 @autoreleasepool
//    complexAutoreleasePool();

    return 0;
}

#pragma mark - 单个 @autoreleasepool
void singleAutoreleasePool(void) {
    _objc_autoreleasePoolPrint();     // print1

    @autoreleasepool {
        // insert code here...
        
        _objc_autoreleasePoolPrint(); // print2
        
        TKPerson *objc1 = [[TKPerson alloc] init];
        TKPerson *objc2 = [[TKPerson alloc] init];

        _objc_autoreleasePoolPrint(); // print3
    }

    _objc_autoreleasePoolPrint(); // print4
}

#pragma mark - 嵌套 @autoreleasepool
void nestedAutoreleasePool(void) {
    
    _objc_autoreleasePoolPrint();             // print1
    
    @autoreleasepool { //r1 = push()
        
        _objc_autoreleasePoolPrint();         // print2
        __autoreleasing TKPerson *p1 = [[TKPerson alloc] init];
        __autoreleasing TKPerson *p2 = [[TKPerson alloc] init];
        _objc_autoreleasePoolPrint();         // print3
        
        @autoreleasepool { //r2 = push()
            
            __autoreleasing TKPerson *p3 = [[TKPerson alloc] init];
            
            _objc_autoreleasePoolPrint();     // print4
            
            @autoreleasepool { //r3 = push()
                __autoreleasing TKPerson *p4 = [[TKPerson alloc] init];
                _objc_autoreleasePoolPrint(); // print5
            } //pop(r3)
            
            _objc_autoreleasePoolPrint();     // print6
            
        } //pop(r2)
        _objc_autoreleasePoolPrint();         // print7
        
    } //pop(r1)
    _objc_autoreleasePoolPrint();             // print8
}

// 输出日志
/*
 
 // print1
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 0 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: ##############

 // print2
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 1 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: [0x100815038]  ################  POOL 0x100815038
 objc[9276]: ##############

 // print3
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 3 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: [0x100815038]  ################  POOL 0x100815038
 objc[9276]: [0x100815040]       0x1005891f0  TKPerson
 objc[9276]: [0x100815048]       0x100589cd0  TKPerson
 objc[9276]: ##############

 // print4
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 5 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: [0x100815038]  ################  POOL 0x100815038
 objc[9276]: [0x100815040]       0x1005891f0  TKPerson
 objc[9276]: [0x100815048]       0x100589cd0  TKPerson
 objc[9276]: [0x100815050]  ################  POOL 0x100815050
 objc[9276]: [0x100815058]       0x100588d00  TKPerson
 objc[9276]: ##############

 // print5
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 7 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: [0x100815038]  ################  POOL 0x100815038
 objc[9276]: [0x100815040]       0x1005891f0  TKPerson
 objc[9276]: [0x100815048]       0x100589cd0  TKPerson
 objc[9276]: [0x100815050]  ################  POOL 0x100815050
 objc[9276]: [0x100815058]       0x100588d00  TKPerson
 objc[9276]: [0x100815060]  ################  POOL 0x100815060
 objc[9276]: [0x100815068]       0x100709330  TKPerson
 objc[9276]: ##############

 // print6
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 5 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: [0x100815038]  ################  POOL 0x100815038
 objc[9276]: [0x100815040]       0x1005891f0  TKPerson
 objc[9276]: [0x100815048]       0x100589cd0  TKPerson
 objc[9276]: [0x100815050]  ################  POOL 0x100815050
 objc[9276]: [0x100815058]       0x100588d00  TKPerson
 objc[9276]: ##############

 // print7
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 3 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: [0x100815038]  ################  POOL 0x100815038
 objc[9276]: [0x100815040]       0x1005891f0  TKPerson
 objc[9276]: [0x100815048]       0x100589cd0  TKPerson
 objc[9276]: ##############

 // print8
 objc[9276]: ##############
 objc[9276]: AUTORELEASE POOLS for thread 0x1000ebe00
 objc[9276]: 0 releases pending.
 objc[9276]: [0x100815000]  ................  PAGE  (hot) (cold)
 objc[9276]: ##############
 Program ended with exit code: 0
 */



#pragma mark - 复杂情况 @autoreleasepool
void complexAutoreleasePool(void) {
    
    @autoreleasepool { //r1 = push()
        
        for (int i = 0; i < 600; i++) {
            TKPerson *p = [[TKPerson alloc] init];
        }
        
        @autoreleasepool { //r2 = push()
            
            for (int i = 0; i < 500; i++) {
                TKPerson *p = [[TKPerson alloc] init];
            }
            
            @autoreleasepool { //r3 = push()
                for (int i = 0; i < 200; i++) {
                    TKPerson *p = [[TKPerson alloc] init];
                }
                _objc_autoreleasePoolPrint();
            } //pop(r3)
            
        } //pop(r2)
        
    } //pop(r1)
    
}
