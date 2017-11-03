//
//  YAAddEventTimeCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/7.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YADateUntil.h"

@protocol YAAddEventTimeCellDelegate <NSObject>

-(void)timeWithHour:(NSString *)hour minute:(NSString *)min;

@end

@interface YAAddEventTimeCell : UITableViewCell<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)UIPickerView *pickerView;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, assign)NSInteger hour;
@property (nonatomic, assign)NSInteger min;
@property (nonatomic, weak)id <YAAddEventTimeCellDelegate>delegate;
@property (nonatomic, strong)YADateUntil *dateUtil;
@end
