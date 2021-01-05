//
//  TKFontListViewController.m
//  dailyCode
//
//  Created by hello on 2021/1/5.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKFontListViewController.h"

@interface TKFontListViewController ()

@end

@implementation TKFontListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [UIFont familyNames];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    NSString *fontName = (NSString *)[self.dataSource objectAtIndex:indexPath.item];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:17.f];
    
    return cell;
}
@end
