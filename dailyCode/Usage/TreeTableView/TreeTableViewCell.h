//
//  TreeTableViewCell.h
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NodeModel;

NS_ASSUME_NONNULL_BEGIN

@interface TreeTableViewCell : UITableViewCell
@property (nonatomic, strong) NodeModel *nodeModel;
@end

NS_ASSUME_NONNULL_END
