//
//  YAPersonViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPersonInfonViewCell.h"

@implementation YAPersonInfonViewCell

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
        [self createViews];
    }
    return self ;
    
}
-(void)setModel:(YAPersonItemModel *)model
{
    _model = model;
    [self.avater sd_setImageWithURL:[NSURL URLWithString:model.avatar]  placeholderImage:[UIImage imageNamed:@"default_person_avatar"]];
    
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
    
    UIImageView *avater = [UIImageView new];
    [avater zy_cornerRadiusAdvance:40*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    [self.contentView addSubview:avater];
    self.avater = avater;
    
    
    
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
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.avater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.icon.mas_left).offset(-13*YAYIScreenScale);;
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80*YAYIScreenScale, 80*YAYIScreenScale));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W-30*YAYIScreenScale, 1*YAYIScreenScale));
    }];
    
}

@end
