//
//  TKPerson.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/6.
//

#import "TKPerson.h"

@implementation TKPerson

- (void)saySomething {
    NSLog(@"%s - %@", __func__, self.tk_name);
}

@end
