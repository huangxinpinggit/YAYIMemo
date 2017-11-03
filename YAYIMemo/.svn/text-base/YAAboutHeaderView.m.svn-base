//
//  YAAboutHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAboutHeaderView.h"

@implementation YAAboutHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}

-(void)createViews{
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    UIImageView *icon = [UIImageView new];
    icon.layer.cornerRadius = 14*YAYIScreenScale;
    icon.backgroundColor = [UIColor whiteColor];
    icon.image = [UIImage imageNamed:@"per_app_icon"];
    icon.layer.borderWidth = 1.0;
    icon.layer.masksToBounds = YES;
    icon.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    titleLab.textColor = [UIColor colorWithHexString:@"#868686"];
    titleLab.text = @"当前版本： 1.0.0";
    [self.contentView addSubview:titleLab];
    self.titleLab = titleLab;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(@(41*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(76*YAYIScreenScale,76*YAYIScreenScale ));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.icon.mas_bottom).offset(15*YAYIScreenScale);
        make.height.equalTo(@(13*YAYIScreenScale));;
    }];
    
}
@end
