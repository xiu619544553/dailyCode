//
//  TKTableViewController.m
//  dailyCode
//
//  Created by hello on 2020/9/24.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKTableViewController.h"
#import <NSObject+TKAdd.h>

@interface TKTableViewController ()
@property (nonatomic, assign) NSInteger number;
@end

@implementation TKTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44.f;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    self.number = [NSObject getRandomNumberFrom:10 to:50];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.updateBlock) {
        
        NSInteger randowHeight = [NSObject getRandomNumberFrom:50 to:200];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"randowHeight: %@", @(randowHeight)];
        
        self.updateBlock(randowHeight);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"row: %@", @(indexPath.row)];
    
    return cell;
}

@end
