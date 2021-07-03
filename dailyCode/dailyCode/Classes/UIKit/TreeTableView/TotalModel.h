//
//  TotalModel.h
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NodeModel;

NS_ASSUME_NONNULL_BEGIN

@interface TotalModel : NSObject
@property (nonatomic, strong) NSArray<NodeModel *> *catalog;
@end

NS_ASSUME_NONNULL_END
