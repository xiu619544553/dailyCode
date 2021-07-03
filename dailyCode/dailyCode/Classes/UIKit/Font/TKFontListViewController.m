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
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    [UIFont.familyNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"%@", obj);
        
        [[UIFont fontNamesForFamilyName:obj] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"          %@", obj);
        }];
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return UIFont.familyNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [UIFont fontNamesForFamilyName:UIFont.familyNames[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    NSString *familyName = UIFont.familyNames[indexPath.section];
    NSString *fontName = [UIFont fontNamesForFamilyName:familyName][indexPath.row];
    
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:17.f];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width_tk, 44.f)];
    sectionHeaderView.backgroundColor = UIColor.blackColor;
    
    UILabel *familyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0.f, sectionHeaderView.width_tk, sectionHeaderView.height_tk)];
    familyNameLabel.text = [UIFont familyNames][section];
    familyNameLabel.textColor = UIColor.whiteColor;
    [sectionHeaderView addSubview:familyNameLabel];
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}
@end
