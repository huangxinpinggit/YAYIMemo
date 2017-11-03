//
//  YAItemOfdayCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAItemOfdayCell.h"

@implementation YAItemOfdayCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textNormalColor = [UIColor colorWithHexString:@"#424242"];
        self.textLightColor = [UIColor whiteColor];
        self.beyondColor = [UIColor colorWithHexString:@"#b7b7b7"];
        self.eventNormalColor = [UIColor colorWithHexString:@"#b7b7b7"];
        self.eventLightColor = YA_COLOR(131, 108, 251);
        [self createViews];
    }
    return self;
}
/*
-(void)setSelected:(BOOL)selected
{
    
    if (selected) {
        self.titleLab.layer.borderColor = [UIColor colorWithHexString:@"#ff414c"].CGColor;
        self.titleLab.layer.borderWidth = 1.0;
    }else{
        self.titleLab.layer.borderWidth = 0.0;
    }
    selected = !selected;
}
 */

-(void)setModel:(YAItemModel *)model
{
    _model = model;
    [self loadData];
}
-(void)loadData{
    self.titleLab.text = _model.day;
    if (_model.isBeyond) {
        self.titleLab.textColor = self.beyondColor;
    }else{
        self.titleLab.textColor = self.textNormalColor;
    }
    if (_model.isToday) {
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleView.backgroundColor = [UIColor colorWithHexString:@"#ff414c"];
        self.evetnLab.backgroundColor = [UIColor whiteColor];
    }else{
        self.titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (_model.isEvent && _model.isToday) {
        self.evetnLab.backgroundColor = [UIColor whiteColor];
    }else if (_model.isEvent && !_model.isBeyond && !_model.isNext){
        self.evetnLab.backgroundColor = self.eventNormalColor;
    }else if(_model.isEvent && !_model.isBeyond && _model.isNext){
        self.evetnLab.backgroundColor = self.eventLightColor;
    }else{
       self.evetnLab.backgroundColor = [UIColor clearColor];
    }
    if (_model.isSelected) {
        self.titleLab.layer.borderColor = [UIColor colorWithHexString:@"#ff414c"].CGColor;
        self.titleLab.layer.borderWidth = 1.0;
    }else{
       self.titleLab.layer.borderWidth = 0.0;
    }
    //_model.isSelected = !_model.isSelected;
}
 -(void)setISSelected:(BOOL)iSSelected
{
    _iSSelected = iSSelected;
    if (_iSSelected) {
        self.titleLab.layer.borderColor = [UIColor colorWithHexString:@"#ff414c"].CGColor;
        self.titleLab.layer.borderWidth = 1.0;
    }else{
        self.titleLab.layer.borderWidth = 0.0;
    }
}
-(void)createViews{
    
   
    UIView *v = [UIView new];
    v.layer.cornerRadius=33*YAYIScreenScale/2.0;
    v.layer.shadowColor=[UIColor colorWithHexString:@"#000000"].CGColor;
    v.layer.shadowOffset=CGSizeMake(1, 1);
    v.layer.shadowOpacity=0.25;
    [self.contentView addSubview:v];
    self.titleView = v;
    
    UILabel *label = [UILabel new];
    label.textColor = self.textNormalColor;
    label.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 33*YAYIScreenScale/2.0;
    [self.contentView addSubview:label];
    self.titleLab = label;
    
    UILabel *eventLab = [UILabel new];
    eventLab.layer.masksToBounds = YES;
    eventLab.backgroundColor = [UIColor clearColor];
    eventLab.layer.cornerRadius = 3*YAYIScreenScale;
    [self.contentView addSubview:eventLab];
    self.evetnLab = eventLab;
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(33*YAYIScreenScale, 33*YAYIScreenScale));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleView.mas_centerX);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(33*YAYIScreenScale, 33*YAYIScreenScale));
    }];
    
    [self.evetnLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_centerY).offset(7*YAYIScreenScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(6*YAYIScreenScale, 6*YAYIScreenScale));
    }];
    
}
@end
