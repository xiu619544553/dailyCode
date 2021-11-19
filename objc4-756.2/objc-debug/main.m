//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        LGPerson *object = [LGPerson alloc];
//        NSLog(@"Hello, World! %@",object);
        
        
        Class cls = objc_getClass("LGPerson");
        
        NSLog(@"cls=%@", cls);
        
    }
    return 0;
}
