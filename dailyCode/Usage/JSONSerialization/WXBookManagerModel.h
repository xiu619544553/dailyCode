//
//  WXBookManagerModel.h
//  test
//
//  Created by hello on 2020/6/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WXPracticeNodeModel;

NS_ASSUME_NONNULL_BEGIN

@interface WXBookManagerModel : NSObject
@property (nonatomic, strong) NSArray<WXPracticeNodeModel *> *catalog;
@end

NS_ASSUME_NONNULL_END
