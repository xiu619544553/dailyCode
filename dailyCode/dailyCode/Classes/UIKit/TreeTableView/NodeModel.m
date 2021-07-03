//
//  NodeModel.m
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "NodeModel.h"
#import <NSObject+YYAdd.h>

@implementation NodeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"children" : [NodeModel class]
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cate_id" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return YES;
}

- (NodelLevel)level {
    if (_type == nil || _type.length == 0) {
        _level = NodelLevelUndefine;
    } else if ([_type isEqualToString:@"level2"]) {
        _level = NodelLevel1;
    } else if ([_type isEqualToString:@"level3"]) {
        _level = NodelLevel2;
    } else if ([_type isEqualToString:@"level4"]) {
        _level = NodelLevel3;
    } else {
        _level = NodelLevelUndefine;
    }
    
    return _level;
}

@end
