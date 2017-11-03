//
//  YAAddEventTimeCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/7.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventTimeCell.h"

@implementation YAAddEventTimeCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateUtil = [YADateUntil new];
        [self createView];
    }
    return self;
}
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        
       
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 345*YAYIScreenScale, 41*5*YAYIScreenScale)];
        [_pickerView setBackgroundColor:[UIColor colorWithHexString:@"#fafafa"]];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
    }
    return _pickerView;
}


-(void)createView{
    
    [self.contentView addSubview:self.pickerView];
    
    
    self.hour = [self.dateUtil hour:[NSDate date]];
    self.min = [self.dateUtil min:[NSDate  date]];
    [self.pickerView selectRow:self.hour inComponent:1 animated:YES];
    [self.pickerView selectRow:self.min inComponent:2 animated:YES];
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(345*YAYIScreenScale, 1));
    }];

}

#pragma mark =================

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 41*YAYIScreenScale;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 1;
    }else if (component == 1){
        return 24;
    }else if(component == 2){
        return 59;
    }else{
        return 59;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor =[UIColor colorWithHexString:@"#e7e7e7"];
            CGRect rect = singleLine.frame;
            rect.size.height = 1;
            [singleLine setFrame:rect];
        }
    }
    
   
   
    UILabel *label = [[UILabel alloc]init];
    NSString *text = nil;
    if (component == 0) {
        text = @"开始时间";
        label.textAlignment =NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    }else if (component == 1){
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:YAYIFontWithScale(18)];
        text = [NSString stringWithFormat:@"%ld",row];
    }else{
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:YAYIFontWithScale(18)];
        text = [NSString stringWithFormat:@"%ld",row];
    }
    label.textColor = [UIColor colorWithHexString:@"#424242"];
    label.text = text;
    label.bounds = CGRectMake(0, 0, 345*YAYIScreenScale/3,41*YAYIScreenScale);
    return label;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 345*YAYIScreenScale/3;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 1:
            self.hour = row;
            break;
        case 2:
            self.min = row;
            break;
            
        default:
            break;
    }
    NSString *hour = nil;
    NSString *min = nil;
    if (self.hour <10) {
        hour = [NSString stringWithFormat:@"0%ld",self.hour];
    }else{
        hour = [NSString stringWithFormat:@"%ld",self.hour];
    }
    
    if (self.min <10) {
        min = [NSString stringWithFormat:@"0%ld",self.min];
    }else{
        min = [NSString stringWithFormat:@"%ld",self.min];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(timeWithHour:minute:)]) {
        [_delegate timeWithHour:hour minute:min];
    }
    
}
@end
