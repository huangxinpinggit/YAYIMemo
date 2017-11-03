//
//  YAAddEventRepeatHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventRepeatHeaderView.h"

@implementation YAAddEventRepeatHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self ;
}

-(void)setRepeatStr:(NSString *)repeatStr
{
    if (repeatStr.length >0) {
        self.repeatLab.textColor = [UIColor colorWithHexString:@"#ff414c"];
        self.repeatLab.text = repeatStr;
    }else{
        self.repeatLab.textColor = [UIColor colorWithHexString:@"#424242"];
    }
}

-(void)createView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithHexString:@"#424242"];
    label.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    label.text = @"重复";
    [self.contentView addSubview:label];
    self.titleLab = label;
    
    UILabel *repeatLab = [UILabel new];
    repeatLab.text = @"永不";
    repeatLab.textAlignment = NSTextAlignmentRight;
    repeatLab.textColor = [UIColor colorWithHexString:@"#424242"];
    repeatLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    [self.contentView addSubview:repeatLab];
    self.repeatLab = repeatLab;
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.repeatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale, 14*YAYIScreenScale));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(16*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale, 14*YAYIScreenScale));
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(345*YAYIScreenScale, 1));
    }];
}
@end
