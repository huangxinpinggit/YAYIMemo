//
//  YAEditNameController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAEditNameController.h"
#import "YATextField.h"
@interface YAEditNameController ()<UITextFieldDelegate>

@property (nonatomic, weak)UIButton *saveBtn;
@end

@implementation YAEditNameController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"昵称";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [button setTitleColor:[UIColor colorWithHexString:@"#b7b7b7"] forState:UIControlStateNormal];
   
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 20);
    self.saveBtn = button;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    [self createTextField];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)createTextField{
    YATextField *textfield = [[YATextField alloc] init];
    textfield.delegate = self;
    textfield.returnKeyType = UIReturnKeyDone;
    textfield.backgroundColor = [UIColor whiteColor];
    textfield.placeholder = self.name;
    textfield.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
    textfield.layer.borderWidth = 1.0*YAYIScreenScale;
    textfield.layer.cornerRadius = 5*YAYIScreenScale;
    [self.view addSubview:textfield];
    
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.equalTo(@(18*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 30*YAYIScreenScale, 43*YAYIScreenScale));
    }];
    [textfield becomeFirstResponder];
    

}




-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >0) {
        [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    }else{
        [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"#b7b7b7"] forState:UIControlStateNormal];
    }
    
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
   
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"#b7b7b7"] forState:UIControlStateNormal];
    }
    self.name = textField.text;
}

#pragma mark ===============================

-(void)saveAction:(UIButton *)sender{
    [self updateName];
}
-(void)updateName{
     [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = self.name;
    [YAHttpBase POST:update_user_name parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        if (weakSelf.refreshedOperation) {
            weakSelf.refreshedOperation();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
