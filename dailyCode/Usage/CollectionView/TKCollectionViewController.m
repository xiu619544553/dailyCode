//
//  TKCollectionViewController.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKCollectionViewController.h"
#import "TKHomeCollectionViewCell.h"
#import "NSString+TKAdd.h"
#import <Masonry.h>

#define KeyForVC   @"vc"
#define KeyForDesc @"desc"

static CGFloat minimumInteritemSpacing = 5.f;
static NSString *homeCellReuseIdentifier = @"TKHomeCollectionViewCell";

@interface TKCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataSource;

@end

@implementation TKCollectionViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.collectionView];
    
    [self setupNav];
    
    [self addNotifications];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.insets(self.view.safeAreaInsets);
        } else {
            make.edges.insets(UIEdgeInsetsZero);
        }
    }];
    [_collectionView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
    Class vcCls = NSClassFromString(dict[KeyForVC]);
    if (!vcCls) return;
    
    UIViewController *vc = [[vcCls alloc] init];
    vc.title = dict[KeyForDesc];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TKHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCellReuseIdentifier forIndexPath:indexPath];
    
    if (self.dataSource.count > indexPath.row) {
        NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
        cell.detail = dict[KeyForDesc];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets inset = [self insetForSection];
    CGFloat itemWidth = (CGRectGetWidth(self.view.frame) - inset.left - inset.right - minimumInteritemSpacing) / 2.f;
    return CGSizeMake(itemWidth, itemWidth * ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 0.3 : 0.8));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self insetForSection];
}

- (UIEdgeInsets)insetForSection {
    return UIEdgeInsetsMake(5.f, 10.f, 5.f, 10.f);
}

#pragma mark - Event Methods

- (void)screenShotAction:(UIBarButtonItem *)sender {
    UIImage *image = [self getScrollImg];

    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        DLog(@"error: %@", error);
    }
    DLog(@"image: %@", image);
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
        [self.collectionView reloadData];
    }];
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 5.f;
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:TKHomeCollectionViewCell.class forCellWithReuseIdentifier:homeCellReuseIdentifier];
    }
    return _collectionView;
}

- (NSArray<NSDictionary<NSString *,NSString *> *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{
                KeyForVC   : @"StudyDocumentInteractionController",
                KeyForDesc : @"学习苹果提供的文档交互控制器"
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
                KeyForVC   : @"AboutLineSpacingViewController",
                KeyForDesc : @"正确设置行间距与行高",
            },
            @{
                KeyForVC   : @"AboutScrollViewLayoutViewController",
                KeyForDesc : @"1.contentInsetAdjustmentBehavior\n2.automaticallyAdjustsScrollViewInsets"
            },
            @{
                KeyForVC   : @"JSONSerializationViewController",
                KeyForDesc : @"json序列化"
            },
            @{
                KeyForVC   : @"AboutScrollViewPropertyController",
                KeyForDesc : @"关于 UIScrollView 的属性的尝试"
            },
            @{
                KeyForVC   : @"LabelViewController",
                KeyForDesc : @"关于 UILabel 的属性的尝试"
            },
            @{
                KeyForVC   : @"GradientLayerViewController",
                KeyForDesc : @"关于 CAGradientLayer 的尝试"
            },
            @{
                KeyForVC   : @"AsyncDecoderImageViewController",
                KeyForDesc : @"关于 【异步解码图片】 的尝试"
            },
            @{
                KeyForVC   : @"TestSuccessViewController",
                KeyForDesc : @"关于 【适配】 的尝试"
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
                KeyForVC   : @"TKSortedViewController",
                KeyForDesc : @"数组中存放 Model，针对 Model的某个属性，对数组排序"
            },
            @{
                KeyForVC   : @"TKScalePropertyViewController",
                KeyForDesc : @"理解 scale 属性"
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

- (UIImage *)getScrollImg {

//    CGPoint savedContentOffset = self.collectionView.contentOffset;
//    CGRect savedFrame = self.collectionView.frame;
    
    UIGraphicsBeginImageContextWithOptions(self.collectionView.contentSize, NO, [UIScreen mainScreen].scale);
    
//    self.contentOffset = CGPointZero;
//    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);

    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *scrollImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

//    self.contentOffset = savedContentOffset;
//    self.frame = savedFrame;

    return scrollImage;
}

@end
