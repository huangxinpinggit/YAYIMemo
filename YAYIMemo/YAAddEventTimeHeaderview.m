//
//  YAAddEventTimeHeaderview.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventTimeHeaderview.h"

@implementation YAAddEventTimeHeaderview

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self ;
}
-(void)setTimeStr:(NSString *)timeStr
{
    _timeStr = timeStr;
    if (timeStr.length > 4) {
        self.timeLab.text = timeStr;
        self.timeLab.textColor = [UIColor colorWithHexString:@"#ff414c"];
    }else{
       self.timeLab.text = [self timeStr:[NSDate date]];
       self.timeLab.textColor = [UIColor colorWithHexString:@"#424242"];
    }
   
}
-(void)createView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    
    label.textColor = [UIColor colorWithHexString:@"#424242"];
    label.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    label.text = @"时间";
    [self.contentView addSubview:label];
    self.titleLab = label;
    
    UILabel *timeLab = [UILabel new];
    
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.textColor = [UIColor colorWithHexString:@"#424242"];
    timeLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    self.timeLab.text = [self timeStr:[NSDate date]];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(NSString *)timeStr:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    formatter.dateFormat = @"HH:mm";
    formatter.timeZone = zone;
    NSLog(@"%@",[formatter stringFromDate:date]);
    return [formatter stringFromDate:date];
}

@end
