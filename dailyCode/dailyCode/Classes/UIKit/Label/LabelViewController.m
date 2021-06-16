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
    
    CGFloat labelY = 10.f;
    CGFloat labelMargin = 20.f;
    CGFloat labelWidth = 60.f;
    CGFloat labelHeight = 30.f;
    
    NSString *text = @"我我我我我我我";
    
    // 正常label
    UILabel *normalLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelMargin, labelY, labelWidth, labelHeight)];
    normalLabel.backgroundColor = UIColor.systemPinkColor;
    normalLabel.text = text;
    normalLabel.numberOfLines = 1;
    normalLabel.textAlignment = NSTextAlignmentCenter;
    normalLabel.font = [UIFont systemFontOfSize:20.f];
    [self.view addSubview:normalLabel];
    
    
    UILabel *fixedLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(normalLabel.frame) + labelMargin, labelY, labelWidth, labelHeight)];
    fixedLabel1.backgroundColor = UIColor.systemPinkColor;
    fixedLabel1.text = text;
    fixedLabel1.numberOfLines = 1;
    fixedLabel1.textAlignment = NSTextAlignmentCenter;
    fixedLabel1.font = [UIFont systemFontOfSize:20.f];
    
    // 指示是否应该减小字体大小以使标题字符串适合标签的边框
    fixedLabel1.adjustsFontSizeToFitWidth = YES;
    /*
     如果将adjustsFontSizeToFitWidth属性设置为YES，那么使用这个属性为当前字体大小指定一个最小的乘数，这个乘数可以产生一个可以在显示标签文本时使用的字体大小。如果为该属性指定值为0，则使用当前字体大小作为最小字体大小。此属性的默认值为0。
     */
    fixedLabel1.minimumScaleFactor = 18.0/20.f; // 给定的 FontSize=15，此处我们可以设置 18.0/20.f，表示，字体在 18.f~20.f之间浮动
    
    /*
     如果将adjustsFontSizeToFitWidth属性设置为YES，这个属性控制在需要调整字体大小的情况下文本基线的行为。这个属性的默认值是UIBaselineAdjustmentAlignBaselines。只有当numberOfLines属性被设置为1时，此属性才有效。
     */
    fixedLabel1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    [self.view addSubview:fixedLabel1];
    
    
    
    UILabel *fixedLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fixedLabel1.frame) + labelMargin, labelY, labelWidth, labelHeight)];
    fixedLabel2.backgroundColor = UIColor.systemPinkColor;
    fixedLabel2.text = text;
    fixedLabel2.numberOfLines = 1;
    fixedLabel2.textAlignment = NSTextAlignmentCenter;
    fixedLabel2.font = [UIFont systemFontOfSize:20.f];
    fixedLabel2.minimumScaleFactor = 0.5;
    fixedLabel2.adjustsFontSizeToFitWidth = YES;
    fixedLabel2.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self.view addSubview:fixedLabel2];
    
    
    UILabel *fixedLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fixedLabel2.frame) + labelMargin, labelY, labelWidth, labelHeight)];
    fixedLabel3.backgroundColor = UIColor.systemPinkColor;
    fixedLabel3.text = text;
    fixedLabel3.numberOfLines = 1;
    fixedLabel3.textAlignment = NSTextAlignmentCenter;
    fixedLabel3.font = [UIFont systemFontOfSize:20.f];
    
    fixedLabel3.minimumScaleFactor = 0.5;
    fixedLabel3.adjustsFontSizeToFitWidth = YES;
//    fixedLabel3.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
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
    
    
    // tag标签 + 文字实现的方式
    
    // 方式一：常规实现，如果有 UIImage，则直接使用 NSAttributedString和 NSTextAttachment
    [self tagTextGeneralImplementation];
    
    // 方式二：如果没有 tag对应的 UIImage，我们可以使用 UILabel-->截图->NSTextAttachment、NSAttributedString
    [self tagTextLabel1];
    
    // 方式三：取巧，利用 首行缩进
    [self tagTextWithParagraphStyleOfFirstLineHeadIndent];
}


// 图片
- (void)tagTextGeneralImplementation {
    
}


- (void)tagTextLabel1 {
    UILabel *tagTextLabel = [[UILabel alloc] init];
    tagTextLabel.numberOfLines = 0;
    [self.view addSubview:tagTextLabel];
    [tagTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(30.f);
        make.right.inset(30.f);
        make.top.inset(100.f);
    }];
    
    CGFloat scale = 3.f;
    CGFloat fontSize = 12.f;
    NSString *tagText = @"置顶";
    CGFloat aaW = fontSize * tagText.length + 6.f;
    UILabel *tagLabel = [UILabel new];
    tagLabel.frame = CGRectMake(0, 0, aaW * scale, 16 * scale);
    tagLabel.text = tagText;
    tagLabel.font = [UIFont boldSystemFontOfSize:fontSize * scale];
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.backgroundColor = [UIColor redColor];
    tagLabel.clipsToBounds = YES;
    tagLabel.layer.cornerRadius = 2;
    tagLabel.textAlignment = NSTextAlignmentCenter;
    
    // 对 tagLabel截图
    UIImage *image = [self imageWithUIView:tagLabel];
    NSTextAttachment *tagAttachment = [[NSTextAttachment alloc] init];
    tagAttachment.bounds = CGRectMake(0, -2.5, aaW, 16); // 这个 -2.5 是为了调整下标签跟文字的位置
    tagAttachment.image = image;
    
    NSAttributedString *tagAttr = [NSAttributedString attributedStringWithAttachment:tagAttachment];
    
    NSString *titleString = @"  我是标题我是标题我是标我是标题我是标题我是标题我是标我是标题我是标题我是标题我是标我是标题我是标题我是标题我是标我是标题我是标题";
    NSMutableAttributedString *tagTextAttr = [[NSMutableAttributedString alloc] initWithString:titleString];
    [tagTextAttr insertAttributedString:tagAttr atIndex:0];
    [tagTextLabel setAttributedText:tagTextAttr];
}

// 首行缩进
- (void)tagTextWithParagraphStyleOfFirstLineHeadIndent {
    
}

#pragma mark - Private Methods

//view转成image
- (UIImage*)imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
@end
