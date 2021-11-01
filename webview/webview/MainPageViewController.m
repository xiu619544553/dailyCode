//
//  MainPageViewController.m
//  webview
//
//  Created by hello on 2021/11/1.
//

#import "MainPageViewController.h"
#import "JSOCViewController.h"
#import "HandleJSAlertViewController.h"

@interface MainPageItem : NSObject

@property (nonatomic, assign) SEL action;
@property (nonatomic, copy, nonnull) NSString *title;
+ (instancetype)itemWithTitle:(NSString *)title action:(SEL)action;

@end

@implementation MainPageItem

+ (instancetype)itemWithTitle:(NSString *)title action:(SEL)action {
    return [[MainPageItem alloc] initWithTitle:title action:action];
}

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action {
    self = [super init];
    if (self) {
        _action = action;
        _title = title;
    }
    return self;
}

@end

#pragma mark - 首页
@interface MainPageViewController ()

@property (nonatomic, strong) NSArray<MainPageItem *> *items;

@end

@implementation MainPageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"WKWebView";
    
    _items = @[
        [MainPageItem itemWithTitle:@"JS调用OC" action:@selector(jsocInvoke)],
        [MainPageItem itemWithTitle:@"处理JS中的弹出框" action:@selector(handleJSAlertAction)],
    ];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = _items[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:_items[indexPath.row].action];
#pragma clang diagnostic pop
}

#pragma mark - Action Methods

- (void)jsocInvoke {
    [self.navigationController pushViewController:[JSOCViewController new] animated:YES];
}

- (void)handleJSAlertAction {
    [self.navigationController pushViewController:[HandleJSAlertViewController new] animated:YES];
}
@end
