//
//  TKSortedViewController.m
//  test
//
//  Created by hello on 2020/7/27.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKSortedViewController.h"
#import "TKSortedModel.h"

@interface TKSortedViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TKSortedViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textView.frame = CGRectMake(10.f, 50.f, self.view.bounds.size.width - 20.f, self.view.bounds.size.height - 60.f);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray <TKSortedModel*> *sortedImages = [NSMutableArray array];
    for (int i = 0; i < 100000; i ++) {
        TKSortedModel *model = [TKSortedModel new];
        model.name = [NSString stringWithFormat:@"name: %d", i];
        model.number = arc4random() % 100;
        [sortedImages addObject:model];
    }
    
    kTICK
    // 排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    [sortedImages sortUsingDescriptors:@[sortDescriptor]];
    kTOCK
    
    
    NSMutableString *muString = [NSMutableString string];
    [sortedImages enumerateObjectsUsingBlock:^(TKSortedModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [muString appendString:[NSString stringWithFormat:@"%d\n", obj.number]];
    }];
    
    self.textView.text = muString;
}


#pragma mark - 随机数

- (void)testRandow {
    // 获取一个随机整数范围在：[0,100)包括0，不包括100
    uint32_t random1 = arc4random() % 100;
    NSLog(@"random1: %@", @(random1));
    
    // [100,200]随机数
    uint32_t random2 = 100 + arc4random() % 101;
    NSLog(@"random2: %@", @(random2));
}

// 获取一个随机整数，范围在[from,to]，包括from，包括to
- (uint32_t)getRandomNumber:(uint32_t)from to:(uint32_t)to {
    return (from + arc4random() % (to - from + 1));
}


/// 生成随机数
/// @param from            左区间
/// @param to              右区间
/// @param isContainFrom   左区间是否为闭区间。YES闭区间，NO开区间
/// @param isContainFromTo 右区间是否为闭区间。YES闭区间，NO开区间
- (uint32_t)getRandomNumber:(uint32_t)from to:(uint32_t)to isContainFrom:(BOOL)isContainFrom isContainFromTo:(BOOL)isContainFromTo {
    
    if (from >= to) return -1;
    
    uint32_t base = isContainFrom ? from : (from + 1);
    uint32_t diff = isContainFromTo ? 1 : 0;
    
    return (base + arc4random() % (to - from + diff));
}

#pragma mark - getter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.textColor = UIColor.systemPinkColor;
        _textView.font = [UIFont systemFontOfSize:13.f];
        _textView.editable = NO;
        _textView.layer.borderColor = UIColor.blackColor.CGColor;
        _textView.layer.borderWidth = 1.f/([UIScreen mainScreen].scale);
    }
    return _textView;
}
@end
