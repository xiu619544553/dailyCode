//
//  TESTSuper.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/13.
//

#import "TESTSuper.h"

@implementation TESTSuper



/*
 
 self = ((TESTSuper *(*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("TESTSuper"))}, sel_registerName("init"));
 
 
 self = ((TESTSuper *(*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self,
                                                                           (id)class_getSuperclass(objc_getClass("TESTSuper"))},
                                                                           sel_registerName("init"));
 
 */



- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
