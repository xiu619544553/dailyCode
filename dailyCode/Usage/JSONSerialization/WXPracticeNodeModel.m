//
//  WXPracticeNodeModel.m
//  test
//
//  Created by hello on 2020/6/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import "WXPracticeNodeModel.h"

@implementation WXPracticeNodeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"children" : [WXPracticeNodeModel class]
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cate_id" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return YES;
}
@end
