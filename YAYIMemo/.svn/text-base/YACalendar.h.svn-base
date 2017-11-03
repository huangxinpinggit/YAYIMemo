//
//  YACalendar.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAHeaderView.h"
#import "YAWeekendayView.h"
#import "YACalenderCollectionView.h"
#import "YADateUntil.h"

@protocol  YACalendarDelegate <NSObject>

-(void)updateData:(NSString *)worktime date:(NSString *)date;

@end

@interface YACalendar : UIView<UIScrollViewDelegate,YAHeaderViewDelegate,YACalenderCollectionViewDelegate>
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)YAHeaderView *header;
@property (nonatomic, strong)YADateUntil *dateUntil;
@property (nonatomic, weak)id<YACalendarDelegate> delegate;
@property (nonatomic, strong)NSString *patientid;
@property (nonatomic, assign)BOOL isFreshed;
@end
