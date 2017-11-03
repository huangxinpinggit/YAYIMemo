//
//  YAWorkEventModel.m
//  YAYIMemo
//
//  Created by hxp on 17/9/18.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAWorkEventModel.h"

@implementation YAWorkEventModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

-(NSString *)worktime
{
    NSString *wktime = [NSString stringWithFormat:@"%@",_worktime];
    return [self timeWithTimeIntervalString:wktime formatter:@"HH:mm"];
}


-(NSString *)month
{
    if (_month == nil) {
        NSString *wktime = [NSString stringWithFormat:@"%@",_worktime];
        _month = [self timeWithTimeIntervalString:wktime formatter:@"yyyy年M月dd号"];
        
    }
    return _month;
}

//时间戳转化为时间NSDate
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString formatter:(NSString *)formater
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formater];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
