//
//  TKSDWebImageUsageViewController.m
//  test
//
//  Created by hello on 2020/7/30.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKSDWebImageUsageViewController.h"
#import "SDWebImage.h"

static NSString *imageUrlString = @"https://s.eoffcn.com/tiku/banner/ipad/3/e1f5eed7c0635d0c625d088f011f9d4c.jpg";

@interface TKSDWebImageUsageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TKSDWebImageUsageViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSURL *url = [NSURL URLWithString:imageUrlString];
    [self.imageView sd_setImageWithURL:url
                             completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        DLog(@"\nimage: %@  \ncacheType: %ld   \nurl: %@", image, cacheType, imageURL.absoluteString);
    }];
}
@end
