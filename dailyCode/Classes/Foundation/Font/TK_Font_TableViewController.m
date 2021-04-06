//
//  TK_Font_TableViewController.m
//  dailyCode
//
//  Created by hello on 2021/3/31.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TK_Font_TableViewController.h"

static NSMutableArray<NSDictionary *> *familyNames;

@implementation TK_Font_TableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    
    if (familyNames.count > 0) { // 加载缓存
        [self.tableView reloadData];
        return;
    }
    
    familyNames = [NSMutableArray array];
    [self showActivityWithText:@"数据加载中..."];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{

        [[UIFont familyNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull familyName, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *titleFontNames = [NSMutableDictionary dictionary];
            [titleFontNames setObject:familyName forKey:@"title"];
            [titleFontNames setObject:[UIFont fontNamesForFamilyName:familyName] forKey:@"fontNames"];
            
            [familyNames addObject:titleFontNames];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hidenActivity];
            [self.tableView reloadData];
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return familyNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *fontNames = [[familyNames objectAtIndex:section] objectForKey:@"fontNames"];
    return fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    NSArray *fontNames = [[familyNames objectAtIndex:indexPath.section] objectForKey:@"fontNames"];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 这是中文字体！English.", fontName];
    cell.textLabel.font = [UIFont fontWithName:fontName size:17.f];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[familyNames objectAtIndex:section] objectForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *fontNames = [[familyNames objectAtIndex:indexPath.section] objectForKey:@"fontNames"];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    
    NSLog(@"fontName : %@", fontName);
}
@end
