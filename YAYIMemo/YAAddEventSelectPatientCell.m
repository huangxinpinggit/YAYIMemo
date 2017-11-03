//
//  YAAddEventSelectPatientCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventSelectPatientCell.h"

@implementation YAAddEventSelectPatientCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self createView];
    }
    return self ;
}

-(void)createView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithHexString:@"#424242"];
    label.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    label.text = @"选择患者";
    [self.contentView addSubview:label];
    self.titleLab = label;
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"不知火舞";
    nameLab.textAlignment = NSTextAlignmentRight;
    nameLab.textColor = [UIColor colorWithHexString:@"#424242"];
    nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"s_enter"] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    self.button = button;
    
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"s_enter"];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-6*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(image.size.width +(18*YAYIScreenScale), image.size.height));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.button.mas_left);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80*YAYIScreenScale, 14*YAYIScreenScale));
    }];

    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(16*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80*YAYIScreenScale, 14*YAYIScreenScale));
    }];
    
   
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(345*YAYIScreenScale, 1));
    }];
}

@end
