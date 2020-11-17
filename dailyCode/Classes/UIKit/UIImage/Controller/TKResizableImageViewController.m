//
//  TKResizableImageViewController.m
//  dailyCode
//
//  Created by hello on 2020/11/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKResizableImageViewController.h"

@interface TKResizableImageViewController ()

@end

@implementation TKResizableImageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *ipadImg = [UIImage imageNamed:@"questionReportBg"];
    CGFloat wh = ipadImg.size.width / ipadImg.size.height;
    
    CGFloat padding = 10.f;
    CGFloat ipadImgVW = self.view.width / 2.f - 2 * padding;
    CGFloat ipadImgVH = ipadImgVW / wh;
    
    
    UIImageView *ipadImgV = [[UIImageView alloc] initWithImage:ipadImg];
    ipadImgV.frame = CGRectMake(padding, 100.f, ipadImgVW, ipadImgVH);
    ipadImgV.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:ipadImgV];
    
    
    
    UIImage *resizableImage = [self resizableImageNamed:@"questionReportBg"];
    
    NSLog(@"\noriginSize = %@  \nresizableSize = %@", NSStringFromCGSize(ipadImg.size), NSStringFromCGSize(resizableImage.size));
    
    UIImageView *ipadImgV2 = [[UIImageView alloc] initWithImage:resizableImage];
    ipadImgV2.frame = CGRectMake(CGRectGetMaxX(ipadImgV.frame) + padding, 100.f, ipadImgVW, ipadImgVH);
    ipadImgV2.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:ipadImgV2];
}

- (UIImage *)resizableImageNamed:(NSString *)imageName {
    if (imageName && imageName.length > 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        CGFloat width = image.size.width * 0.5f;
        CGFloat height = image.size.height * 0.5f;
        return [image resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width) resizingMode:UIImageResizingModeTile];
    }
    return nil;
}

@end
