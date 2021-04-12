//
//  TKUsageListViewController.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//


#import "TKUsageListViewController.h"

static NSString *homePageCellReuseIdentifier = @"UITableViewCell";

@interface TKUsageListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataSource;

@end

@implementation TKUsageListViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    
    [self setupNav];
    
    [self addNotifications];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.insets(self.view.safeAreaInsets);
        } else {
            make.edges.insets(UIEdgeInsetsZero);
        }
    }];
    [_tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (@available(iOS 11.0, *)) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [feedBackGenertor prepare];
        [feedBackGenertor impactOccurred];
    }
//    // iOS10以前  系统振动加铃声的 用户体验不是很好
//     //导入：#import <AudioToolbox/AudioToolbox.h>
//    //在需要出发震动的地方写上代码：
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//默认震动效果
//    //如果想要其他震动效果，可参考：
//    // 普通短震，3D Touch 中 Pop 震动反馈
//    AudioServicesPlaySystemSound(1520);
//    // 普通短震，3D Touch 中 Peek 震动反馈
//    AudioServicesPlaySystemSound(1519);
//    // 连续三次短震
//    AudioServicesPlaySystemSound(1521);
    
    NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
    Class vcCls = NSClassFromString(dict[KeyForVC]);
    if (!vcCls) return;
    
    UIViewController *vc = [[vcCls alloc] init];
    vc.title = dict[KeyForDesc];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageCellReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homePageCellReuseIdentifier];
    }
    
    if (self.dataSource.count > indexPath.row) {
        NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = dict[KeyForDesc];
    }
    
    return cell;
}

#pragma mark - 截图

- (void)screenShotAction:(UIBarButtonItem *)sender {
    UIImage *image = [self getScrollImg];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        DLog(@"error: %@", error);
    }
    DLog(@"image: %@", image);
}

- (UIImage *)getScrollImg {
    UIGraphicsBeginImageContextWithOptions(self.tableView.contentSize, NO, [UIScreen mainScreen].scale);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *scrollImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scrollImage;
}

#pragma mark - Private Methods

- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemSave) target:self action:@selector(screenShotAction:)];
}

- (void)addNotifications {
    __weak typeof(self) wself = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(wself) sself = wself;
        if (!sself) return;
        [self.tableView reloadData];
    }];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray<NSDictionary<NSString *,NSString *> *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"StudyDocumentInteractionController",
                KeyForDesc : @"文档交互控制器 UIDocumentInteractionController"
            },
            @{
                KeyForVC   : @"WebViewController",
                KeyForDesc : @"WKWebView"
            },
            @{
                KeyForVC   : @"ResponderChainViewController",
                KeyForDesc : @"响应者链、hit-test机制"
            },
            @{
                KeyForVC   : @"AboutScrollViewLayoutViewController",
                KeyForDesc : @"1.contentInsetAdjustmentBehavior 2.automaticallyAdjustsScrollViewInsets"
            },
            @{
                KeyForVC   : @"LabelViewController",
                KeyForDesc : @"关于 UILabel 的属性的尝试"
            },
            @{
                KeyForVC   : @"GradientLayerViewController",
                KeyForDesc : @"渐变色 CAGradientLayer 的尝试"
            },
            @{
                KeyForVC   : @"AsyncDecoderImageViewController",
                KeyForDesc : @"关于 【异步解码图片】 的尝试"
            },
            @{
                KeyForVC   : @"TreeTableViewController",
                KeyForDesc : @"关于 【多级cell】 的尝试"
            },
            @{
                KeyForVC   : @"TKRegularViewController",
                KeyForDesc : @"正则表达式"
            },
            @{
                KeyForVC   : @"OptionalViewController",
                KeyForDesc : @"NS_OPTIONS 与 NS_ENUM 区别"
            },
            @{
                KeyForVC   : @"LayoutViewController",
                KeyForDesc : @"layoutSubViews 调用时机"
            },
            @{
                KeyForVC   : @"AboutAlertViewController",
                KeyForDesc : @"AlertViewController 在 iPad中的使用"
            },
            @{
                KeyForVC   : @"MasonryUsageViewController",
                KeyForDesc : @"Masonry 的使用"
            },
            @{
                KeyForVC   : @"ShadowVC",
                KeyForDesc : @"shadow 阴影"
            },
            @{
                KeyForVC   : @"TKMacroViewController",
                KeyForDesc : @"常见宏使用"
            },
            @{
                KeyForVC   : @"TKAutolayoutViewController",
                KeyForDesc : @"自动布局cell"
            },
            @{
                KeyForVC   : @"TKAFNDemoViewController",
                KeyForDesc : @"AFNetworking"
            },
            @{
                KeyForVC   : @"TKSDWebImageUsageViewController",
                KeyForDesc : @"SDWebImage"
            },
            @{
                KeyForVC   : @"TKImagePickerController",
                KeyForDesc : @"UIImagePickerController 使用、旋转等等"
            },
            @{
                KeyForVC   : @"TKTextViewController",
                KeyForDesc : @"UITextView 使用"
            },
            @{
                KeyForVC   : @"TKButtonUsageViewController",
                KeyForDesc : @"Button 使用"
            },
            @{
                KeyForVC   : @"TKColorUsageViewController",
                KeyForDesc : @"Color 使用"
            },
            @{
                KeyForVC   : @"TKBackgroundTaskVC",
                KeyForDesc : @"后台任务"
            },
            @{
                KeyForVC   : @"TKCollectionViewController",
                KeyForDesc : @"UICollectionView 使用"
            },
            @{
                KeyForVC   : @"TKFeedbackGeneratorViewController",
                KeyForDesc : @"震动反馈 API"
            },
            @{
                KeyForVC   : @"TKScrollViewViewController",
                KeyForDesc : @"UIScrollView 使用"
            },
            @{
                KeyForVC   : @"TKPageManagerViewController",
                KeyForDesc : @"WMPageController 使用"
            },
            @{
                KeyForVC   : @"TKUIViewCategoryUsageViewController",
                KeyForDesc : @"UIView分类用法"
            }
        ];
    }
    return _dataSource;
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
}
@end
