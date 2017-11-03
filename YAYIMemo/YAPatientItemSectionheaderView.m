//
//  YAPatientItemSectionheaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/8/18.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientItemSectionheaderView.h"

@implementation YAPatientItemSectionheaderView
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
    
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(18)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#424242"];
    [self.contentView addSubview:self.titleLab];
    
    self.hLine = [UILabel new];
    [self.contentView addSubview:self.hLine];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(@14);
        make.height.equalTo(@(18*YAYIScreenScale));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(2);
        make.centerX.mas_equalTo(self.titleLab.mas_centerX);
        make.height.equalTo(@1);
        make.width.equalTo(@10);
    }];
    
    
    
    
}

@end
