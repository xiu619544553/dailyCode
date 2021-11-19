//
//  TKPerson.m
//  KCObjc
//
//  Created by TK on 2020/7/24.
//

#import "TKPerson.h"

@implementation TKPerson

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
}

@end
