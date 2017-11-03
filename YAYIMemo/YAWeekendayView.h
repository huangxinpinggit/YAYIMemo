//
//  YAWeekendayView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YADateUntil.h"
@interface YAWeekendayView : UIView
@property (nonatomic, strong)NSArray *titleAry;
@property (nonatomic, strong)UIFont  *font;
@property (nonatomic, strong)UIColor *textNormalColor;
@property (nonatomic, strong)UIColor *textLightColor;
@property (nonatomic, weak)  UIView  *indicatorView;
@property (nonatomic, assign)NSInteger  weekday;
@property (nonatomic, strong)NSMutableArray *labArray;
@property (nonatomic, strong)YADateUntil *dateUtil;
@end
