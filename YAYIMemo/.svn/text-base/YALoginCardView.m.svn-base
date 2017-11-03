//
//  YACarView.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/23.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YALoginCardView.h"

@implementation YALoginCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBackView];
    }
    return self;
    
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self createBackView];
    }
    return self;
}

-(void)createBackView{
    UIImageView *backView = [UIImageView new];
    backView.image = [UIImage imageNamed:@"shape"];
    backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:backView];
    self.backgroundView = backView;
    self.backgroundView.userInteractionEnabled = YES;
    
    
    
    
    UIImage *avatar = [UIImage imageNamed:@"head"];
    UIImageView *avaterView = [UIImageView new];
    avaterView.image = avatar;
    [avaterView zy_cornerRadiusAdvance:24*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    [avaterView zy_attachBorderWidth:1*YAYIScreenScale color:YAColor(@"#e7e7e7")];
    avaterView.frame = CGRectMake(self.width/2.0-avatar.size.width/2.0*YAYIScreenScale, 22*YAYIScreenScale,avatar.size.width*YAYIScreenScale ,avatar.size.height*YAYIScreenScale );
    [self addSubview:avaterView];
    self.avater = avaterView;
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]) {
        NSString *avatar = [[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"];
        [self.avater sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"head"]];
    }

    
    
    
    UITextField *mobileText = [UITextField new];
    mobileText.textAlignment = NSTextAlignmentCenter;
    mobileText.returnKeyType = UIReturnKeyNext;
    mobileText.delegate = self;
    mobileText.tag = 101;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    mobileText.attributedPlaceholder = attributedString;
    mobileText.font = YAFont(14);
    self.mobileText = mobileText;
    mobileText.textColor = YAColor(@"#424242");
    [self.backgroundView addSubview:mobileText];
    
    [mobileText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avater.mas_bottom).offset(39*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 38*YAYIScreenScale));
    }];
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#f3f4f6");
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mobileText.mas_bottom).offset(0*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 2*YAYIScreenScale));
    }];
    
    UITextField *passwordText = [UITextField new];
    passwordText.textAlignment = NSTextAlignmentCenter;
    NSAttributedString *passattributedString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    passwordText.attributedPlaceholder = passattributedString;
    passwordText.font = YAFont(14);
    passwordText.secureTextEntry = YES;
    passwordText.delegate = self;
    passwordText.keyboardType = UIReturnKeyDone;
    passwordText.textColor = YAColor(@"#424242");
    [self.backgroundView addSubview:passwordText];
    self.passwordText = passwordText;
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine.mas_bottom).offset(20*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.width.and.height.mas_equalTo(mobileText);
    }];
    
    UILabel *hLine2 = [UILabel new];
    hLine2.backgroundColor = YAColor(@"#f3f4f6");
    [self addSubview:hLine2];
    [hLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordText.mas_bottom).offset(0*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.width.and.height.equalTo(hLine);
    }];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [setBtn setTitleColor:YAColor(@"#99959a") forState:UIControlStateNormal];
    setBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [setBtn addTarget:self action:@selector(resetPassword:) forControlEvents:UIControlEventTouchUpInside];
    setBtn.titleLabel.font = YAFont(14);
    
    [self.backgroundView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(hLine2.mas_right);
        make.top.mas_equalTo(hLine2.mas_bottom).offset(8*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(80*YAYIScreenScale, 20*YAYIScreenScale));
    }];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 17*YAYIScreenScale;
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = YAColor(@"#424242");
    [backView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine2.mas_bottom).offset(48*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(109*YAYIScreenScale, 35*YAYIScreenScale));
    }];
    
    /*
    UILabel *titleLab = [UILabel new];
    titleLab.attributedText = [self titleString:@"登录"];
    titleLab.font = YAFont(12);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@(-24*YAYIScreenScale));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
     */
}
#pragma mark   ======================
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]) {
        NSString *avatar = [[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"];
        [self.avater sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"head"]];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        NSString *mobile = [[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"];
        NSString *avatar = [[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"];
        if ([mobile isEqualToString:self.mobileText.text]) {
            [self.avater sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"head"]];
        }else{
            self.avater.image = [UIImage imageNamed:@"head"];
        }
        self.mobileText.text = self.mobileText.text;
        
    }else{
        self.passwordText.text = self.passwordText.text;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.passwordText becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark ======================

-(void)loginAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(loginPost:password:)]) {
        [_delegate loginPost:self.mobileText.text password:self.passwordText.text];
    }
    
    
}


-(void)resetPassword:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(resetPassword)]) {
        [_delegate resetPassword];
    }
    
}@end
