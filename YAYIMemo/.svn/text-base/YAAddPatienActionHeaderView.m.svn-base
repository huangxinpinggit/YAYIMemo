//
//  YAAddPatienActionHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddPatienActionHeaderView.h"

@implementation YAAddPatienActionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}


-(void)createView{
    self.contentView.userInteractionEnabled = YES;
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    self.backView = backView;
    
    UITextField *textfield = [UITextField new];
    textfield.delegate =self;
    textfield.font = YAFont(15);
    textfield.placeholder = @"添加标签";
    textfield.textColor = YAColor(@"#424242");
    [self.contentView addSubview:textfield];
    self.textfield = textfield;
    
    
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#f5f5f5");
    [self.contentView addSubview:hLine];
    self.hLineView = hLine;
    
    UIView *tagView = [UIView new];
    tagView.userInteractionEnabled = YES;
    tagView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:tagView];
    self.tagView = tagView;
    


    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = YES;
    [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"add-tags"] forState:UIControlStateNormal];
    [tagView addSubview:button];
    self.addBtn = button;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加患者..." forState:UIControlStateNormal];
    addButton.titleLabel.font = YAFont(15);
    [addButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitleColor:YAColor(@"#8a8a8a") forState:UIControlStateNormal];
    [tagView addSubview:addButton];
    self.addBtn1 = addButton;
    
    UILabel *hLine1 = [UILabel new];
    hLine1.backgroundColor = YAColor(@"#e7e7e7");
    [self.contentView addSubview:hLine1];
    self.hLine = hLine1;
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
    
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(self.backView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 10*YAYIScreenScale));
    }];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(self.hLineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 64*YAYIScreenScale));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.centerY.mas_equalTo(self.tagView.mas_centerY);
        make.height.equalTo(@40);
    }];
    
    [self.addBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addBtn.mas_right).offset(4);
        make.centerY.mas_equalTo(self.tagView.mas_centerY);
        make.height.equalTo(@40);
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.tagView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 1));
        
    }];
    
}

#pragma mark  =================
-(void)selectAction:(UIButton *)tap{
    
    if (_delegate && [_delegate respondsToSelector:@selector(addAction)]) {
        [_delegate addAction];
    }
}

#pragma mark ===========================

-(void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    if (_delegate && [_delegate respondsToSelector:@selector(tagName:)]) {
        [_delegate tagName:textField.text];
    }
}


@end
