//
//  ViewController.m
//  RunLoopInterviewQuestion
//
//  Created by hello on 2021/11/30.
//

#import "ViewController.h"
#import "ThreadViewController.h"

@interface CellItem : NSObject

@property (nonatomic, assign) SEL action;
@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithTitle:(NSString *)title action:(SEL)action;

@end

@implementation CellItem

+ (instancetype)itemWithTitle:(NSString *)title action:(SEL)action {
    return [[CellItem alloc] initWithTitle:title action:action];
}

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action {
    self = [super init];
    if (self) {
        _title = title;
        _action = action;
    }
    return self;
}

@end


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<CellItem *> *items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RunLoop相关";
    
    _items = @[
        [CellItem itemWithTitle:@"线程保活" action:@selector(threadAlive)]
    ];
    
    [self setupUI];
}

- (void)threadAlive { [self.navigationController pushViewController:[ThreadViewController new] animated:YES]; }

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSelector:[self.items objectAtIndex:indexPath.row].action];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.items objectAtIndex:indexPath.row].title];
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 自动计算cell高度，给个约数
        _tableView.estimatedRowHeight = 100.f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}


@end
