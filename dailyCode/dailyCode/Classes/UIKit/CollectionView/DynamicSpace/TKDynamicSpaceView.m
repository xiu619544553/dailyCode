//
//  TKDynamicSpaceView.m
//  dailyCode
//
//  Created by hello on 2021/7/21.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKDynamicSpaceView.h"
#import "TKDynamicSpaceCollectionCell.h"
#import "TKDynamicSpaceSectionHeaderView.h"
#import "TKDynamicSpaceSectionFooterView.h"

@interface TKDynamicSpaceView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TKDynamicSpaceView

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - Override Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TKDynamicSpaceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TKDynamicSpaceCollectionCell.class) forIndexPath:indexPath];
    cell.content = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.item)];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TKDynamicSpaceSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TKDynamicSpaceSectionHeaderView class]) forIndexPath:indexPath];
        header.content = [NSString stringWithFormat:@"SectionHeader = %@", @(indexPath.section)];
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        TKDynamicSpaceSectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([TKDynamicSpaceSectionFooterView class]) forIndexPath:indexPath];
        footer.content = [NSString stringWithFormat:@"SectionFooter = %@", @(indexPath.section)];
        return footer;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

// section header height
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 44.f);
}

// section footer height
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 44.f);
}

#pragma mark - getter

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        CGFloat minimumLineSpacing = 1.f;
        CGFloat cellWidth = [self fixSlitWith:[UIScreen mainScreen].bounds colCount:3 space:minimumLineSpacing];
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth * 16.f / 9.f);
        
        // sectionHeader 与 该组第一行cell之间的间距
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 0.f, 20, 0.f);
        
        // 网格中item行与行之间使用的最小间距。
        _flowLayout.minimumLineSpacing = minimumLineSpacing;
        
        // 同一行中item之间使用的最小间距。
        _flowLayout.minimumInteritemSpacing = minimumLineSpacing;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blackColor];
        
        // cell
        [_collectionView registerClass:[TKDynamicSpaceCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass(TKDynamicSpaceCollectionCell.class)];
        
        // section header
        [_collectionView registerClass:[TKDynamicSpaceSectionHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:NSStringFromClass([TKDynamicSpaceSectionHeaderView class])];
        
        // section footer
        [_collectionView registerClass:[TKDynamicSpaceSectionFooterView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:NSStringFromClass([TKDynamicSpaceSectionFooterView class])];
    }
    return _collectionView;
}

#pragma mark - Private Methods

- (CGFloat)fixSlitWith:(CGRect)rect colCount:(CGFloat)colCount space:(CGFloat)space {
    // 总共留出的距离
    CGFloat totalSpace = (colCount - 1) * space;
    // 按照真实屏幕算出的cell宽度 （iPhone6 375*667）93.75
    CGFloat itemWidth = (rect.size.width - totalSpace) / colCount;
    // (1px=0.5pt,6Plus为3px=1pt)
    CGFloat fixValue = 1 / [UIScreen mainScreen].scale;
    // 取整加fixValue  floor:如果参数是小数，则求最大的整数但不大于本身.
    CGFloat realItemWidth = floor(itemWidth) + fixValue;
    if (realItemWidth < itemWidth) { // 有可能原cell宽度小数点后一位大于0.5
        realItemWidth += fixValue;
    }
    // 算出屏幕等分后满足1px=([UIScreen mainScreen].scale)pt实际的宽度,可能会超出屏幕,需要调整一下frame
    CGFloat realWidth = colCount * realItemWidth + totalSpace;
    // 偏移距离
    CGFloat pointX = (realWidth - rect.size.width) / 2;
    // 向左偏移
    rect.origin.x = -pointX;
    rect.size.width = realWidth;
    // 每个cell的真实宽度
    return realItemWidth;
}

@end
