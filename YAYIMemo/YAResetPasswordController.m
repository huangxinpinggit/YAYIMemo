//
//  YAEditMobileController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAResetPasswordController.h"
#import "YATextField.h"
#import "YASetNewMobileController.h"
#import "NSString+YA.h"
#import "YACommitResetPasswordController.h"
@interface YAResetPasswordController ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField *verifyText;
@property (nonatomic, assign)NSInteger s;
@property (nonatomic, weak)UIButton *verifyBtn;
@property (nonatomic,weak)NSString *content;
@property (nonatomic, weak)NSString *codeStr;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation YAResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.s = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"重置密码";
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [self createButton:CGRectMake(0, 0, 60, 30) image:@"s_Bback" title:nil font:nil fontColor:nil tag:101];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self createView];
}
-(void)createView{
    /*
    UILabel *label = [UILabel new];
    label.textColor = YAColor(@"#424242");
    label.font = YAFont(13);
    label.text = [NSString stringWithFormat:@"需要验证原手机号码：%@",self.mobile];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23*YAYIScreenScale));
        make.top.mas_equalTo(@(64+19*YAYIScreenScale));
        make.height.equalTo(@(13*YAYIScreenScale));
    }];
    
    YATextField *verifytext = [[YATextField alloc] init];
    verifytext.delegate = self;
    verifytext.tag = 1001;
    verifytext.placeholder = @"请输入验证码";
    verifytext.returnKeyType = UIReturnKeyDone;
    verifytext.font = YAFont(15);
    verifytext.delegate =self;
    verifytext.returnKeyType = UIReturnKeyDone;
    verifytext.backgroundColor = [UIColor whiteColor];
    verifytext.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
    verifytext.layer.borderWidth = 1.0*YAYIScreenScale;
    verifytext.layer.cornerRadius = 5*YAYIScreenScale;
    [verifytext placeholderRectForBounds:CGRectMake(10, 0, 200, 40)];
    [self.view addSubview:verifytext];
    [verifytext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(label.mas_bottom).offset(9*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];

    
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = YAColor(@"#424242");
    nextBtn.layer.cornerRadius = 5*YAYIScreenScale;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:YAColor(@"717070") forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(verifytext.mas_bottom).offset(25*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    leftView.backgroundColor = YAColor(@"#f5f5f5");
    [leftView setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    leftView.layer.cornerRadius = 5*YAYIScreenScale;
    leftView.frame = CGRectMake(0, 0, 100, 34);
    verifytext.rightView = leftView;
    self.verifyBtn = leftView;
    [leftView addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    leftView.titleLabel.font = YAFont(15);
    [leftView setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifytext.rightViewMode = UITextFieldViewModeAlways;
     */
    
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
    mobileText.placeholder = @"请输入手机号码";
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
    [leftView addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    leftView.backgroundColor = YAColor(@"#f5f5f5");
    [leftView setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    leftView.layer.cornerRadius = 5*YAYIScreenScale;
    leftView.frame = CGRectMake(0, 0, 100, 34);
    verifyText.rightView = leftView;
    self.verifyBtn = leftView;
    leftView.titleLabel.font = YAFont(15);
    [leftView setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifyText.rightViewMode = UITextFieldViewModeAlways;

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = YAColor(@"#424242");
    nextBtn.layer.cornerRadius = 5*YAYIScreenScale;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:YAColor(@"717070") forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(verifyText.mas_bottom).offset(25*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];

     

}

#pragma mark ================== delegate =============

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        self.mobile = textField.text;
    }else{
        self.content = textField.text;
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 101) {
        [self.verifyText becomeFirstResponder];
    }else{
        [self.verifyText resignFirstResponder];
    }
    return YES;
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
-(void)nextAction:(UIButton *)sender{
    if (self.content.length==0) {
        [NSString showInfoWithStatus:@"验证码不能为空"];
        return;
    }else if (![self.content isEqualToString:self.codeStr]){
        [NSString showInfoWithStatus:@"验证码输入有误"];
        return;
    }
     __weak typeof(self) weakSelf = self;
    [YAHttpBase GET:verifyCaptcha_url parameters:@{@"captcha":self.content} success:^(id responseObject, int code) {
        YACommitResetPasswordController *newMobile = [YACommitResetPasswordController new];
        newMobile.refreshedOperation = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        newMobile.mobile = self.mobile;
        [weakSelf.navigationController pushViewController:newMobile animated:YES];
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

-(UIBarButtonItem *)createButton:(CGRect)rect image:(NSString*)image title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)color tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateSelected];
    button.tag = tag;
       [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}
-(void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
