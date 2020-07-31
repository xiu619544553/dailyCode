//
//  WXBookManagerModel.m
//  test
//
//  Created by hello on 2020/6/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import "WXBookManagerModel.h"
#import "WXPracticeNodeModel.h"

@implementation WXBookManagerModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"catalog"     : [WXPracticeNodeModel class]
    };
}
@end
