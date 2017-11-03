//
//  YAPatientOneSessionCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/18.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientOneSessionCell.h"

@implementation YAPatientOneSessionCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}

-(void)createViews{
    self.icon = [UIImageView new];
    self.icon.image = [UIImage imageNamed:@"label_icon"];
   
    
    [self.contentView addSubview:self.icon];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#424242"];
    [self.contentView addSubview:self.titleLab];
    
    self.seperateView = [UIView new];
    self.seperateView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self.contentView addSubview:self.seperateView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"label_icon"];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(image.size.width));
        make.height.equalTo(@(image.size.height));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(20*YAYIScreenScale);
            make.centerY.mas_equalTo(self.icon.mas_centerY);
            make.height.equalTo(@20);
        }];
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(@44);
        make.width.equalTo(@(SCREEN_W));
        make.height.equalTo(@(9*YAYIScreenScale));
    }];
    
    
    
}
@end
