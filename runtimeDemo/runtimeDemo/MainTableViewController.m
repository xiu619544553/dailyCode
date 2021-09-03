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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    [self buildItems];
}

- (void)buildItems {
    MainItem *item1 = [MainItem itemWithCls:[MethodSwizzingViewController class] title:@"Method Swizzing"];
    MainItem *item2 = [MainItem itemWithCls:[ObjcRuntimeViewController class] title:@"objc/runtime API使用"];
    
    _items = @[item1, item2];
    NSLog(@"_items.count = %@", @(_items.count));
    
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
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
    if (_items.count <= indexPath.row) return;
    
    [self.navigationController pushViewController:(UIViewController *)[[_items objectAtIndex:indexPath.row].cls new] animated:YES];
}

@end
