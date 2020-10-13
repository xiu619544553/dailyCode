//
//  AsyncDecoderImageViewController.m
//  test
//
//  Created by hello on 2020/6/17.
//  Copyright © 2020 TK. All rights reserved.
//

#import "AsyncDecoderImageViewController.h"
#import "AsyncDecoderCell.h"

@interface AsyncDecoderImageViewController ()
@property (nonatomic, strong) NSMutableArray<NSString *> *imageUrlStringArray;
@end

@implementation AsyncDecoderImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片异步解码";
    self.tableView.rowHeight = 300.f;
    [self.tableView registerClass:AsyncDecoderCell.class forCellReuseIdentifier:NSStringFromClass(AsyncDecoderCell.class)];
    [self.tableView reloadData];
    
    
//    DLog(@"******************************");
//    UIScreen *mainScreen = [UIScreen mainScreen];
//    DLog(@"screen = %@", NSStringFromCGRect(mainScreen.bounds));
//
//    UIScreenMode *currentMode = mainScreen.currentMode;
//    DLog(@"currentMode.size = %@", NSStringFromCGSize(currentMode.size));
//
//    // The aspect ratio of a single pixel. The ratio is defined as X/Y.
//    // 一个像素的高宽比。这个比值定义为X/Y。
//    DLog(@"pixelAspectRatio = %@", @(currentMode.pixelAspectRatio));
//
//
//    if (kIs_4Inch_Screen) {
//        DLog(@"kIs4InchScreen");
//    }
//
//
//    if (kIs_47Inch_Screen) {
//        DLog(@"4.7英寸手机屏幕");
//    }
//
//
//    if (kIs_55Inch_Screen) {
//        DLog(@"5.5英寸手机屏幕");
//    }
//
//    if (kIs_iPhoneX) {
//        DLog(@"IS_iPhoneX");
//    }
//
//    if (kIs_iPhoneXR) {
//        DLog(@"IS_iPhoneXR");
//    }
    
//    DLog(@"栈底控制器有 %lu 个", (unsigned long)self.navigationController.viewControllers.count);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController pushViewController:[AsyncDecoderImageViewController new] animated:NO];
//    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageUrlStringArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AsyncDecoderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AsyncDecoderCell.class) forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    if (row < self.imageUrlStringArray.count) {
        cell.imageUrlString = [self.imageUrlStringArray objectAtIndex:row];
    }
    
    return cell;
}


#pragma mark - geter

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
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/9ccc7942gw1evv44nc2jyj20m80xc7bp.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/woriginal/9ccc7942gw1evv44nc2jyj20m80xc7bp.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44mbb7aj20m80xcqcg.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/9ccc7942gw1evv44mbb7aj20m80xcqcg.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/9ccc7942gw1evv44s8we7j20m80xcwk2.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/woriginal/9ccc7942gw1evv44s8we7j20m80xcwk2.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44oe5drj20m81shaiu.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/9ccc7942gw1evv44oe5drj20m81shaiu.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44p7q6ij20m82bcdqv.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/9ccc7942gw1evv44u88hwj20m80xc7ac.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44lb7ncj20m80xc45f.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/9ccc7942gw1evv44tcuxhj20m80xcdob.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/c2bf7ad2gw1evu1og7gssj20c80bwgm4.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/72a31574gw1evvgvt0bhfj20ju0emwj2.jpg"];
    }
    return _imageUrlStringArray;
}
@end
