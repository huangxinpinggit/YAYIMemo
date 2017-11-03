//
//  YACommitResetPasswordController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/19.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACommitResetPasswordController.h"
#import "MVMaterialButton.h"
#import "YATextField.h"
@interface YACommitResetPasswordController ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *nwText;
@property (nonatomic, strong)NSString *password;
@end

@implementation YACommitResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)createView{

    UILabel *label = [UILabel new];
    label.textColor = YAColor(@"#424242");
    label.font = YAFont(13);
    label.text = @"重新设置登录密码";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23*YAYIScreenScale));
        make.top.mas_equalTo(@(19*YAYIScreenScale));
        make.height.equalTo(@(13*YAYIScreenScale));
    }];
    
    YATextField *newPassText = [[YATextField alloc] init];
    newPassText.delegate = self;
    newPassText.tag = 1002;
    newPassText.delegate = self;
    newPassText.font = YAFont(15);
    newPassText.secureTextEntry = YES;
    newPassText.placeholder = @"请输入新密码";
    newPassText.returnKeyType = UIReturnKeyDone;
    newPassText.backgroundColor = [UIColor whiteColor];
    newPassText.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
    newPassText.layer.borderWidth = 1.0*YAYIScreenScale;
    newPassText.layer.cornerRadius = 5*YAYIScreenScale;
    [self.view addSubview:newPassText];
    self.nwText = newPassText;
    newPassText.rightViewMode = UITextFieldViewModeAlways;
    UIButton *rightView1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightView1.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
    [rightView1 setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [rightView1 setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
    rightView1.frame = CGRectMake(0, 0, 40, 40);
    [rightView1 addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    rightView1.tag = 105;
    newPassText.rightView = rightView1;
    
    [newPassText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(label.mas_bottom).offset(9*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    
    UILabel *tipLab = [UILabel new];
    tipLab.textColor = YAColor(@"#424242");
    tipLab.font = YAFont(13);
    tipLab.text = @"密码由6-20位英文字母、数字或符号组成";
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23*YAYIScreenScale));
        make.top.mas_equalTo(newPassText.mas_bottom).offset(10*YAYIScreenScale);
        make.height.equalTo(@(13*YAYIScreenScale));
    }];
    
    MVMaterialButton *saveBtn = [MVMaterialButton buttonWithType:UIButtonTypeCustom];
    saveBtn.overlayColor = [UIColor colorWithWhite:0 alpha:0.1];
    saveBtn.backgroundColor = YAColor(@"#424242");
    saveBtn.layer.cornerRadius = 5*YAYIScreenScale;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"完成" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(tipLab.mas_bottom).offset(10*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    
    
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.password = textField.text;
}

-(void)showAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.nwText.secureTextEntry = false;
    }else{
        self.nwText.secureTextEntry = YES;
    }
}

-(void)saveAction:(UIButton *)sender{
    if (self.password== nil) {
        [NSString showInfoWithStatus:@"密码不能为空"];
        return;
    }else if (self.password.length<6&& self.password.length >20){
        [NSString showInfoWithStatus:@"密码长度不合法"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = self.mobile;
    param[@"password"] = self.password;
    NSLog(@"%@",param);
    [YAHttpBase POST: forgetPwd_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        if (_refreshedOperation) {
            _refreshedOperation();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
