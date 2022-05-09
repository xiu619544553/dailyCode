//
//  TKGridViewController.m
//  dailyCode
//
//  Created by hello on 2022/5/9.
//  Copyright © 2022 TK. All rights reserved.
//

#import "TKGridViewController.h"

@interface TKGridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TKGridViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 66;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = UIColor.blackColor;
    
    return cell;
}

#pragma mark - Private Methods

/// 关键方法
/// UICollectionViewCell 的宽度、列数、间距
/// @param rect UICollectionView 的 frame
/// @param column 列数
/// @param minimumLineSpacing cell 之间使用的最小间距
- (CGFloat)fixSlitWithCollectionFrame:(CGRect)rect column:(CGFloat)column minimumLineSpacing:(CGFloat)minimumLineSpacing {
    // 总共留出的距离
    CGFloat totalSpace = (column - 1) * minimumLineSpacing;
    // 按照真实屏幕算出的cell宽度 （iPhone6 375*667）93.75
    CGFloat itemWidth = (rect.size.width - totalSpace) / column;
    // (1px=0.5pt,6Plus为3px=1pt)
    CGFloat fixValue = 1 / [UIScreen mainScreen].scale;
    // 取整加fixValue  floor:如果参数是小数，则求最大的整数但不大于本身.
    CGFloat realItemWidth = floor(itemWidth) + fixValue;
    if (realItemWidth < itemWidth) { // 有可能原cell宽度小数点后一位大于0.5
        realItemWidth += fixValue;
    }
    // 算出屏幕等分后满足1px=([UIScreen mainScreen].scale)pt实际的宽度,可能会超出屏幕,需要调整一下frame
    CGFloat realWidth = column * realItemWidth + totalSpace;
    // 偏移距离
    CGFloat pointX = (realWidth - rect.size.width) / 2;
    // 向左偏移
    rect.origin.x = -pointX;
    rect.size.width = realWidth;
    // 每个cell的真实宽度
    return realItemWidth;
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {

        CGFloat minimumLineSpacing = 2.f;
        CGFloat cellWidth = [self fixSlitWithCollectionFrame:[UIScreen mainScreen].bounds column:3 minimumLineSpacing:minimumLineSpacing];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellWidth, cellWidth * 16.f / 9.f);
        layout.sectionInset = UIEdgeInsetsMake(minimumLineSpacing, 0.f, minimumLineSpacing, 0.f);
        layout.minimumLineSpacing = minimumLineSpacing;
        layout.minimumInteritemSpacing = 1.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];

        [_collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    }
    return _collectionView;
}

@end
