//
//  YAFeedbackViewController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAFeedbackViewController.h"

@interface YAFeedbackViewController ()<UITextViewDelegate>
@property (nonatomic, weak)UIButton *saveBtn;
@property (nonatomic, strong)NSString *info;
@end

@implementation YAFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    self.navigationItem.title = @"意见反馈";
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
//    UIBarButtonItem *leftItem = [self createButton:CGRectMake(0, 0, 60, 30) image:@"s_Bback" title:nil font:nil fontColor:nil tag:101];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    
    UIBarButtonItem *rightItem =  [self createButton:CGRectMake(0, 0, 40, 20) image:nil title:@"提交" font:YAFont(15) fontColor:YAColor(@"#b7b7b7") tag:102];
    
    self.navigationItem.rightBarButtonItem = rightItem;

    
    [self createView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  
}

-(void)createView{
    CGFloat navH = YANavBarHeight;
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    label.text = @"问题和意见";
    label.font = YAFont(14);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20*YAYIScreenScale));
        make.top.mas_equalTo(@(24*YAYIScreenScale + navH));
    }];
   
    
    
    UITextView *textView = [UITextView new];
    textView.placeholder = @"请填写您的意见";
    textView.delegate = self;
    [textView becomeFirstResponder];
    textView.placeholderColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(label.mas_bottom).offset(15*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 138*YAYIScreenScale));
    }];
    
    UILabel *hLine1= [UILabel new];
    hLine1.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.view addSubview:hLine1];
    [hLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(textView.mas_top).offset(-1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 1*YAYIScreenScale));
    }];
    
    UILabel *hLine2= [UILabel new];
    hLine2.backgroundColor = [UIColor colorWithHexString:@"#b7b7b7"];
    [self.view addSubview:hLine2];
    [hLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(textView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 1*YAYIScreenScale));
    }];
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
    if (button.tag == 102) {
        self.saveBtn = button;
    }
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
-(void)backAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.view endEditing:YES];
        if (self.info.length == 0) {
            [NSString showInfoWithStatus:@"请填写反馈信息"];
            return;
        }
        
        __weak typeof(self) weakSelf = self;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"deviceId"] = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        param[@"systemType"] = @"1";
        param[@"info"] = self.info;
        [YAHttpBase POST:addFeedback_url parameters:param success:^(id responseObject, int code) {
            NSString *message = responseObject[@"message"];
            [self showHud:message];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            
        }];
    }

}

-(void)showHud:(NSString *)content{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = content;
    hud.label.font = YAFont(14);
    hud.label.numberOfLines =0;
    hud.bezelView.color= YAColor(@"#000000");
    hud.label.textColor = YAColor(@"#ffffff");
    [hud hideAnimated:YES afterDelay:2];
    [hud removeFromSuperViewOnHide];
}

@end
