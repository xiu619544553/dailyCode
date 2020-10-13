//
//  LabelViewController.m
//  test
//
//  Created by hello on 2020/6/12.
//  Copyright © 2020 TK. All rights reserved.
//

#import "LabelViewController.h"


@interface LabelViewController ()

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat labelY = 200.f;
    CGFloat labelMargin = 20.f;
    CGFloat labelWidth = 60.f;
    CGFloat labelHeight = 30.f;
    
    // 正常label
    UILabel *normalLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelMargin, labelY, labelWidth, labelHeight)];
    normalLabel.backgroundColor = UIColor.systemPinkColor;
    normalLabel.text = @"我我我我我我我";
    normalLabel.numberOfLines = 1;
    normalLabel.textAlignment = NSTextAlignmentCenter;
    normalLabel.font = [UIFont systemFontOfSize:20.f];
    [self.view addSubview:normalLabel];
    
    DLog(@"%f", normalLabel.minimumScaleFactor);
    
    
    
    UILabel *fixedLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(normalLabel.frame) + labelMargin, labelY, labelWidth, labelHeight)];
    fixedLabel1.backgroundColor = UIColor.systemPinkColor;
    fixedLabel1.text = @"我我我我我我我";
    fixedLabel1.numberOfLines = 1;
    fixedLabel1.textAlignment = NSTextAlignmentCenter;
    fixedLabel1.font = [UIFont systemFontOfSize:20.f];
    
    fixedLabel1.minimumScaleFactor = 10.0/13.0;
    fixedLabel1.adjustsFontSizeToFitWidth = YES;
    fixedLabel1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self.view addSubview:fixedLabel1];
    
    
    
    UILabel *fixedLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fixedLabel1.frame) + labelMargin, labelY, labelWidth, labelHeight)];
    fixedLabel2.backgroundColor = UIColor.systemPinkColor;
    fixedLabel2.text = @"我我我我我我我";
    fixedLabel2.numberOfLines = 1;
    fixedLabel2.textAlignment = NSTextAlignmentCenter;
    fixedLabel2.font = [UIFont systemFontOfSize:20.f];
    
    fixedLabel2.minimumScaleFactor = 0.5;
    fixedLabel2.adjustsFontSizeToFitWidth = YES;
    fixedLabel2.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self.view addSubview:fixedLabel2];
    
    
    UILabel *fixedLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fixedLabel2.frame) + labelMargin, labelY, labelWidth, labelHeight)];
    fixedLabel3.backgroundColor = UIColor.systemPinkColor;
    fixedLabel3.text = @"我我我我我我我";
    fixedLabel3.numberOfLines = 1;
    fixedLabel3.textAlignment = NSTextAlignmentCenter;
    fixedLabel3.font = [UIFont systemFontOfSize:20.f];
    
    fixedLabel3.minimumScaleFactor = 0.5;
    fixedLabel3.adjustsFontSizeToFitWidth = YES;
    fixedLabel3.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    [self.view addSubview:fixedLabel3];
    
    
    /*
     需求：
        在icon某个区域，展示标题。
     分析：
        icon的大小，限定了我们的Label的最大size，我们需要在这个size范围内，合理的缩放文字的大小
        * 首先，指定UILabel的size（frame）
        * adjustsFontSizeToFitWidth 属性设置为YES，然后指定 minimumScaleFactor，这2个属性保证Label的文字大小在我们给定的范围内变化，这个给定的范围就是 label.font * minimumScaleFactor <= 展示效果 <= label.font
        * baselineAdjustment = UIBaselineAdjustmentAlignCenters; 确保文字在给定区域的居中
     
     */
    
//    UIImage *coverImg = [UIImage imageNamed:@"bookCover0"];
    
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"bookCover0" ofType:@"png"];
    UIImage *coverImg = [UIImage imageWithContentsOfFile:file];
    
    UIImageView *coverImgV = [[UIImageView alloc] initWithImage:coverImg];
    coverImgV.frame = (CGRect){150, 260, coverImg.size};
    coverImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:coverImgV];
    
    UILabel *label0 = [[UILabel alloc] init];
    label0.frame = CGRectMake(0, 20.f, coverImg.size.width, 20);
    label0.text = @"考研数学考试";
    label0.font = [UIFont systemFontOfSize:15.f];
    
    label0.adjustsFontSizeToFitWidth = YES;
    label0.minimumScaleFactor = 10.f/15.f; // 给定的Font大小为15，此处我们可以设置10.f/15.f，表示，字体在10.f~15.f之间浮动
    label0.baselineAdjustment = UIBaselineAdjustmentNone;
    [coverImgV addSubview:label0];
    
    
    [self testAttri1];
}


- (void)testAttri1 {
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.numberOfLines = 0;
    [self.view addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(10.f);
        make.right.inset(10.f);
        make.bottom.inset(100.f);
    }];

//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"这是一件商品，他非常的便宜，可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。可以说是物美价廉了。"];
    
    
    NSString *titleString = @"我是标题！我是标题！我是标！我是标题！";
    //创建  NSMutableAttributedString 富文本对象
    NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString:titleString];
    //创建一个小标签的Label
    NSString *aa = @"我TM是个类似图片的标签";
    CGFloat aaW = 12*aa.length +6;
    UILabel *aaL = [UILabel new];
    aaL.frame = CGRectMake(0, 0, aaW*3, 16*3);
    aaL.text = aa;
    aaL.font = [UIFont boldSystemFontOfSize:12*3];
    aaL.textColor = [UIColor whiteColor];
    aaL.backgroundColor = [UIColor redColor];
    aaL.clipsToBounds = YES;
    aaL.layer.cornerRadius = 3*3;
    aaL.textAlignment = NSTextAlignmentCenter;
    //调用方法，转化成Image
    UIImage *image = [self imageWithUIView:aaL];
    //创建Image的富文本格式
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2.5, aaW, 16); //这个-2.5是为了调整下标签跟文字的位置
    attach.image = image;
    //添加到富文本对象里
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面
    
    
    
    
    
    
    
    [descLabel setAttributedText:maTitleString];
}

//view转成image
- (UIImage*) imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
@end
