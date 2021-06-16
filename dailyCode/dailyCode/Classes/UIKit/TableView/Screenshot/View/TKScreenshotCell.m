//
//  TKScreenshotCell.m
//  dailyCode
//
//  Created by hello on 2021/4/7.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKScreenshotCell.h"
#import "SDWebImage.h"

@interface TKScreenshotCell ()
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImageView *imgv;
@property (nonatomic, strong) UILabel *urlNameLabel;
@end

@implementation TKScreenshotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgv];
        [self.contentView addSubview:self.urlNameLabel];
    }
    return self;
}

#pragma mark - setter

- (void)setImageUrlString:(NSString *)imageUrlString {
    _imageUrlString = imageUrlString;
    
    _urlNameLabel.text = imageUrlString;
    
    // MARK: 主线程解码
    [_imgv sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:self.placeholderImage];
    [_imgv sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:self.placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"image: %@", image);
    }];
    
//    // 异步解码
//    __weak typeof(_imgv) wImgv = _imgv;
//    [_imgv sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
//                           placeholderImage:self.placeholderImage
//                                    options:SDWebImageAvoidAutoSetImage
//                                  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        __strong typeof(wImgv) sImgv = wImgv;
//        if (image) {
//            __block UIImage *img = image;
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                // 异步解码，导入 SDWebImageDecoder.h
//                img = [UIImage sd_decodedImageWithImage:image];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (sImgv) {
//                        sImgv.image = image;
//
//                        CATransition *transition = [CATransition animation];
//                        transition.duration = 0.15;
//                        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//                        transition.type = kCATransitionFade;
//                        [sImgv.layer addAnimation:transition forKey:@"contents"];
//                    }
//                });
//            });
//        }
//    }];
}

#pragma mark - getter

- (UILabel *)urlNameLabel {
    if (!_urlNameLabel) {
        _urlNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 10.f, [UIScreen mainScreen].bounds.size.width - 20.f, 40.f)];
        _urlNameLabel.font = [UIFont systemFontOfSize:15.f];
        _urlNameLabel.numberOfLines = 0;
    }
    return _urlNameLabel;
}

- (UIImageView *)imgv {
    if (!_imgv) {
        _imgv = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, CGRectGetMaxY(self.urlNameLabel.frame) + 10.f, CGRectGetWidth(self.urlNameLabel.frame), 240.f)];
        _imgv.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgv;
}

- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        _placeholderImage = [UIImage imageNamed:@"default_icon"];
    }
    return _placeholderImage;
}
@end
