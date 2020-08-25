//
//  TKAutoLayoutCellController.m
//  dailyCode
//
//  Created by hanxiuhui on 2020/8/25.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKAutoLayoutCellController.h"
#import <Masonry/Masonry.h>
#import "TKAutoLayout2Cell.h"

@interface TKAutoLayoutCellController ()

@end

@implementation TKAutoLayoutCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.f;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:TKAutoLayout2Cell.class forCellReuseIdentifier:NSStringFromClass(TKAutoLayout2Cell.class)];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TKAutoLayout2Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TKAutoLayout2Cell.class) forIndexPath:indexPath];
    
    NSString *title = @"你好你好你好你好你好你好";
    NSString *time = @"2天前";
    
    
    if (indexPath.row == 0) {
        title = @"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好";
    }
    
    
    [cell updateTitle:title time:time];
    
    return cell;
}

@end
