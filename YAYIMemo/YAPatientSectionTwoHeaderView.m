//
//  YAPatientSectionTwoHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/8/18.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientSectionTwoHeaderView.h"

@implementation YAPatientSectionTwoHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}
-(void)createViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.icon = [UIImageView new];
    self.icon.image = [UIImage imageNamed:@"recent_icon"];
    self.icon.layer.masksToBounds = YES;
   
    [self.contentView addSubview:self.icon];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#424242"];
    [self.contentView addSubview:self.titleLab];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"recent_icon"];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*YAYIScreenScale));
        make.top.equalTo(@10);
        make.width.equalTo(@(image.size.width));
        make.height.equalTo(@(image.size.height));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(20*YAYIScreenScale);
        make.centerY.mas_equalTo(self.icon.mas_centerY);
        make.height.equalTo(@(20*YAYIScreenScale));
    }];
   
    
    
    
}


@end
