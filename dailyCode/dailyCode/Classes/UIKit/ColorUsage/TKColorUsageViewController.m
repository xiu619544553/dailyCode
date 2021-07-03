//
//  TKColorUsageViewController.m
//  dailyCode
//
//  Created by hello on 2020/8/10.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKColorUsageViewController.h"
#import "UIColor+TKAdd.h"

static NSString *cellReuseIdentifier = @"UICollectionViewCell";

@interface TKColorUsageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *blueTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *redTipLabel;

@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;

@property (nonatomic, strong) NSArray<UIColor *> *colorArray;


@property (nonatomic, strong) UIView *colorContainerView;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TKColorUsageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _redSlider.minimumTrackTintColor = UIColor.redColor;
    _greenSlider.minimumTrackTintColor = UIColor.greenColor;
    _blueSlider.minimumTrackTintColor = UIColor.blueColor;
    
    [_redSlider setValue:arc4random_uniform(256)/255.f animated:YES];
    [_greenSlider setValue:arc4random_uniform(256)/255.f animated:YES];
    [_blueSlider setValue:arc4random_uniform(256)/255.f animated:YES];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 布局
    [self.view addSubview:self.colorContainerView];
    [self.colorContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(270.f);
    }];
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.redTipLabel.mas_top).offset(-20.f);
        make.top.equalTo(self.colorContainerView.mas_bottom);
    }];
    
    
    [self.colorContainerView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15.f);
        make.bottom.equalTo(self.colorContainerView).offset(-10.f);
    }];
    
    
    [self.colorContainerView addSubview:self.colorLabel];
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10.f, 10.f, 100.f, 10.f));
    }];
    
    
    // 初始化颜色
    [self configColorView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    DLog(@"%@", NSStringFromCGRect(self.colorContainerView.frame));
}

#pragma mark - Event Methods

- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    DLog(@"value: %.2f", sender.value);
    
    [self configColorView];
}

- (void)configColorView {
    
    float redValue = _redSlider.value * 255.f;
    float greenValue = _greenSlider.value * 255.f;
    float blueValue = _blueSlider.value * 255.f;
    
    _redTipLabel.text = [NSString stringWithFormat:@"R（%.0f）", redValue];
    _greenTipLabel.text = [NSString stringWithFormat:@"G（%.0f）", greenValue];
    _blueTipLabel.text = [NSString stringWithFormat:@"B（%.0f）", blueValue];
    
    _colorLabel.backgroundColor = [UIColor colorWithRed:redValue/255.f green:greenValue/255.f blue:blueValue/255.f alpha:1.f];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.colorArray.count <= indexPath.row) { return; }
    
    UIColor *selectColor = [self.colorArray objectAtIndex:indexPath.item];
    _colorLabel.backgroundColor = selectColor;
    
    [_redSlider setValue:selectColor.redValue animated:YES];
    [_greenSlider setValue:selectColor.greenValue animated:YES];
    [_blueSlider setValue:selectColor.blueValue animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colorArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    if (self.colorArray.count > indexPath.row) {
        cell.backgroundColor = [self.colorArray objectAtIndex:indexPath.item];
    }
    cell.layer.cornerRadius = 2.f;
    cell.layer.borderColor = kRGB(217, 216, 214).CGColor;
    cell.layer.borderWidth = 1.f / [UIScreen mainScreen].scale;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self itemWH], [self itemWH]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self insetForSection];
}

#pragma mark - Private Methods

- (CGFloat)itemWH {
    return (CGRectGetWidth(self.view.frame) - ([self itemColumn] - 1) * [self itemLinePadding] - [self insetForSection].left - [self insetForSection].right) / ((CGFloat)[self itemColumn]);
}

- (CGFloat)itemLinePadding {
    return 10.f;
}

- (NSUInteger)itemColumn {
    return 7;
}

- (UIEdgeInsets)insetForSection {
    return UIEdgeInsetsMake(10.f, 15.f, 0, 15.f);
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:cellReuseIdentifier];
    }
    return _collectionView;
}

- (UIView *)colorContainerView {
    if (!_colorContainerView) {
        _colorContainerView = [UIView new];
        _colorContainerView.backgroundColor = kRGB(239, 239, 239);
    }
    return _colorContainerView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:14.f];
        _tipLabel.textColor = kRGB(111, 110, 115);
        _tipLabel.text = @"背景颜色";
    }
    return _tipLabel;
}

- (UILabel *)colorLabel {
    if (!_colorLabel) {
        _colorLabel = [UILabel new];
        _colorLabel.font = [UIFont systemFontOfSize:18.f];
        _colorLabel.numberOfLines = 0;
        _colorLabel.textAlignment = NSTextAlignmentCenter;
        _colorLabel.text = @"枫桥夜泊 / 夜泊枫江\n【作者】张继 【朝代】唐\n\n月落乌啼霜满天，江枫渔火对愁眠。\n姑苏城外寒山寺，夜半钟声到客船。";
        _colorLabel.lineBreakMode = NSLineBreakByClipping;
    }
    return _colorLabel;
}

- (NSArray<UIColor *> *)colorArray {
    if (!_colorArray) {
        _colorArray = @[
                       kRGB(1.f, 1.f, 1.f),
                       kRGB(51.f, 51.f, 51.f),
                       kRGB(102.f, 102.f, 102.f),
                       kRGB(151.f, 151.f, 151.f),
                       kRGB(204.f, 204.f, 204.f),
                       kRGB(238.f, 238.f, 238.f),
                       kRGB(255.f, 255.f, 255.f),
                       kRGB(218.f, 216.f, 204.f),
                       kRGB(252.f, 247.f, 240.f),
                       kRGB(211.f, 201.f, 175.f),
                       kRGB(215.f, 201.f, 142.f),
                       kRGB(181.f, 175.f, 165.f),
                       kRGB(218.f, 208.f, 182.f),
                       kRGB(195.f, 186.f, 166.f),
                       kRGB(201.f, 215.f, 197.f),
                       kRGB(175.f, 186.f, 175.f),
                       kRGB(134.f, 148.f, 178.f),
                       kRGB(159.f, 173.f, 154.f),
                       kRGB(168.f, 203.f, 254.f),
                       kRGB(110.f, 133.f, 102.f),
                       kRGB(71.f, 100.f, 155.f),
                       kRGB(249, 212, 211),
                       kRGB(250, 145, 153),
                       kRGB(193, 80, 78),
                       kRGB(155, 44, 32),
                       kRGB(149, 67, 5),
                       kRGB(230, 108, 125),
                       kRGB(229, 0, 90),
                       kRGB(72, 170, 196),
                       kRGB(144, 132, 22),
                       kRGB(77, 59, 47),
                       kRGB(113, 137, 200),
                       kRGB(26, 64, 109),
                       kRGB(102, 106, 85),
                       kRGB(199, 194, 208),
                       kRGB(36, 135, 102),
                       kRGB(125, 59, 75),
                       kRGB(3, 26, 55),
                       kRGB(164, 193, 72),
                       kRGB(177, 63, 154),
                       kRGB(90, 146, 180),
                       kRGB(123, 201, 97)
        ];
    }
    return _colorArray;
}
@end
