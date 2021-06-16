//
//  TK_asyn_syn_queue_thread_VC.m
//  dailyCode
//
//  Created by hello on 2020/10/28.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TK_asyn_syn_queue_thread_VC.h"

@interface TK_asyn_syn_queue_thread_VC ()
@property (nonatomic, strong) UIButton *asynBtn;
@end

@implementation TK_asyn_syn_queue_thread_VC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self layoutUI];
}

#pragma mark - UI

- (void)layoutUI {
    // 异步布局按钮
    [self.asynBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10.f);
        make.left.equalTo(self.view).offset(30.f);
        make.right.equalTo(self.view).offset(-30.f);
        make.height.mas_equalTo(35.f);
    }];
}

#pragma mark - Event Methods

// 异步子线程布局UI控件
- (void)asyncLayoutUI {
    DLog(@"start -- currentThread == %@", [NSThread currentThread]);
    
    /*
     下列的代码执行，异步子线程中创建UI控件，会有警告：
     
     +[UIView setAnimationsEnabled:] being called from a background thread. Performing any operation from a background thread on UIView or a subclass is not supported and may result in unexpected and insidious behavior. trace=(
         0   UIKitCore                           0x00000001f0ed87f0 <redacted> + 116
         1   libdispatch.dylib                   0x00000001012c8c78 _dispatch_client_callout + 16
         2   libdispatch.dylib                   0x00000001012cac84 _dispatch_once_callout + 84
         3   UIKitCore                           0x00000001f0ed8778 <redacted> + 100
         4   UIKitCore                           0x00000001f0ed88e4 <redacted> + 92
         5   UIKitCore                           0x00000001f0e5bfb4 <redacted> + 368
         6   UIKitCore                           0x00000001f0e5c098 <redacted> + 32
         7   QuartzCore                          0x00000001c895dc08 <redacted> + 332
         8   QuartzCore                          0x00000001c88c03e4 <redacted> + 348
         9   QuartzCore                          0x00000001c88ee620 <redacted> + 640
         10  QuartzCore                          0x00000001c88ef6ec <redacted> + 228
         11  libsystem_pthread.dylib             0x00000001c403c4b4 <redacted> + 580
         12  libsystem_pthread.dylib             0x00000001c4039904 <redacted> + 80
         13  libsystem_pthread.dylib             0x00000001c403a508 pthread_workqueue_setdispatchoffset_np + 0
         14  libsystem_pthread.dylib             0x00000001c403a14c _pthread_wqthread + 360
         15  libsystem_pthread.dylib             0x00000001c403ccd4 start_wqthread + 4
     )
     */
    dispatch_queue_t queue = dispatch_queue_create("test.update.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        DLog(@"asyn -- currentThread == %@", [NSThread currentThread]);
        UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(10.f, 100.f, 100.f, 100.f)];
        testView.backgroundColor = UIColor.redColor;
        [self.view addSubview:testView];
    });
}

#pragma mark - getter

- (UIButton *)asynBtn {
    if (!_asynBtn) {
        _asynBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_asynBtn setTitle:@"异步创建UI控件" forState:UIControlStateNormal];
        [_asynBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _asynBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _asynBtn.backgroundColor = UIColor.cyanColor;
        [self.view addSubview:_asynBtn];
        @weakify(self)
        [_asynBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            DLog(@"currentThread == %@", [NSThread currentThread]);
            [self asyncLayoutUI];
        }];
    }
    return _asynBtn;
}
@end
