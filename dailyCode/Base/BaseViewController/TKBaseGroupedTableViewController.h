//
//  TKBaseGroupedTableViewController.h
//  dailyCode
//
//  Created by hello on 2021/1/5.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKBaseGroupedTableViewController : TKBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

NS_ASSUME_NONNULL_END
