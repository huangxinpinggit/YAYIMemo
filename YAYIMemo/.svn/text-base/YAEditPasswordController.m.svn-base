//
//  YAEditPasswordController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAEditPasswordController.h"
#import "YATextField.h"
#import "MVMaterialButton.h"
@interface YAEditPasswordController ()<UITextFieldDelegate>

@property (nonatomic, weak)UITextField *oldText;
@property (nonatomic, weak)UITextField *nwText;
@property (nonatomic, strong)NSString *oldPwd;
@property (nonatomic, strong)NSString *nwPwd;

@end

@implementation YAEditPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)createView{
    UILabel *label = [UILabel new];
    label.textColor = YAColor(@"#424242");
    label.font = YAFont(13);
    label.text = @"当前密码";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23*YAYIScreenScale));
        make.top.mas_equalTo(@(18*YAYIScreenScale));
        make.height.equalTo(@(13*YAYIScreenScale));
    }];
    
    YATextField *oldPassText = [[YATextField alloc] init];
    oldPassText.delegate = self;
    oldPassText.tag = 1001;
    oldPassText.placeholder = @"请输入原密码";
    oldPassText.secureTextEntry = YES;
    oldPassText.delegate =self;
    oldPassText.returnKeyType = UIReturnKeyNext;
    oldPassText.backgroundColor = [UIColor whiteColor];
    oldPassText.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
    oldPassText.layer.borderWidth = 1.0*YAYIScreenScale;
    oldPassText.layer.cornerRadius = 5*YAYIScreenScale;
    oldPassText.font = YAFont(15);
    [self.view addSubview:oldPassText];
    self.oldText = oldPassText;
    [oldPassText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(label.mas_bottom).offset(9*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    [oldPassText becomeFirstResponder];
    
    
    UIButton *rightView = [UIButton buttonWithType:UIButtonTypeCustom];
    rightView.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
    [rightView addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    rightView.tag = 104;
    [rightView setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [rightView setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
    rightView.frame = CGRectMake(0, 0, 40*YAYIScreenScale, 40*YAYIScreenScale);
    oldPassText.rightView = rightView;
    oldPassText.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = YAColor(@"#424242");
    titleLab.font = YAFont(13);
    titleLab.text = @"新密码";
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23*YAYIScreenScale));
        make.top.mas_equalTo(oldPassText.mas_bottom).offset(10*YAYIScreenScale);
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
    rightView1.frame = CGRectMake(0, 0, 40*YAYIScreenScale, 40*YAYIScreenScale);
    [rightView1 addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    rightView1.tag = 105;
    newPassText.rightView = rightView1;

    [newPassText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(titleLab.mas_bottom).offset(9*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    
    UILabel *tipLab = [UILabel new];
    tipLab.textColor = YAColor(@"#424242");
    tipLab.font = YAFont(13);
    tipLab.text = @"密码由6-16位英文字母、数字或符号组成";
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

#pragma mark ================

-(void)showAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.tag == 104) {
        if (sender.selected) {
           self.oldText.secureTextEntry = false;
        }else{
           self.oldText.secureTextEntry = YES;
        }
    }else{
        if (sender.selected) {
            self.nwText.secureTextEntry = false;
        }else{
            self.nwText.secureTextEntry = YES;
        }
    }
    
}

-(void)saveAction:(UIButton *)sender{
     [self.view endEditing:YES];
    if (self.oldPwd.length == 0) {
        [NSString showInfoWithStatus:@"当前密码不能为空"];
        return;
    }else if (self.nwPwd.length == 0){
        [NSString showInfoWithStatus:@"新密码不能为空"];
        return;
    }else if ([self.oldPwd isEqualToString:self.nwPwd]){
        [NSString showInfoWithStatus:@"密码不能相同"];
        return;
    }else if (self.oldPwd.length <6){
        [NSString showInfoWithStatus:@"密码长度不少于6位"];
        return;
    }else if (self.nwPwd.length <6){
        [NSString showInfoWithStatus:@"密码长度不少于6位"];
        return;
    }else if (self.oldPwd.length >16){
        [NSString showInfoWithStatus:@"密码长度不超过22位"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"old_pwd"] = self.oldPwd;
    param[@"new_pwd"] = self.nwPwd;
    [YAHttpBase POST:update_password_url parameters:param success:^(id responseObject, int code) {
        [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark   ============================

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1001) {
        self.oldPwd = textField.text;
    }else{
        self.nwPwd = textField.text;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.nwText becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

@end
