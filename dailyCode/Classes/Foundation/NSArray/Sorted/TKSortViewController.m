//
//  TKSortViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKSortViewController.h"
#import "TKSortedModel.h"

@interface TKSortViewController ()

@end

@implementation TKSortViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
}

// 排序，NSArray<Model *> *
- (IBAction)sortModelArrayAction:(UIButton *)sender {
    NSMutableArray <TKSortedModel*> *sortedImages = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        TKSortedModel *model = [TKSortedModel new];
        model.name = [NSString stringWithFormat:@"name: %d", i];
        model.number = arc4random() % 100;
        [sortedImages addObject:model];
    }
    
    kTICK
    // 排序  --  数组排序，数组内是模型，以模型的某一个属性为排序的标准
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    [sortedImages sortUsingDescriptors:@[sortDescriptor]];
    kTOCK
    
    // 查看排序结果
    for (TKSortedModel *model in sortedImages) {
        NSLog(@"number=%@", @(model.number));
    }
}

// 升序排序，NSArray<NSString *> *
- (IBAction)sortStringArrayAction:(UIButton *)sender {
    NSDictionary *dict = @{
        @"system"     : @"iPad12.4.7",
        @"channel_id" : @"0d2ca33bc97642f59934be51833e5b60",
        @"device_id"  : @"17F0301B33F14F1EB8CB5C6BD9F78261",
        @"pushtoken"  : @"0d2ca33bc97642f59934be51833e5b60",
        @"platform"   : @"iphone",
        @"user_id"    : @"31114",
        @"version"    : @"4.8.0",
        @"appid"      : @"test666"
    };
    
    //        NSOrderedAscending = -1L,
    //        NSOrderedSame,       0
    //        NSOrderedDescending  1
    
    NSArray *keys = [dict allKeys];
    // 返回一个数组，该数组按升序列出接收数组的元素，由给定NSComparator块指定的比较方法确定。
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2 options:NSNumericSearch];
        NSLog(@"obj1=%@  obj2=%@  result=%ld", obj1, obj2, result);
        return result;
    }];
    
    for (NSString *string in sortedArray) {
        DLog(@"%@", string);
    }
}

- (IBAction)customSortStyleAction:(UIButton *)sender {
    
    
    NSArray<NSNumber *> *numberArray = @[@1,@5,@2,@6,@3,@7,@9];
    
    // 降序排序
    NSArray *descendingArray = [numberArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber * _Nonnull obj1, NSNumber * _Nonnull obj2) {
        // 因为不满足sortedArrayUsingComparator方法的默认排序顺序，则需要交换
        if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedDescending;
        } else {
            // obj1 >= obj2
            return NSOrderedAscending;
        }
    }];
    NSLog(@"降序排序%@", descendingArray.description);
    
    
    // 升序排序
    NSArray *ascendingArray = [numberArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber * _Nonnull obj1, NSNumber * _Nonnull obj2) {
        // 因为不满足sortedArrayUsingComparator方法的默认排序顺序，则需要交换
        if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedAscending;
        } else {
            // obj1 >= obj2
            return NSOrderedDescending;
        }
    }];
    NSLog(@"升序排序%@", ascendingArray.description);
}

@end
