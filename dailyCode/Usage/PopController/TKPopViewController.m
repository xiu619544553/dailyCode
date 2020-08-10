//
//  TKPopViewController.m
//  dailyCode
//
//  Created by hanxiuhui on 2020/8/11.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKPopViewController.h"
#import "DQPopView.h"

@interface TKPopViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger count;

@end

@implementation TKPopViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200.f, 100.f, 120.f, 44.f);
    btn.backgroundColor = UIColor.blackColor;
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - Event Methods

- (void)btnAction:(UIButton *)sender {
    
    // 外部可以根据屏幕与锚点控件的关系，改变 direct
    
    DQPopView *pop =  [DQPopView popUpContentView:self.tableView direct:DQPopViewDirection_PopUpBottom onView:sender offset:0 triangleView:nil animation:YES];
    pop.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"row = %@", @(indexPath.row)];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 300.f) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

@end
