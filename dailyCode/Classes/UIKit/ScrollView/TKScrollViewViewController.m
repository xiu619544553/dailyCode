//
//  TKScrollViewViewController.m
//  dailyCode
//
//  Created by hello on 2020/9/21.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKScrollViewViewController.h"

@interface TKScrollViewViewController ()
@property (nonatomic, strong) UIImageView *imageView; // tk_long_icon
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation TKScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    
    
    // 截图
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截图" style:(UIBarButtonItemStyleDone) target:self action:@selector(snapshotAction:)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    
    
    CGSize imageSize = self.imageView.image.size;
    CGFloat contentH = self.view.width / imageSize.width * imageSize.height;
    
    
    self.imageView.frame = CGRectMake(0.f, 0.f, self.view.width, contentH);
    self.scrollView.contentSize = CGSizeMake(self.view.width, contentH);
}

#pragma mark - Event Methods

- (void)snapshotAction:(UIBarButtonItem *)sender {
    
    UIImage *shareImage = [self.scrollView.layer snapshotImage];
    DLog(@"\nshareImage info: %@", shareImage);
    
    UIImage *image = [self snapshotImageWithView:self.scrollView size:self.scrollView.contentSize];
    DLog(@"\nimage info: %@", image);
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    DLog(@"\nimage info: %@，\nerror: %@", image, error);
}

- (UIImage *)snapshotImageWithView:(UIView *)view size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, view.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tk_long_icon"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
@end
