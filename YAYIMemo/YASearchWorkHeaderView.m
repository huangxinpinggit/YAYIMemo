//
//  YASearchWorkHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/19.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASearchWorkHeaderView.h"

@implementation YASearchWorkHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;

}
-(void)setDateString:(NSString *)dateString
{
    _dateString = dateString;
    if ([_dateString isEqualToString:[self todaydateStr]]) {
        self.titleLab.textColor = YAColor(@"#ff414c");
    }else{
        self.titleLab.textColor = YAColor(@"#424242");
    }
    self.titleLab.text = [NSString stringWithFormat:@"%@  %@",[_dateString substringFromIndex:5],[self weekdayStringFromDate:_dateString]];
}
-(void)createView{
    self.contentView.backgroundColor = YAColor(@"f3f4f6");
    UILabel *titleLab = [UILabel new];
    titleLab.font = YAFont(15);
    titleLab.textColor = YAColor(@"#424242");
    [self.contentView addSubview:titleLab];
    self.titleLab = titleLab;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#e7e7e7");
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    
    UILabel *topLine = [UILabel new];
    topLine.backgroundColor = YAColor(@"#e7e7e7");
    [self.contentView addSubview:topLine];
    self.topLine = topLine;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.size.mas_offset(CGSizeMake(SCREEN_W, 1));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_W, 1));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(22*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView);
    }];
}
- (NSString*)weekdayStringFromDate:(NSString*)inputDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年M月dd号 HH:mm:ss";
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",inputDate,@"00:00:00"]];
    NSLog(@"%@",date);
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

-(NSString *)todaydateStr{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年M月dd号";
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:zone];
    return [formatter stringFromDate:date];

}
@end
