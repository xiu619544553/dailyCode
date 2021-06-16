//
//  TKScreenshotTableViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/7.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKScreenshotTableViewController.h"
#import "TKScreenshotCell.h"

@interface TKScreenshotTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSString *> *imageUrlStringArray;
@end

@implementation TKScreenshotTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片异步解码";
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截图"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(screenshotAction:)];
    
    NSLog(@"count: %@", @(self.imageUrlStringArray.count));
}

#pragma mark - Action Methods

- (void)screenshotAction:(UIBarButtonItem *)sender {
    
    [self showActivity];
    
//    UIImage *img = [self getTableViewScreenshot:self.tableView whereView:self.view];
    
    [self screenshot:^(UIImage *img) {
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [self hidenActivity];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    } else {
        NSLog(@"保存成功");
    }
}

#pragma mark - 截屏1

- (UIImage *)getTableViewScreenshot:(UITableView *)tableView whereView:(UIView *)whereView {
    // 创建一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = UIColor.whiteColor;
    scrollView.frame = whereView.bounds;
    // 设置滚动位置
    scrollView.contentSize = CGSizeMake(whereView.width, tableView.contentSize.height);
    // 将tableView加载到视图中
    [scrollView addSubview:tableView];
    // 设置位置
    [tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(scrollView);
        make.width.mas_equalTo(whereView.width);
        make.height.mas_equalTo(tableView.contentSize.height);
    }];
    // 添加到指定视图
    [whereView addSubview:scrollView];

    // 截图
    UIImage *image = [self snapshotScreen:scrollView];
    // 移除scrollView
    [scrollView removeFromSuperview];
    return image;
}

- (UIImage *)snapshotScreen:(UIScrollView *)scrollView {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(scrollView.contentSize);
    }

    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGRect oldBounds = scrollView.layer.bounds;

    if (@available(iOS 13, *)) { // iOS 13 系统截屏需要改变tableview 的bounds
        scrollView.layer.bounds = CGRectMake(oldBounds.origin.x, oldBounds.origin.y, contentSize.width, contentSize.height);
    }
    // 偏移量归零
    scrollView.contentOffset = CGPointZero;
    // frame变为contentSize
    scrollView.frame = CGRectMake(0.f, 0.f, scrollView.contentSize.width, scrollView.contentSize.height);

    // 截图
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];

    if (@available(iOS 13, *)) {
        scrollView.layer.bounds = oldBounds;
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // 还原frame 和 偏移量
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = savedFrame;
    return image;
}

#pragma mark - 截屏2
- (void)screenshot:(void(^)(UIImage *img))handler {
    
    CGSize contentSize = self.tableView.contentSize;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(contentSize, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(contentSize);
    }
    
    // save initial values
    CGPoint savedContentOffset = self.tableView.contentOffset;
    CGRect savedFrame = self.tableView.frame;
    UIColor *savedBackgroundColor = self.tableView.backgroundColor;
    
    // reset offset to top left point
    self.tableView.contentOffset = CGPointZero;
    // set frame to content size
    self.tableView.frame = CGRectMake(0.f, 0.f, contentSize.width, contentSize.height);
    // remove background
    self.tableView.backgroundColor = UIColor.clearColor;
    
    [self.tableView scrollToBottom];
    NSLog(@"\nframe: %@ \ncontentSize: %@", NSStringFromCGRect(self.tableView.frame), NSStringFromCGSize(self.tableView.contentSize));
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        // make temp view with scroll view content size
        // a workaround for issue when image on ipad was drawn incorrectly
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, contentSize.width, contentSize.height)];
        
        // save superview
        UIView *tempSuperView = self.tableView.superview;
        // remove scrollView from old superview
        [self.tableView removeFromSuperview];
        // and add to tempView
        [tempView addSubview:self.tableView];
        
        // render view
        // drawViewHierarchyInRect not working correctly
        [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
        // and get image
        UIImage *snapImg = UIGraphicsGetImageFromCurrentImageContext();

        // and return everything back
        [tempView.subviews[0] removeFromSuperview];
        [tempSuperView addSubview:self.tableView];
        
        // restore saved settings
        self.tableView.contentOffset = savedContentOffset;
        self.tableView.frame = savedFrame;
        self.tableView.backgroundColor = savedBackgroundColor;

        UIGraphicsEndImageContext();
        
        !handler ?: handler(snapImg);
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageUrlStringArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TKScreenshotCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TKScreenshotCell.class) forIndexPath:indexPath];
    
//    TKScreenshotCell *cell = [[TKScreenshotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@-%@", NSStringFromClass(TKScreenshotCell.class), @(indexPath.row)]];
    
    NSInteger row = indexPath.row;
    if (row < self.imageUrlStringArray.count) {
        cell.imageUrlString = [self.imageUrlStringArray objectAtIndex:row];
        NSLog(@"row: %@", @(row));
    }
    
    if (row == self.imageUrlStringArray.count - 1) {
        NSLog(@"cellForRow: \nframe: %@ \ncontentSize: %@", NSStringFromCGRect(self.tableView.frame), NSStringFromCGSize(self.tableView.contentSize));
    }
    
    return cell;
}

#pragma mark - geter

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1000) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = 300.f;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsMake(0.f, 15.f, 0.f, 15.f);
        
        [_tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        
        [_tableView registerClass:TKScreenshotCell.class
           forCellReuseIdentifier:NSStringFromClass(TKScreenshotCell.class)];
    }
    return _tableView;
}

- (NSMutableArray<NSString *> *)imageUrlStringArray {
    if (!_imageUrlStringArray) {
        _imageUrlStringArray = [NSMutableArray array];
        
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/6fc6f04egw1evuciu6zqlj20hs0vkab3.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/61e89358jw1evvyskb8p7j20hs1030xf.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/48e3f28djw1evvhkx7o7pj20m211cqaz.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/9a099b04gw1evvzlou4tmj20yi0rsgt7.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/6204ece1gw1evvzh9bp37j20fa08yjt5.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/6204ece1gw1evvzegkumsj20k069f4hm.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/8aca58f7jw1evvz55yls6j20a00gmt9j.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/648ac377gw1evvb5p5racj20kg0p07eo.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/648ac377gw1evvb6bwk53j20kg0o7q8n.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/648ac377gw1evvb638ctyj20jg0qon80.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/648ac377gw1evvb64986kj20ke0qo79q.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/648ac377gw1evvb5q5xw9j20k50qo7ar.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/648ac377gw1evvb671w2nj20kg0pugvo.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/648ac377gw1evvb6917s9j20kg0qdwkm.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/648ac377gw1evvb69y6z0j20kg0ox0y5.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/648ac377gw1evvb61yq07j20kg0q8wqx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/648ac377gw1evvb61yq07j20kg0q8wqx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/53899d01jw1evvzifd52yj20go0hmtdn.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/53899d01jw1evvzifd52yj20go0hmtdn.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/ebebae87jw1evvh9eq0yfj22io1w01kx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/wap720/ebebae87jw1evvh9eq0yfj22io1w01kx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/e4ff1178jw1evvzh59ob7j20fe0kj0u7.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/woriginal/e4ff1178jw1evvzh59ob7j20fe0kj0u7.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/61e64a12jw1evvd94nontj20c849s4kd.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/woriginal/61e64a12jw1evvd94nontj20c849s4kd.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/9ccc7942gw1evv44oqlzfj20m81sh10n.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/9ccc7942gw1evv44s8we7j20m80xcwk2.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/woriginal/9ccc7942gw1evv44s8we7j20m80xcwk2.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44oe5drj20m81shaiu.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/9ccc7942gw1evv44oe5drj20m81shaiu.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44p7q6ij20m82bcdqv.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/c2bf7ad2gw1evu1og7gssj20c80bwgm4.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/72a31574gw1evvgvt0bhfj20ju0emwj2.jpg"];
    }
    return _imageUrlStringArray;
}

@end
