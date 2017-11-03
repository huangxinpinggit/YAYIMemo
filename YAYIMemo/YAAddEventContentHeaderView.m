//
//  YAAddEventContentHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventContentHeaderView.h"

@implementation YAAddEventContentHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
    label.text = @"事项内容";
    [self.contentView addSubview:label];
    self.titleLab = label;
    
    UIImageView *hLine = [UIImageView new];
    hLine.image = [UIImage imageNamed:@"i_line"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
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
