//
//  TKThreadCaseVC.m
//  dailyCode
//
//  Created by hello on 2021/6/16.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKThreadCaseVC.h"
#import "TKAccount.h"
#import "TKSafeAccount.h"

@interface TKThreadCaseVC ()

@end

@implementation TKThreadCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)usageBtnAction:(UIButton *)sender {
    NSLog(@"================START=================\n%@", sender.titleLabel.text);
    
    if (sender.tag == 1) {
        
        TKAccount *account = [TKAccount new];
        [account moneyTest];
        /*
         输出日志：
         2021-06-16 14:31:00.121599+0800 iOSDemo[25424:243607] 取20元，还剩80元 - <NSThread: 0x6000007a6140>{number = 13, name = (null)}
         2021-06-16 14:31:00.121599+0800 iOSDemo[25424:243549] 存10元，还剩110元 - <NSThread: 0x60000079ef40>{number = 12, name = (null)}
         2021-06-16 14:31:00.121742+0800 iOSDemo[25424:243607] 取20元，还剩60元 - <NSThread: 0x6000007a6140>{number = 13, name = (null)}
         2021-06-16 14:31:00.121748+0800 iOSDemo[25424:243549] 存10元，还剩70元 - <NSThread: 0x60000079ef40>{number = 12, name = (null)}
         2021-06-16 14:31:00.121989+0800 iOSDemo[25424:243607] 取20元，还剩50元 - <NSThread: 0x6000007a6140>{number = 13, name = (null)}
         2021-06-16 14:31:00.122356+0800 iOSDemo[25424:243549] 存10元，还剩60元 - <NSThread: 0x60000079ef40>{number = 12, name = (null)}
         2021-06-16 14:31:00.122600+0800 iOSDemo[25424:243607] 取20元，还剩40元 - <NSThread: 0x6000007a6140>{number = 13, name = (null)}
         2021-06-16 14:31:00.122811+0800 iOSDemo[25424:243549] 存10元，还剩50元 - <NSThread: 0x60000079ef40>{number = 12, name = (null)}
         2021-06-16 14:31:00.122941+0800 iOSDemo[25424:243607] 取20元，还剩30元 - <NSThread: 0x6000007a6140>{number = 13, name = (null)}
         2021-06-16 14:31:00.123187+0800 iOSDemo[25424:243549] 存10元，还剩40元 - <NSThread: 0x60000079ef40>{number = 12, name = (null)}
         
         分析：-moneyTest，不同线程执行存取钱操作，导致出现了脏数据
         */
        
    } else if (sender.tag == 2) {
        
        TKSafeAccount *safeA = [[TKSafeAccount alloc] init];
        [safeA moneyTest];
        
        /*
         输出日志：
         2021-06-16 14:43:49.010013+0800 iOSDemo[26755:253446] 取20元，还剩80元 - <NSThread: 0x6000010ccc80>{number = 9, name = (null)}
         2021-06-16 14:43:49.010189+0800 iOSDemo[26755:253786] 存10元，还剩90元 - <NSThread: 0x6000010cd6c0>{number = 10, name = (null)}
         2021-06-16 14:43:49.010342+0800 iOSDemo[26755:253446] 取20元，还剩70元 - <NSThread: 0x6000010ccc80>{number = 9, name = (null)}
         2021-06-16 14:43:49.010604+0800 iOSDemo[26755:253786] 存10元，还剩80元 - <NSThread: 0x6000010cd6c0>{number = 10, name = (null)}
         2021-06-16 14:43:49.010880+0800 iOSDemo[26755:253446] 取20元，还剩60元 - <NSThread: 0x6000010ccc80>{number = 9, name = (null)}
         2021-06-16 14:43:49.011202+0800 iOSDemo[26755:253786] 存10元，还剩70元 - <NSThread: 0x6000010cd6c0>{number = 10, name = (null)}
         2021-06-16 14:43:49.011674+0800 iOSDemo[26755:253446] 取20元，还剩50元 - <NSThread: 0x6000010ccc80>{number = 9, name = (null)}
         2021-06-16 14:43:49.011963+0800 iOSDemo[26755:253786] 存10元，还剩60元 - <NSThread: 0x6000010cd6c0>{number = 10, name = (null)}
         2021-06-16 14:43:49.012407+0800 iOSDemo[26755:253446] 取20元，还剩40元 - <NSThread: 0x6000010ccc80>{number = 9, name = (null)}
         2021-06-16 14:43:49.012782+0800 iOSDemo[26755:253786] 存10元，还剩50元 - <NSThread: 0x6000010cd6c0>{number = 10, name = (null)}
         
         分析：-moneyTest，针对存、取操作加了线程锁，这样就保证数据的一致性。最终达到了预期效果
         */
    }
}

#pragma mark - Life Cycle

- (void)setupViews {
    CGFloat btnWidth = self.view.width - 20.f;
    UIButton *usageBtn1 = [self addBtnsTag:1
                                     frame:CGRectMake(10.f, 100.f, btnWidth, 50.f)
                                     title:@"存取钱案例：允许不同线程同时操作存钱与取钱操作"];
    
    UIButton *usageBtn2 = [self addBtnsTag:2
                                     frame:CGRectMake(10.f, CGRectGetMaxY(usageBtn1.frame) + 20.f, btnWidth, 35.f)
                                     title:@"存取钱案例：对存钱与取钱的操作加锁"];
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
