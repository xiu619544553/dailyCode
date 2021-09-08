//
//  MainTableViewController.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/3.
//

#import "MainTableViewController.h"
#import "ObjcRuntimeViewController.h"
#import "MethodSwizzingViewController.h"

@interface MainItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) Class cls;
@end

@implementation MainItem

+ (instancetype)itemWithCls:(Class)cls title:(NSString *)title {
    return [[MainItem alloc] initWithCls:cls title:title];
}

- (instancetype)initWithCls:(Class)cls title:(NSString *)title {
    self = [super init];
    if (self) {
        _cls = cls;
        _title = title;
        
        NSAssert(![cls isKindOfClass:UIViewController.class], @"cls类型错误");
    }
    return self;
}

@end

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray<MainItem *> *items;
@end

@implementation MainTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)extracted:(NSIndexPath * _Nonnull)indexPath tableView:(UITableView * _Nonnull)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self extracted:indexPath tableView:tableView];
    
    // Configure the cell...
    if (_items.count > indexPath.row) {
        MainItem *item = [_items objectAtIndex:indexPath.row];
        cell.textLabel.text = item.title;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_items.count <= indexPath.row) return;
    [self.navigationController pushViewController:(UIViewController *)[[_items objectAtIndex:indexPath.row].cls new] animated:YES];
}

#pragma mark - getter

- (NSArray<MainItem *> *)items {
    if (!_items) {
        
        MainItem *item1 = [MainItem itemWithCls:[MethodSwizzingViewController class] title:@"Method Swizzing"];
        MainItem *item2 = [MainItem itemWithCls:[ObjcRuntimeViewController class] title:@"objc/runtime API使用"];
        
        _items = @[item1, item2];
    }
    return _items;
}
@end
