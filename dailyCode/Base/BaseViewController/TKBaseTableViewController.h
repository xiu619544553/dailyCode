//
//  TKBaseTableViewController.h
//  dailyCode
//
//  Created by hello on 2020/10/13.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKBaseTableViewController : TKBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

NS_ASSUME_NONNULL_END
