//
//  PayTopTableViewCell.m
//  jsy_ios2
//
//  Created by YFM on 2018/6/29.
//  Copyright © 2018年 iOS. All rights reserved.
//
// 动态获取屏幕宽高
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#import "PayTopTableViewCell.h"

#import <Masonry.h>

#define KColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LineColor                KColorFromRGB(0xefefef)
#define CColor                   KColorFromRGB(0x666666)
#define DColor                   KColorFromRGB(0x999999)
#define RemindRedColor           KColorFromRGB(0xF05F50)


@implementation PayTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}
- (void)createSubView{
    _iconImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = CColor;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(8);
        make.top.mas_equalTo(19);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, 62, KScreenWidth - 16, 1)];
    line.backgroundColor = LineColor;
    [self.contentView addSubview:line];
    
//    _desLabel = [[UILabel alloc]init];
//    _desLabel.textColor = DColor;
//    _desLabel.font = [UIFont systemFontOfSize:9];
//    [self.contentView addSubview:_desLabel];
//    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.iconImgView.mas_right).offset(10);
//        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
//    }];
    
    _stateView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:_stateView];
    [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(16, 12));
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
