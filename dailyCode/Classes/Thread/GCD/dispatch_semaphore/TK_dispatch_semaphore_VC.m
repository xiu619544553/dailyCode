//
//  TK_dispatch_semaphore_VC.m
//  dailyCode
//
//  Created by hello on 2020/12/21.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_dispatch_semaphore_VC.h"

@interface TK_dispatch_semaphore_VC ()

@property (nonatomic, strong) NSMutableArray<NSString *> *imageUrlStringArray;

@end

@implementation TK_dispatch_semaphore_VC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self.imageUrlStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGSize objSize = [[self class] getImageSizeWithURL:obj];
//        NSLog(@"\nobj：%@ - size：%@", obj, NSStringFromCGSize(objSize));
//    }];
    
//    void(^asyncHandler)(int code) = ^(int code) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (asyncHandler) {
//                asyncHandler(200);
//            }
//        });
//    };
}



// 串行队列 + 异步 == 只会开启一个线程，且队列中所有的任务都是在这个线程执行
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"111:%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"222:%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"333:%@",[NSThread currentThread]);
//    });
    
    NSLog(@"...1...");
    [self simulate_Semaphore_AsyncHandler];
    NSLog(@"...2...");
}


// MARK: 模拟器信号量和异步回调组合使用
- (void)simulate_Semaphore_AsyncHandler {
    /*
     创建信号量
     dispatch_semaphore_create
     
     减少信号量的计数，如果结果值小于0，等待到一个signal才会返回，否则会一直等待。
     dispatch_semaphore_wait
     
     增加计数信号量。如果前一个值小于0，这个函数在返回之前唤醒一个等待的线程。
     返回值：如果线程被唤醒，这个函数返回非零值。否则，返回0。
     dispatch_semaphore_signal
     */
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    NSLog(@"...create...");
    [self asynHandler:^(NSString *result) {
        NSLog(@"...signal...");
        intptr_t signalResult = dispatch_semaphore_signal(sema);
        NSLog(@"signalResult=%@", @(signalResult));
        
    }];
    NSLog(@"...wait...");
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)asynHandler:(void(^)(NSString *result))handler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !handler ?: handler(@"200");
    });
}



// 根据图片url获取图片尺寸
+ (CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    __block CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage* image = [UIImage imageWithData:data];
            if(image)
            {
                size = image.size;
            }
            dispatch_semaphore_signal(semaphore);//发送信号
            
        }];
        [dataTask resume];
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
    }
    return size;
}
//  获取PNG图片的大小
+ (CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    __block NSData *data;
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable imageData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        data = imageData;
        dispatch_semaphore_signal(semaphore);//发送信号
    }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
    
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+ (CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    __block NSData *data;
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable imageData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        data = imageData;
        dispatch_semaphore_signal(semaphore);//发送信号
    }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
    
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+ (CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    __block NSData *data;
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable imageData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        data = imageData;
        NSLog(@"\nurl：%@ - length：%@", request.URL.absoluteString, @(imageData.length));
        dispatch_semaphore_signal(semaphore);//发送信号
    }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

#pragma mark - geter

- (NSMutableArray<NSString *> *)imageUrlStringArray {
    if (!_imageUrlStringArray) {
        _imageUrlStringArray = [NSMutableArray array];
        
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/6fc6f04egw1evuciu6zqlj20hs0vkab3.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/61e89358jw1evvyskb8p7j20hs1030xf.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/48e3f28djw1evvhkx7o7pj20m211cqaz.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/9a099b04gw1evvzlou4tmj20yi0rsgt7.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/6204ece1gw1evvzh9bp37j20fa08yjt5.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/6204ece1gw1evvzegkumsj20k069f4hm.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/8aca58f7jw1evvz55yls6j20a00gmt9j.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/648ac377gw1evvb5p5racj20kg0p07eo.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/648ac377gw1evvb6bwk53j20kg0o7q8n.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/648ac377gw1evvb638ctyj20jg0qon80.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/648ac377gw1evvb64986kj20ke0qo79q.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/648ac377gw1evvb5q5xw9j20k50qo7ar.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/648ac377gw1evvb671w2nj20kg0pugvo.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/648ac377gw1evvb6917s9j20kg0qdwkm.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/648ac377gw1evvb69y6z0j20kg0ox0y5.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/648ac377gw1evvb61yq07j20kg0q8wqx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/648ac377gw1evvb61yq07j20kg0q8wqx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/53899d01jw1evvzifd52yj20go0hmtdn.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/53899d01jw1evvzifd52yj20go0hmtdn.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/ebebae87jw1evvh9eq0yfj22io1w01kx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/wap720/ebebae87jw1evvh9eq0yfj22io1w01kx.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/e4ff1178jw1evvzh59ob7j20fe0kj0u7.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/woriginal/e4ff1178jw1evvzh59ob7j20fe0kj0u7.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/61e64a12jw1evvd94nontj20c849s4kd.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/woriginal/61e64a12jw1evvd94nontj20c849s4kd.jpg"];
        [_imageUrlStringArray addObject:@"http://ww4.sinaimg.cn/large/9ccc7942gw1evv44oqlzfj20m81sh10n.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/9ccc7942gw1evv44nc2jyj20m80xc7bp.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/woriginal/9ccc7942gw1evv44nc2jyj20m80xc7bp.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44mbb7aj20m80xcqcg.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/9ccc7942gw1evv44mbb7aj20m80xcqcg.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/9ccc7942gw1evv44s8we7j20m80xcwk2.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/woriginal/9ccc7942gw1evv44s8we7j20m80xcwk2.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44oe5drj20m81shaiu.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/woriginal/9ccc7942gw1evv44oe5drj20m81shaiu.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44p7q6ij20m82bcdqv.jpg"];
        [_imageUrlStringArray addObject:@"http://ww1.sinaimg.cn/large/9ccc7942gw1evv44u88hwj20m80xc7ac.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/9ccc7942gw1evv44lb7ncj20m80xc45f.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/9ccc7942gw1evv44tcuxhj20m80xcdob.jpg"];
        [_imageUrlStringArray addObject:@"http://ww2.sinaimg.cn/large/c2bf7ad2gw1evu1og7gssj20c80bwgm4.jpg"];
        [_imageUrlStringArray addObject:@"http://ww3.sinaimg.cn/large/72a31574gw1evvgvt0bhfj20ju0emwj2.jpg"];
    }
    return _imageUrlStringArray;
}
@end
