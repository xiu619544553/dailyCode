//
//  TKClickBlankOnTableViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/29.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKClickBlankOnTableViewController.h"

@interface TKClickBlankOnTableViewController () <UIGestureRecognizerDelegate>
@end

@implementation TKClickBlankOnTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = UIColor.whiteColor;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    @weakify(self)
    UITapGestureRecognizer *tagGR = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self)
        [self handleNavigationbar];
    }];
    tagGR.delegate = self;
    [self.tableView addGestureRecognizer:tagGR];
}

#pragma mark - UIGestureRecognizerDelegate
/**
 返回手势识别器是否允许检查手势对象.
 UIKit将会在touchesBegan:withEvent:方法之前调用这个代理.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [touch.view isKindOfClass:UITableView.class];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)
                                                            forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self handleNavigationbar];
}

#pragma mark - Private Methods

- (void)handleNavigationbar {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBar.isHidden
                                             animated:YES];
}
@end
