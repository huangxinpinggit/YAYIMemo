//
//  YARegisterCardView.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/23.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YARegisterCardView.h"
#import "NSString+YA.h"
@implementation YARegisterCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.s = 60;
        [self createView];
        self.registerBtn.hidden = YES;
    }
    return self;
    
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

// 注册
-(void)createView{
    
    UIImageView *backView = [UIImageView new];
    backView.image = [UIImage imageNamed:@"shape"];
    backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:backView];
    self.registerBackView = backView;
    self.registerBackView.userInteractionEnabled = YES;
        
    UIImage *avatar = [UIImage imageNamed:@"head"];
    UIImageView *avaterView = [UIImageView new];
    avaterView.image = avatar;
    avaterView.frame = CGRectMake(self.width/2.0-avatar.size.width/2.0*YAYIScreenScale, 24*YAYIScreenScale,avatar.size.width *YAYIScreenScale ,avatar.size.height *YAYIScreenScale );
    [self addSubview:avaterView];
    self.avater = avaterView;
    
    
    UITextField *mobileText = [UITextField new];
    mobileText.textAlignment = NSTextAlignmentCenter;
    mobileText.returnKeyType = UIReturnKeyNext;
    mobileText.delegate = self;
    self.mobileText = mobileText;
    mobileText.tag = 101;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    mobileText.attributedPlaceholder = attributedString;
    mobileText.font = YAFont(14);
    mobileText.textColor = YAColor(@"#424242");
    [backView addSubview:mobileText];
    [mobileText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avater.mas_bottom).offset(15*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 35*YAYIScreenScale));
    }];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#f3f4f6");
    [backView addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mobileText.mas_bottom).offset(0*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 2*YAYIScreenScale));
    }];
    
    // 验证码
    UITextField *verifyText = [UITextField new];
    verifyText.textAlignment = NSTextAlignmentCenter;
    verifyText.returnKeyType = UIReturnKeyNext;
    NSAttributedString *verifyattributedString = [[NSAttributedString alloc] initWithString:@"请输入验证码  " attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    verifyText.attributedPlaceholder = verifyattributedString;
    verifyText.font = YAFont(14);
    verifyText.tag = 102;
    verifyText.delegate = self;
    self.verifyText = verifyText;
    verifyText.textColor = YAColor(@"#424242");
    [backView addSubview:verifyText];
    [verifyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.and.height.mas_equalTo(mobileText);
        make.top.mas_equalTo(hLine.mas_bottom).offset(20*YAYIScreenScale);
        make.width.equalTo(@(120*YAYIScreenScale));
    }];
    
    
    
    UILabel *hLine2 = [UILabel new];
    hLine2.backgroundColor = YAColor(@"#f3f4f6");
    [backView addSubview:hLine2];
    [hLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(hLine);
        make.top.mas_equalTo(verifyText.mas_bottom).offset(0*YAYIScreenScale);
    }];
    
    UITextField *passwordText = [UITextField new];
    passwordText.delegate = self;
    passwordText.tag = 103;
    passwordText.secureTextEntry = YES;
    passwordText.returnKeyType = UIReturnKeyDone;
    NSAttributedString *passwordattributedString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    passwordText.attributedPlaceholder = passwordattributedString;
    [backView addSubview:passwordText];
    self.passwordText = passwordText;
    passwordText.textAlignment = NSTextAlignmentCenter;
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(verifyText);
        make.top.mas_equalTo(hLine2.mas_bottom).offset(20*YAYIScreenScale);
    }];
    
    UILabel *hLine3 = [UILabel new];
    hLine3.backgroundColor = YAColor(@"#f3f4f6");
    [backView addSubview:hLine3];
    [hLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(hLine);
        make.top.mas_equalTo(passwordText.mas_bottom).offset(0*YAYIScreenScale);
    }];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 17*YAYIScreenScale;
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor = YAColor(@"#424242");
    self.registerBtn = registerBtn;
    [backView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine3.mas_bottom).offset(14*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(109*YAYIScreenScale, 35*YAYIScreenScale));
    }];
    
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftView addTarget:self action:@selector(sendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [leftView setTitleColor:YAColor(@"#99959a") forState:UIControlStateNormal];
    leftView.layer.cornerRadius = 5*YAYIScreenScale;
    
    self.verifyBtn = leftView;
    leftView.titleLabel.font = YAFont(15);
    [leftView setTitle:@"获取" forState:UIControlStateNormal];
    [backView addSubview:leftView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verifyText.mas_right);
        make.centerY.mas_equalTo(self.verifyText.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 34));
    }];
  
    
    
}



// 用户协议
-(NSMutableAttributedString *)titleString:(NSString *)title{
    NSString *baseStr = @"完成意味着同意小牙签的《用户协议》";
    NSString *str = [NSString stringWithFormat:@"%@%@",title,baseStr];
    NSMutableAttributedString *muattr = [[NSMutableAttributedString alloc] initWithString:str];
    [muattr addAttribute:NSForegroundColorAttributeName value:YAColor(@"#99959a") range:NSMakeRange(0, 13)];
    [muattr addAttribute:NSForegroundColorAttributeName value:YAColor(@"#424242") range:NSMakeRange(14, 5)];
    return muattr;
}

#pragma mark   ======================

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        self.mobileText.text = self.mobileText.text;
    }else if(textField.tag == 102){
        self.verifyText.text = textField.text;
    }else{
        self.passwordText.text = self.passwordText.text;
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext && textField.tag == 101) {
        [self.verifyText becomeFirstResponder];
    }else if(textField.tag == 102){
        [self.passwordText becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark =======

-(void)sendVerifyCode:(UIButton *)sender{
    
    // 1. 验证手机号的合法性
    NSString *checkMobileMsg = [NSString valiMobile:self.mobileText.text];
    if(checkMobileMsg != nil)
    {
        [SVProgressHUD showInfoWithStatus:checkMobileMsg];
        return;
    }
    [self getVerifyCode:sender];
    
}

-(void)getVerifyCode:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] =  self.mobileText.text;
    [YAHttpBase GET:getCaptcha_url parameters:param success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        weakSelf.codeStr = responseObject[@"data"];
        [weakSelf showHud:@"验证码已经发送，请注意查收"];
        
        //修改按钮状态
        [sender setTitle:@"(60)" forState:UIControlStateNormal];
        if (weakSelf.timer == nil) {
            weakSelf.timer = [NSTimer  scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(count:) userInfo:nil repeats:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)showHud:(NSString *)content{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = content;
    [hud hideAnimated:YES afterDelay:1.5];
    [hud removeFromSuperViewOnHide];
}

-(void)count:(NSTimer *)timer{
    self.s -= 1;
    [self.verifyBtn setTitle:[NSString stringWithFormat:@"(%ld)",self.s] forState:UIControlStateNormal];
    if (self.s == 0) {
        self.s = 60;
        [self.timer invalidate];
        [self.verifyBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        
        self.timer = nil;
        self.verifyBtn.enabled = YES;
    }
    
}

-(void)registerAction:(UIButton *)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(registerPost:password: verify: codeStr:)]) {
        [_delegate registerPost:self.mobileText.text password:self.passwordText.text verify:self.verifyText.text codeStr:self.codeStr];
    }
    
    
}

@end
