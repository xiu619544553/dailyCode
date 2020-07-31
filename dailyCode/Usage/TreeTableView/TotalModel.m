//
//  TotalModel.m
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TotalModel.h"
#import "NodeModel.h"

@implementation TotalModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"catalog" : [NodeModel class]
    };
}
@end




