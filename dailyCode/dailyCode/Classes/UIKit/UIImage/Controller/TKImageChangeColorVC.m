//
//  TKImageChangeColorVC.m
//  dailyCode
//
//  Created by hello on 2021/1/13.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKImageChangeColorVC.h"

@interface TKImageChangeColorVC ()

@end

@implementation TKImageChangeColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // bubble_min
    
    CGFloat imgvWidth = 50.f;
    UIImage *originalBubbleImg = [UIImage imageNamed:@"bubble_min"];
    
    // 原始 黑色
    UIImageView *originalImgv = [[UIImageView alloc] initWithImage:originalBubbleImg];
    originalImgv.frame = CGRectMake(100.f, 100.f, imgvWidth, imgvWidth);
    originalImgv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:originalImgv];
    
    // 给image添加 maskColor
    UIImageView *newImgv = [[UIImageView alloc] initWithImage:[originalBubbleImg tk_imageMaskedWithColor:UIColor.redColor]];
    newImgv.frame = CGRectMake(100.f, CGRectGetMaxY(originalImgv.frame) + 20.f, imgvWidth, imgvWidth);
    newImgv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:newImgv];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
