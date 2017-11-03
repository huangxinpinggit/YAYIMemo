//
//  YASettingCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASettingCell.h"

@implementation YASettingCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self ;

}

-(void)createViews{
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = [UIColor colorWithHexString:@"#424242"];
    titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:titleLab];
    self.titleLab = titleLab;
    
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"enter"];
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    UILabel *nameLab = [UILabel new];
    nameLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *operaLab = [UILabel new];
    operaLab.textColor = [UIColor colorWithHexString:@"#424242"];
    operaLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:operaLab];
    self.operaLab = operaLab;

    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@(15*YAYIScreenScale));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
   
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);

    }];
    
    [self.operaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.icon.mas_left).offset(-13*YAYIScreenScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W-30*YAYIScreenScale, 1*YAYIScreenScale));
    }];
    
}
@end
