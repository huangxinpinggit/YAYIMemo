//
//  YASetNewMobileController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASetNewMobileController.h"
#import "YATextField.h"
#import "NSString+YA.h"
@interface YASetNewMobileController ()<UITextFieldDelegate>
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *content;

@property (nonatomic, weak)UIButton *verifyBtn;
@property (nonatomic, weak)NSString *codeStr;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger s;
@property (nonatomic, weak)UITextField *verifyText;
@end

@implementation YASetNewMobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.s = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改手机号码";
    
    [self createViews];
}

-(void)createViews{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = YAColor(@"#e7e7e7").CGColor;
    bgView.layer.borderWidth = 1.0*YAYIScreenScale;
    bgView.layer.cornerRadius = 5*YAYIScreenScale;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(18*YAYIScreenScale));
        make.left.equalTo(@(15*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale,88*YAYIScreenScale ));
    }];
    
    YATextField *mobileText = [YATextField new];
    mobileText.placeholder = @"请输入新手机号码";
    mobileText.font = YAFont(15);
    mobileText.tag = 101;
    mobileText.returnKeyType = UIReturnKeyNext;
    mobileText.textColor = YAColor(@"#424242");
    mobileText.delegate = self;
    [bgView addSubview:mobileText];
    [mobileText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W-32*YAYIScreenScale, 44*YAYIScreenScale));
    }];
    [mobileText becomeFirstResponder];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#e7e7e7");
    [bgView addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(mobileText.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 32*YAYIScreenScale, 1*YAYIScreenScale));
    }];
    
    YATextField *verifyText = [YATextField new];
    verifyText.placeholder = @"请输入短信验证码";
    verifyText.font = YAFont(15);
    verifyText.tag = 102;
    verifyText.delegate = self;
    verifyText.returnKeyType = UIReturnKeyDone;
    verifyText.textColor = YAColor(@"#424242");
    [bgView addSubview:verifyText];
    self.verifyText = verifyText;
    [verifyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(hLine.mas_bottom);
        make.width.and.height.mas_equalTo(mobileText);
    }];
    
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftView addTarget:self action:@selector(sendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    leftView.backgroundColor = YAColor(@"#f5f5f5");
    [leftView setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    leftView.layer.cornerRadius = 5*YAYIScreenScale;
    leftView.frame = CGRectMake(0, 0, 100, 34*YAYIScreenScale);
    verifyText.rightView = leftView;
    self.verifyBtn = leftView;
    leftView.titleLabel.font = YAFont(15);
    [leftView setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifyText.rightViewMode = UITextFieldViewModeAlways;
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     saveBtn.backgroundColor = YAColor(@"#424242");
    saveBtn.layer.cornerRadius = 5*YAYIScreenScale;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"完成" forState:UIControlStateNormal];
    [saveBtn setTitleColor:YAColor(@"#ffffff") forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(verifyText.mas_bottom).offset(25*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    

}

#pragma mark   ==========================

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 101){
        self.mobile = textField.text;
    }else{
        self.content = textField.text;
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.verifyText becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark ====================================


-(void)saveAction:(UIButton *)sender{
    if (self.content.length==0) {
        [NSString showInfoWithStatus:@"验证码不能为空"];
        return;
    }else if (![self.content isEqualToString:self.codeStr]){
        [NSString showInfoWithStatus:@"验证码输入有误"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [YAHttpBase GET:verifyCaptcha_url parameters:@{@"captcha":self.content} success:^(id responseObject, int code) {
        [weakSelf updateMobile:weakSelf.mobile];
    } failure:^(NSError *error) {
        
    }];
}

-(void)sendVerifyCode:(UIButton *)sender{
    
    // 1. 验证手机号的合法性
    NSString *checkMobileMsg = [NSString valiMobile:self.mobile];
    if(checkMobileMsg != nil)
    {
        [NSString showInfoWithStatus:checkMobileMsg];
        return;
    }else{
        if ([self.oldMobile isEqualToString:self.mobile]) {
            [NSString showInfoWithStatus:@"不能和当前手机号一样"];
            return;
        }
    }
    [self getVerifyCode:sender];
    
}

-(void)getVerifyCode:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = self.mobile;
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
-(void)updateMobile:(NSString *)mobile{
     [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = self.mobile;
    [YAHttpBase POST:update_user_mobile parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
        if (_refreshedOperation) {
            self.refreshedOperation();
        }
        
    } failure:^(NSError *error) {
        
    }];

}
@end
