//
//  ViewController.m
//  test
//
//  Created by hello on 2020/5/18.
//  Copyright © 2020 TK. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "NSString+TKAdd.h"
#import "DetailViewController.h"


#import <WebKit/WebKit.h>
#import <Masonry.h>

#define kWRandomColor [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1]

@interface ViewController ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.orangeColor;
    
//    [self compareNumber];
//    [self compareString];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


    DetailViewController *detailVc = [DetailViewController new];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)learn_ContentHuggingPriority_CompressionResistancePriority {
    UILabel *oneLabel = [UILabel new];
    oneLabel.text = @"西瓜西瓜西瓜西瓜西瓜西瓜西瓜西瓜西瓜西瓜西瓜西瓜";
    oneLabel.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:oneLabel];
    
    
    UILabel *twoLabel = [UILabel new];
    twoLabel.text = @"苹果";
    twoLabel.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:twoLabel];
        
        
    // 情景1：设置oneLabel与two等宽，外边距为10
//    CGFloat margin = 10.f;
//    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(200);
//        make.left.equalTo(self.view).offset(margin);
//        make.right.equalTo(twoLabel.mas_left).offset(-margin);
//        make.width.mas_equalTo(twoLabel.mas_width);
//    }];
//    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(oneLabel);
//        make.right.equalTo(self.view).offset(-margin);
//        make.left.equalTo(oneLabel.mas_right).offset(margin);
//        make.width.mas_equalTo(oneLabel.mas_width);
//    }];
    
    // 情景2：需要考虑2种情况，左右2边数据均不足的时候，谁拉伸？左右2边数据均充足的时候，谁收缩？
    // 默认情况下: HuggingPriority == 250,  CompressionResistancePriority == 750

    CGFloat margin = 10.f;
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.left.equalTo(self.view).offset(margin);
        make.right.equalTo(twoLabel.mas_left).offset(-margin);
    }];
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneLabel);
        make.left.equalTo(oneLabel.mas_right).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
    }];
    
    
    // 情景2：左右两边数据均不足的时候，谁拉伸？
//    [oneLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    // 情景3：左右两边数据均充足的时候，谁收缩
//    [twoLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

// systemLayoutSizeFittingSize 学习
- (void)learn_SystemLayoutSizeFittingSize {
    // Returns the optimal size of the view based on its current constraints.
    // 根据当前的约束返回视图的最优大小。给定约束后
    // - (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
    UIView *containerView = [UIView new];
    containerView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:containerView];
    _containerView = containerView;
    
    UILabel *subLabel = [UILabel new];
    subLabel.text = @" 根据当前的约束返回视图的最优大小";
    [containerView addSubview:subLabel];
    
    /***************** 设置约束 ****************/
    // 设置 containerView 的的左右约束
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(100);
    }];
    // 设置 subLabel 的约束，让其撑起 containerView，内边距是10
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    
    /***************** systemLayoutSizeFittingSize 的使用 ****************/
    // 此时获取containerView的frame，拿到的是 {{0, 0}, {0, 0}}。因为此时还没有计算containerView的frame
    NSLog(@"前：containerView.frame : %@", NSStringFromCGRect(containerView.frame));
    
    // 使用 systemLayoutSizeFittingSize 函数，系统可以根据当前的约束返回视图的最优大小。与最终结果是一致的。
    CGSize containerSize = [containerView systemLayoutSizeFittingSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    NSLog(@"containerSize : %@", NSStringFromCGSize(containerSize));
    
    
    [containerView systemLayoutSizeFittingSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                 withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel
                       verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    
    
    // 此时获取containerView的frame，拿到的是 {{0, 0}, {0, 0}}。因为此时还没有计算containerView的frame
    NSLog(@"后：containerView.frame : %@", NSStringFromCGRect(containerView.frame));
}

#pragma mark - 视图布局完成
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    NSLog(@"viewDidLayoutSubviews：containerView.frame : %@", NSStringFromCGRect(_containerView.frame));
}



#pragma mark - 排序
- (void)compareNumber {
    
    // 降序
    NSArray<NSNumber *> *testArray = @[@1,@5,@2,@6,@3,@7,@9];
    
    NSArray *sortedArray = [testArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber   * _Nonnull obj1, NSNumber * _Nonnull obj2) {
        // 因为不满足sortedArrayUsingComparator方法的默认排序顺序，则需要交换
        if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedDescending;
        } else {
            // obj1 >= obj2（大的放前面，小的放后面。最终结果就是降序）
            return NSOrderedAscending;
        }
    }];
    
    NSLog(@"降序%@", sortedArray.description);
}

- (void)compareString {
    NSArray<NSString *> *testArray = @[@"Foo2.txt", @"Foo01.txt", @"C", @"T", @"D"];
    NSArray *sortedArray = [testArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSLog(@"obj1=%@  obj2=%@", obj1, obj2);
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    NSLog(@"sortedArray=\n%@", [sortedArray description]);
}
@end
