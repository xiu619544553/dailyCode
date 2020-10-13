//
//  AsyncDecoderCell.m
//  test
//
//  Created by hello on 2020/6/17.
//  Copyright © 2020 TK. All rights reserved.
//

#import "AsyncDecoderCell.h"
#import "SDWebImage.h"

@interface AsyncDecoderCell ()
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImageView *imgv;
@property (nonatomic, strong) UILabel *urlNameLabel;
@end

@implementation AsyncDecoderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.imgv];
        [self.contentView addSubview:self.urlNameLabel];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ - 销毁了", NSStringFromClass(self.class));
}

#pragma mark - setter

- (void)setImageUrlString:(NSString *)imageUrlString {
    _imageUrlString = imageUrlString;
    
    _urlNameLabel.text = imageUrlString;
    
    // 主线程解码
//    [_imgv sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:self.placeholderImage];
    
    
    
    
    // 异步解码
    __weak typeof(_imgv) wImgv = _imgv;
    [_imgv sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                           placeholderImage:self.placeholderImage
                                    options:SDWebImageAvoidAutoSetImage
                                  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong typeof(wImgv) sImgv = wImgv;
        if (image) {
            __block UIImage *img = image;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 异步解码，导入 SDWebImageDecoder.h
                img = [UIImage sd_decodedImageWithImage:image];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (sImgv) {
                        sImgv.image = image;
                        
                        CATransition *transition = [CATransition animation];
                        transition.duration = 0.15;
                        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                        transition.type = kCATransitionFade;
                        [sImgv.layer addAnimation:transition forKey:@"contents"];
                    }
                });
            });
        }
    }];
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
