//
//  YADateUntil.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YADateUntil : NSObject
@property (nonatomic,strong) NSCalendar *gregorian;

// 获取 天
- (NSInteger)min:(NSDate *)date;
// 获取 天
- (NSInteger)hour:(NSDate *)date;
// 获取 天
- (NSInteger)day:(NSDate *)date;
// 获取 月
- (NSInteger)month:(NSDate *)date;
// 获取 年
- (NSInteger)year:(NSDate *)date;
//
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
// 每个月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;
// 上个月
- (NSDate *)lastMonth:(NSDate *)date;
// 下个月
- (NSDate*)nextMonth:(NSDate *)date;
//获取日期
-(NSDate *)getDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
//今天周几
-(NSInteger)todayWeekdayInThisMonth:(NSDate *)date;
@end
