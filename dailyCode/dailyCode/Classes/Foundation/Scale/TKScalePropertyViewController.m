//
//  TKScalePropertyViewController.m
//  test
//
//  Created by hello on 2020/7/28.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKScalePropertyViewController.h"

@interface TKScalePropertyViewController ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) UInt64 totalBytes;
@end

@implementation TKScalePropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"scale: %@", @([UIScreen mainScreen].scale)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // package_new
    // @2x 50x50
    // @3x 75x75
    
    UILabel *scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 100.f, self.view.bounds.size.width - 30.f, 200.f)];
    scaleLabel.backgroundColor = UIColor.cyanColor;
    scaleLabel.numberOfLines = 0;
    [self.view addSubview:scaleLabel];
    
    
    // 估算图片内存大小
    CGSize imageSize = CGSizeMake(self.image.size.width * self.image.scale, self.image.size.height * self.image.scale);
    CGFloat bytesPerPixel = 4.0;
    CGFloat bytesPerSize = imageSize.width * imageSize.height;
    self.totalBytes = (UInt64)bytesPerPixel * (UInt64)bytesPerSize;
    
    
    // 计算图片内存大小
//    NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
    NSData *imageData = UIImagePNGRepresentation(self.image);
    NSUInteger length = imageData.length; // bytes

    
    // text
    scaleLabel.text = [NSString stringWithFormat:@"screen.scale: %@  \nimage.scale: %@  \nimage: %@ bytes   \ntotalBytes: %@ bytes   \ndata.length: %@ bytes", @([UIScreen mainScreen].scale), @(self.image.scale), self.image, @(self.totalBytes), @(length)];
    
    
    // imageView   self.view.bounds.size.width - 20.f
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 75, 75)];
    imageView.image = self.image;
    [self.view addSubview:imageView];
}

- (UIImage *)image {
    if (!_image) {
        _image = [UIImage imageNamed:@"package_new"];
    }
    return _image;
}
@end
