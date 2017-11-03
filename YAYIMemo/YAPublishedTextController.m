//
//  YATextViewController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPublishedTextController.h"
@interface YAPublishedTextController ()<UITextViewDelegate>
@property (nonatomic, weak)UIButton *saveBtn;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *info;
@property (nonatomic, strong)UITextView *textView;
@end

@implementation YAPublishedTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem =  [self createButton:CGRectMake(0, 0, 40, 20) image:nil title:@"提交" font:YAFont(15) fontColor:YAColor(@"#b7b7b7") tag:101];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    [self createViews];
    self.automaticallyAdjustsScrollViewInsets = false;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  [self.textView becomeFirstResponder];
}
-(void)createViews{

    UITextView *textView = [UITextView new];
    textView.placeholder = @"开始填写...";
    textView.delegate = self;
    self.textView = textView;
    textView.placeholderColor = [UIColor colorWithHexString:@"#b7b7b7"];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20*YAYIScreenScale));
        make.top.equalTo(@(9*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(SCREEN_W-40*YAYIScreenScale, 200*YAYIScreenScale));
    }];
   
    
    

}
-(UIBarButtonItem *)createButton:(CGRect)rect image:(NSString*)image title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)color tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    self.saveBtn = button;
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateSelected];
    button.tag = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}
#pragma mark   =================
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.info = textView.text;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] ||
        ![[textView textInputMode] primaryLanguage]) {
        return NO;
    }
    
    if (text) {
        [self.saveBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        [self.saveBtn setTitleColor:YAColor(@"#b7b7b7") forState:UIControlStateNormal];
    }
}

#pragma mark ======================
-(void)saveAction:(UIButton *)sender{
   
    [self commitNet];
}
-(void)commitNet{
    [self.view endEditing:YES];
    if (self.info.length == 0) {
        [NSString showInfoWithStatus:@"请填写内容"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    param[@"userid"]= self.userid;
    param[@"info"] = self.info;
    [YAHttpBase POST:case_insert_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        [self.navigationController popViewControllerAnimated:YES];
        if (weakSelf.refreshedOperation) {
            weakSelf.refreshedOperation();
        }
    } failure:^(NSError *error) {
        
    }];

}
@end
