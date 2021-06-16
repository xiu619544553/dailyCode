//
//  TKCatalogModel.m
//  test
//
//  Created by hello on 2020/7/23.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKCatalogModel.h"

@implementation TKCatalogModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"catalog" : [NSArray class]
    };
}
@end
