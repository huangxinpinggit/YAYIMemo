//
//  YAPersonItemCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPersonItemCell.h"

@implementation YAPersonItemCell


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

-(void)setModel:(YAPersonItemModel *)model
{
    _model = model;
    self.icon.image = [UIImage imageNamed:model.image];
    self.titleLab.text = model.title;

}
-(void)createViews{
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#252525"];
    self.icon = [UIImageView new];
    [self.contentView addSubview:self.icon];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:self.titleLab];
    
    self.hLine = [UILabel new];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#424242"];
    [self.contentView addSubview:self.hLine];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:_model.image];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(34*YAYIScreenScale)); //34
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(image.size.width,image.size.height ));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(34*YAYIScreenScale);
        make.centerY.mas_equalTo(self.icon.mas_centerY);
        make.height.equalTo(@20);
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
        make.right.equalTo(@0);
    }];

}

@end
