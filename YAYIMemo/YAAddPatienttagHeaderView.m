//
//  YAAddPatienttagHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddPatienttagHeaderView.h"

@implementation YAAddPatienttagHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView{
    self.contentView.backgroundColor = YAColor(@"#f5f5f5");
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    self.backView = backView;
    
    UITextField *textField = [UITextField new];
    textField.placeholder = @"添加标签";
    textField.font = YAFont(15);
    textField.delegate = self;
    textField.backgroundColor = [UIColor whiteColor];
    
    [backView addSubview:textField];
    self.textfield = textField;
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.mas_equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(SCREEN_W , 64*YAYIScreenScale));
    }];
    
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(@(17*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 30*YAYIScreenScale));
    }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(openAction)]) {
        [_delegate openAction];
    }
    return false;
}

@end
