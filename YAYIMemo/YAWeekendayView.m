//
//  YAWeekendayView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAWeekendayView.h"

@implementation YAWeekendayView
{
    NSTimer *_timer;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleAry = @[@"SU", @"MO", @"TU", @"WE", @"TH", @"FR", @"SA"];
        _labArray = [NSMutableArray array];
        self.dateUtil = [YADateUntil new];
       
        self.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
        self.textNormalColor = [UIColor colorWithHexString:@"#b7b7b7"];
        [self createView];
        [self createIndicatorView];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateWeekday) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];;
    }
    return self;
}

-(void)createView{
    CGFloat leftMargin = 15*YAYIScreenScale;
    CGFloat midMargin = 2*YAYIScreenScale;
    CGFloat w = (SCREEN_W -leftMargin*2 - 6*midMargin)/7.0;
    for (int i = 0; i<_titleAry.count; i++) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = self.font;
       
        label.textColor = self.textNormalColor;
        label.text = _titleAry[i];
        [self addSubview:label];
        [_labArray addObject:label];
        label.frame = CGRectMake(leftMargin+i*(w+midMargin), 0, w, 42*YAYIScreenScale);
    }
}
-(void)updateWeekday{
  NSInteger week =  [self.dateUtil todayWeekdayInThisMonth:[NSDate date]];
    UILabel *label =_labArray[week-1];
    label.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(label.frame.origin.x));
    }];
}

-(void)createIndicatorView{
    CGFloat w = (SCREEN_W -15*YAYIScreenScale*2 - 6*2*YAYIScreenScale)/7.0;
    UIView *indicatorView = [UIView new];
    
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.equalTo(@(32*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(w, 6*YAYIScreenScale));
    }];
    
    UILabel *circle1 = [UILabel new];
    circle1.layer.masksToBounds = YES;
    circle1.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    circle1.layer.borderWidth = 1;
    circle1.layer.cornerRadius =2*YAYIScreenScale;
    [indicatorView addSubview:circle1];
    [circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(indicatorView.mas_centerX).offset(-2*YAYIScreenScale);
        make.centerY.mas_equalTo(indicatorView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(4, 4));
    }];
    
    UILabel *circle2 = [UILabel new];
    circle2.layer.masksToBounds = YES;
    circle2.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    circle2.layer.borderWidth = 1;
    circle2.layer.cornerRadius =2*YAYIScreenScale;
    [indicatorView addSubview:circle2];
    [circle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(indicatorView.mas_centerX).offset(2*YAYIScreenScale);
        make.centerY.mas_equalTo(indicatorView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(4, 4));
    }];
}
-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}
@end
