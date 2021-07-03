//
//  TreeTableViewController.m
//  test
//
//  Created by hello on 2020/6/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TreeTableViewController.h"

#import "TotalModel.h"
#import "NodeModel.h"
#import "TreeTableViewCell.h"

#import "StudyDocumentInteractionController.h"

#import "TKCatalogModel.h"

@interface TreeTableViewController ()

/// 原数据  originalNodes
@property (nonatomic, strong) NSMutableArray<NodeModel *> *originalNodes;

/// 临时数组，该数组用于展示
@property (nonatomic, strong) NSMutableArray<NodeModel *> *tempNodes;

/// 保存要刷新的位置
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *reloads;

@end

@implementation TreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:TreeTableViewCell.class forCellReuseIdentifier:NSStringFromClass(TreeTableViewCell.class)];
    
//    [self loadTikuJson];
    
//    [self loadWeaknessJson];
}

#pragma mark - Data

- (void)addFirstLoadNodes {
    [self.originalNodes enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 如果有 level2 level3 需要加入的，可以条件判断
        if (obj.level == NodelLevel1) {
            [self.tempNodes addObject:obj];
        }
    }];
    [self.tableView reloadData];
}

- (void)loadTikuJson {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tiku" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        TotalModel *totalM = [TotalModel yy_modelWithJSON:data];
        NSArray *temporiginalNodes = [NSMutableArray arrayWithArray:totalM.catalog];
        
        for (NodeModel *l1 in temporiginalNodes) {
            [self.originalNodes addObject:l1];
            
            for (NodeModel *l2 in l1.children) {
                [self.originalNodes addObject:l2];
                
                for (NodeModel *l3 in l2.children) {
                    [self.originalNodes addObject:l3];
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addFirstLoadNodes];
        });
    });
}

- (void)loadWeaknessJson {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weakness" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        TotalModel *totalM = [TotalModel yy_modelWithJSON:data];
        NSArray *temporiginalNodes = [NSMutableArray arrayWithArray:totalM.catalog];
        
        for (NodeModel *l1 in temporiginalNodes) {
            [self.originalNodes addObject:l1];
            
            for (NodeModel *l2 in l1.children) {
                [self.originalNodes addObject:l2];
                
                for (NodeModel *l3 in l2.children) {
                    [self.originalNodes addObject:l3];
                }
            }
        }
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempNodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TreeTableViewCell.class) forIndexPath:indexPath];
    cell.nodeModel = [self.tempNodes objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StudyDocumentInteractionController *testVc = [StudyDocumentInteractionController new];
    [self.parentViewController.navigationController pushViewController:testVc animated:YES];
}

// 关闭
- (void)foldNodesWithLevel:(NodelLevel)level currentIndex:(NSInteger)currentIndex {
    
}

- (void)expandNodesWith {
    
}

#pragma mark - getter

- (NSMutableArray<NodeModel *> *)originalNodes {
    if (!_originalNodes) {
        _originalNodes = [NSMutableArray array];
    }
    return _originalNodes;
}

- (NSMutableArray<NodeModel *> *)tempNodes {
    if (!_tempNodes) {
        _tempNodes = [NSMutableArray array];
    }
    return _tempNodes;
}

- (NSMutableArray<NSIndexPath *> *)reloads {
    if (!_reloads) {
        _reloads = [NSMutableArray array];
    }
    return _reloads;
}

#pragma mark - Orientations

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
