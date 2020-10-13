//
//  TKAFNDemoViewController.m
//  test
//
//  Created by hello on 2020/7/27.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKAFNDemoViewController.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

static NSString *imageUrlString = @"https://s.eoffcn.com/tiku/banner/ipad/3/e1f5eed7c0635d0c625d088f011f9d4c.jpg";

@interface TKAFNDemoViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger count;
@end

@implementation TKAFNDemoViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imageView];
    
//    [self loadImage];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.title = [NSString stringWithFormat:@"count: %@   UUID: %@", @(_count ++), [NSUUID UUID].UUIDString];
    
    [self getMethod];
}

// 测试 AFN加载图片
- (void)loadImage {
    [_imageView setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:nil];
}

// 测试 AFN序列化
- (void)getMethod {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFImageResponseSerializer serializer];
    
    [mgr GET:imageUrlString parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        DLog(@"totalUnitCount: %lld   completedUnitCount: %lld", downloadProgress.totalUnitCount, downloadProgress.completedUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"success.response: %@", responseObject);
        self.imageView.image = (UIImage *)responseObject;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"error: %@", error);
        
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.f, 100.f, self.view.bounds.size.width - 30.f, 150.f)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = UIColor.grayColor;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
@end
