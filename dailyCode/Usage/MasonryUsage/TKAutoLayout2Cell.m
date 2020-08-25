//
//  TKAutoLayout2Cell.m
//  dailyCode
//
//  Created by hanxiuhui on 2020/8/25.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TKAutoLayout2Cell.h"

@interface TKAutoLayout2Cell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation TKAutoLayout2Cell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.bottomLineView];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15.f);
            make.right.equalTo(self.contentView).offset(-15.f);
            make.top.equalTo(self.contentView).offset(15.f);
        }];
        
        
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.height.mas_equalTo(19);
            make.width.greaterThanOrEqualTo(@10);
            
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
            make.bottom.equalTo(self.contentView).offset(-15.f);
            
        }];
        
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.f);
            make.right.mas_equalTo(-15.f);
            make.bottom.mas_equalTo(0.f);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)updateTitle:(NSString *)title time:(NSString *)time {
    _titleLabel.text = title;
    _timeLabel.text = time;
}

#pragma mark - Private Methods

//- (NSMutableAttributedString *)AttributedfrontString:(NSString *)frontStr imageNamesStr:(NSString *)imageNamesStr {
//    NSString *textStr = [NSString stringWithFormat:@"  %@",frontStr];
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:textStr];
//    [string addAttributes:@{NSFontAttributeName:ZGFont(11.0f), NSForegroundColorAttributeName:UIColorFromRGB(0x999999)} range:NSMakeRange(0, textStr.length)];
//    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
//    attach.image = [UIImage imageNamed:imageNamesStr];
//    attach.bounds = CGRectMake(0, -3, 13, 13);
//    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
//    [string insertAttributedString:attachString atIndex:0];
//    return string;
//}

#pragma mark - setter



//@synthesize articleListModel = _articleListModel;
//- (void)setArticleListModel:(ZGInformationArticleListModel *)articleListModel {
//    _articleListModel = articleListModel;
//
//    // 标题
//    NSString *title = self.articleListModel.articleTitle;
//    if (title && title.length > 0) {
//        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:title];
//        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:4.5];
//        [attributedString addAttributes:@{
//            NSFontAttributeName:ZGFont(17.0f), NSParagraphStyleAttributeName:paragraphStyle
//        } range:NSMakeRange(0, [title length])];
//        [self.titleLabel setAttributedText:attributedString];
//    } else {
//        self.titleLabel.text = @"";
//    }
//
//    // 时间
//    [self.timeLabel setAttributedText:[self AttributedfrontString:self.articleListModel.articleReleaseDate imageNamesStr:@"zg_ information_time"]];
//}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
//    self.contentView.backgroundColor = highlighted ? UIColorFromRGB(0xeeeeee) : ZGWhiteColor;
}

#pragma mark - getter

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = ZGWideFont(17.0f);
        _titleLabel.numberOfLines = 2;
//        _titleLabel.textColor = UIColorFromRGB(0x222222);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
//        _timeLabel.textColor = UIColorFromRGB(0x999999);
    }
    return _timeLabel;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = UIColor.redColor;
//        _bottomLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    }
    return _bottomLineView;
}

@end
