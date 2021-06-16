//
//  TK_dispatch_semaphore_VC.m
//  dailyCode
//
//  Created by hello on 2020/12/21.
//  Copyright © 2020 TK. All rights reserved.
//  https://blog.csdn.net/a18339063397/article/details/82663788
//  https://mp.weixin.qq.com/s/9s-lXQ36mPChVfWoTGXtlA

#import "TK_dispatch_semaphore_VC.h"

@interface TK_dispatch_semaphore_VC ()

@property (nonatomic, strong) NSMutableArray<NSString *> *imageUrlStringArray;

@property (strong, nonatomic) dispatch_semaphore_t dataSourceLock;
@property (nonatomic, strong) NSMutableDictionary *dataSources;

@end

@implementation TK_dispatch_semaphore_VC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupViews];
    
    //    [self.imageUrlStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        CGSize objSize = [[self class] getImageSizeWithURL:obj];
    //        NSLog(@"\nobj：%@ - size：%@", obj, NSStringFromCGSize(objSize));
    //    }];
}

#pragma mark - Event Methods

- (void)usageBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    NSInteger tag = sender.tag;
    
    switch (tag) {
        case 1:
            [self dispatch_semaphore_simple_usage];
            break;
            
        case 2:
            // 设置线程并发数
            [self setThreadConcurrentCount];
            break;
            
        default:
            break;
    }
}

#pragma mark - dispatch_semaphore 简单用法

- (void)dispatch_semaphore_simple_usage {
    // 当两个线程需要协调特定事件的完成时，传递0值非常有用。传递一个大于0的值对于管理有限的资源池非常有用，其中资源池大小等于这个值。
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    for (int i = 0; i < 10; i ++) {
        [self asynDuration:1 handler:^{
            NSLog(@"%@ - %@", @(i), [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        }];
    }
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

#pragma mark - 控制线程并发数

// 设置线程并发数
- (void)setThreadConcurrentCount {
    // 当两个线程需要协调特定事件的完成时，传递0值非常有用。传递一个大于0的值对于管理有限的资源池非常有用，其中资源池大小等于这个值。
    // 假定：期望最多开辟2个子线程
    dispatch_semaphore_t dsema = dispatch_semaphore_create(2);
    
    // 任务1
    [self asynDuration:1 handler:^{
        dispatch_semaphore_signal(dsema);
        NSLog(@"任务1 - %@", [NSThread currentThread]);
    }];
    dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
    
    // 任务2
    [self asynDuration:1 handler:^{
        dispatch_semaphore_signal(dsema);
        NSLog(@"任务2 - %@", [NSThread currentThread]);
    }];
    dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
    
    // 任务3
    [self asynDuration:1 handler:^{
        dispatch_semaphore_signal(dsema);
        NSLog(@"任务3 - %@", [NSThread currentThread]);
    }];
    dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
}

- (void)asynDuration:(int)duration
             handler:(void(^)(void))handler {
    dispatch_async(dispatch_queue_create("com.test", 0), ^{
        sleep(duration);
        !handler ?: handler();
    });
}

// 串行队列 + 异步 == 只会开启一个线程，且队列中所有的任务都是在这个线程执行
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // MARK: 模拟器信号量和异步回调组合使用
    NSLog(@"...1...");
    //    [self simulate_Semaphore_AsyncHandler];
    NSLog(@"...2...");
    
    // MARK: 设置最大并发数
    //    [self setMaxCount:1];
}

#pragma mark - 信号量 - 设置最大并发数

- (void)setMaxCount:(NSInteger)max {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(max);
    for (int i = 0; i < 30; i ++) {
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(globalQueue, ^{
            dispatch_semaphore_signal(semaphore);
            NSLog(@"i=%d", i);
        });
    }
}

#pragma mark - 模拟器信号量和异步回调组合使用
- (void)simulate_Semaphore_AsyncHandler {
    /*
     dispatch_semaphore_create：创建信号量
     
     dispatch_semaphore_wait：减少信号量的计数，如果结果值小于0，等待到一个signal才会返回，否则会一直等待。
     
     dispatch_semaphore_signal：增加计数信号量。如果前一个值小于0，这个函数在返回之前唤醒一个等待的线程。
     返回值：如果线程被唤醒，这个函数返回非零值。否则，返回0。
     */
    
    
    /*
     注意❌
     阻塞当前线程
     dispatch_semaphore_create(0);
     dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
     
     最后执行 dispatch_semaphore_signal 无效，因为当前线程已阻塞
     */
    
    
    
    /*
     ✅正确使用方式1：
     
     阻塞当前线程
     dispatch_semaphore_create(0);
     dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
     
     异步执行调用 dispatch_semaphore_signal，唤醒已被阻塞的线程
     */
    [self semaphore_style_1];
    
    /*
     ✅正确使用方式2：
     可以作为线程锁使用：当我们操作可变集合时，使用这种方式添加锁，保证集合不会出现脏数据
     */
    //    [self semaphore_style_2];
}

#pragma mark - dispatch_semaphore_create(1) - Lock

- (void)semaphore_style_2 {
    static dispatch_semaphore_t semaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self.dataSources setObject:@"xxx" forKey:@"aaa"];
    dispatch_semaphore_signal(semaphore);
    
    NSLog(@"%s", __func__);
}

#pragma mark - dispatch_semaphore_create(0)

- (void)semaphore_style_1 {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [self asynHandler:^(long long result) { // 异步调用，解除阻塞的线程
        NSLog(@"result=%@", @(result));
        
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

// 异步调用 dispatch_semaphore_signal
- (void)asynHandler:(void(^)(long long result))handler {
    dispatch_async(dispatch_queue_create("com.tank", 0), ^{
        long long i = 0;
        for (i = 0; i < 5000 ; i ++) {
            NSLog(@"i=%@", @(i));
        }
        !handler ?: handler(i);
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

- (NSMutableDictionary *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableDictionary dictionary];
    }
    return _dataSources;
}

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

- (void)setupViews {
    CGFloat btnWidth = self.view.width - 20.f;
    UIButton *usageBtn1 = [self addBtnsTag:1
                                     frame:CGRectMake(10.f, 100.f, btnWidth, 35.f)
                                     title:@"dispatch_semaphore 简单用法"];
    
    UIButton *usageBtn2 = [self addBtnsTag:2
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn1.frame) + 20.f, btnWidth, 35.f)
                                     title:@"控制最大线程并发数"];
    
    // 设置最大并发数
    CGFloat threadCountTFW = 130.f;
    UITextField *threadCountTF = [[UITextField alloc] initWithFrame:CGRectMake(10.f, CGRectGetMaxY(usageBtn2.frame) + 20.f, threadCountTFW, 35.f)];
    threadCountTF.placeholder = @"设置最大并发数";
    threadCountTF.font = [UIFont systemFontOfSize:15.f];
    threadCountTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:threadCountTF];
    
    [self addBtnsTag:3
               frame:CGRectMake(threadCountTF.right + 10.f, threadCountTF.top, self.view.width - threadCountTF.right - 10.f, 35.f)
               title:@"设置最大并发数"];
}

- (UIButton *)addBtnsTag:(NSInteger)tag
                   frame:(CGRect)frame
                   title:(NSString *)title {
    UIButton *usageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    usageBtn.frame = frame;
    usageBtn.tag = tag;
    usageBtn.backgroundColor = UIColor.blackColor;
    usageBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    usageBtn.titleLabel.numberOfLines = 0;
    
    [usageBtn setTitle:title
              forState:UIControlStateNormal];
    
    [usageBtn setTitleColor:UIColor.whiteColor
                   forState:UIControlStateNormal];
    
    [usageBtn addTarget:self
                 action:@selector(usageBtnAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:usageBtn];
    return usageBtn;
}
@end
