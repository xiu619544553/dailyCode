//
//  TKTableViewController.h
//  dailyCode
//
//  Created by hello on 2020/9/24.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKTableViewController : UITableViewController

@property (nonatomic, copy) void(^updateBlock)(CGFloat height);

@end

NS_ASSUME_NONNULL_END
