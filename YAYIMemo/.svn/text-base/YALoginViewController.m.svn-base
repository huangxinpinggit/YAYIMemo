//
//  YALoginViewController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YALoginViewController.h"
#import "NSString+YA.h"

#import "YAResetPasswordController.h"
#import "YSLDraggableCardContainer.h"
#import "YALoginCardView.h"
#import "YARegisterCardView.h"
#import "YAAgreementViewController.h"
@interface YALoginViewController ()<UITextFieldDelegate,YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource,YALoginCardViewDelegate,YARegisterCardViewDelegate>
/*
@property (nonatomic, weak)UIView *LoginView;
@property (nonatomic, weak)UIView *registerView;
@property (nonatomic, weak)UIImageView *avater;
@property (nonatomic, weak)UITextField *mobileText;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UIImageView *backgroundView;
@property (nonatomic, weak)UIImageView *registerBackView;
 */
@property (nonatomic, strong) YSLDraggableCardContainer *container;
@property (nonatomic, weak) YARegisterCardView *registerCardView;
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UIButton *backBtn;
@property (nonatomic, weak)UIButton *registerBtn;
@end

@implementation YALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YAColor(@"#f1f1f1");
    
    [self createContainar];
    [self createBottomView];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"login"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"login"];
}

-(void)createContainar{
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft;
    [self.view addSubview:_container];
   [_container reloadCardContainer];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"b_bg"];
    [self.view addSubview:bgImageView];
    [self.view insertSubview:bgImageView belowSubview:_container];

}

-(void)createBottomView{
    UIImage *image = [UIImage imageNamed:@"shape"];
    CGFloat height =  image.size.height *YAYIScreenScale;
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    registerBtn.titleLabel.font = YAFont(16);
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:registerBtn];
    self.registerBtn = registerBtn;
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(214*YAYIScreenScale+height+14*YAYIScreenScale));
        make.centerX.mas_equalTo(self.container.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60*YAYIScreenScale, 30*YAYIScreenScale));
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:backBtn];
    backBtn.hidden = YES;
    self.backBtn = backBtn;
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(29*YAYIScreenScale));
        if (SCREEN_H >568.0) {
             make.top.mas_equalTo(214*YAYIScreenScale+height+31*YAYIScreenScale);
        }else{
             make.top.mas_equalTo(214*YAYIScreenScale+image.size.height*YAYIScreenScale+11*YAYIScreenScale);
        }
       
    }];
    CGFloat tabH = YATabBarHeight;
    
    UILabel *titleLab = [UILabel new];
    titleLab.attributedText = [self titleString:@"登录"];
    titleLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementAction:)];
    [titleLab addGestureRecognizer:tap];
    titleLab.font = YAFont(12);
    self.titleLab = titleLab;
    [self.container addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isIPhoneX) {
             make.bottom.mas_equalTo(@(-tabH));
        }else{
            make.bottom.mas_equalTo(@(-24*YAYIScreenScale));
        }
        make.centerX.mas_equalTo(self.container.mas_centerX);
    }];
}
#pragma mark -- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    UIImage *image = [UIImage imageNamed:@"shape"];
    CGFloat height =  image.size.height *YAYIScreenScale;
    if (index == 0) {
        YALoginCardView *view = [[YALoginCardView alloc]initWithFrame:CGRectMake(10*YAYIScreenScale, 214*YAYIScreenScale,SCREEN_W - 20*YAYIScreenScale, height)];
        view.backgroundColor = [UIColor clearColor];
        view.delegate = self;
        return view;
    }else{
        YARegisterCardView *view = [[YARegisterCardView alloc]initWithFrame:CGRectMake(10*YAYIScreenScale, 214*YAYIScreenScale,SCREEN_W - 20*YAYIScreenScale, height)];
        self.registerCardView = view;
        view.backgroundColor = [UIColor clearColor];
    
        view.delegate = self;
        return view;
    }
    
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return 2;
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
        if ([draggableView isKindOfClass:[YALoginCardView class]]) {
            self.registerCardView.registerBtn.hidden = false;
            self.registerCardView.registerBackView.image = [UIImage imageNamed:@"sw_bg"];
            self.registerBtn.hidden = YES;
            self.backBtn.hidden = false;
            
        }

    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    //YACardView *view = (YACardView *)draggableView;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
                //view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        
       // view.selectedView.backgroundColor = RGB(215, 104, 91);
        //view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        //view.selectedView.backgroundColor = RGB(114, 209, 142);
        //view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        //view.selectedView.backgroundColor = RGB(66, 172, 225);
        //view.selectedView.alpha = heightRatio > 0.8 ? 0.8 : heightRatio;
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
        [self createBottomView];

    });
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    NSLog(@"++ index : %ld",(long)index);
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


-(void)registerAction:(UIButton *)sender{
    self.registerCardView.registerBtn.hidden = false;
    self.registerCardView.registerBackView.image = [UIImage imageNamed:@"sw_bg"];
    [self.container movePositionWithDirection:YSLDraggableDirectionLeft
                                     isAutomatic:NO];
    sender.hidden = YES;
    self.backBtn.hidden = false;
    self.titleLab.attributedText = [self titleString:@"注册"];;
    

}

-(void)backAction:(UIButton *)sender{
    [self.container movePositionWithDirection:YSLDraggableDirectionLeft
                                  isAutomatic:NO];
    sender.hidden = YES;
}

-(void)loginPost:(NSString *)name password:(NSString *)password
{
    if (name.length ==0) {
        [NSString showInfoWithStatus:@"请填写手机号"];
        return;
    }else if ([NSString valiMobile:name]){
        [NSString showInfoWithStatus:@"手机号码不合法"];
        return;
    }else if (password.length == 0){
        [NSString showInfoWithStatus:@"请填写密码"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = name;
    param[@"password"]  = password;
    [NSString showHud];
    [YAHttpBase POST:Login_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        YA_LOG(message);
        [NSString hidHud];
        if (_loginSuccessOperation) {
            weakSelf.loginSuccessOperation();
        }
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (int i = 0;  i < cookieJar.cookies.count; i ++) {
            
            NSHTTPCookie *cookie = [cookieJar cookies][i];
            if (i == cookieJar.cookies.count - 1) {
                
                [userdef setValue:cookie.value forKey:YALoginCookieKey];
                
                NSData *cookiesData = [NSKeyedArchiver   archivedDataWithRootObject:@[cookie]];
                [userdef setObject:cookiesData forKey:@"doctorcookiesKey"];
                
                [userdef synchronize];
            }
        }
    } failure:^(NSError *error) {
        [NSString hidHud];
        //NSLog(@"%@",error);
    }];
}

-(void)resetPassword{
    YAResetPasswordController *resetPasswordView = [YAResetPasswordController new];
    YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:resetPasswordView];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
-(void)registerPost:(NSString *)name password:(NSString *)password verify:(NSString *)verify codeStr:(NSString *)code
{
    if (name.length ==0) {
        [NSString showInfoWithStatus:@"请填写手机号"];
        return;
    }else if ([NSString valiMobile:name]){
        [NSString showInfoWithStatus:@"手机号码不合法"];
        return;
    }else if (verify.length == 0){
        [NSString showInfoWithStatus:@"请填写验证码"];
        return;
    }else if (![verify isEqualToString:code]){
        [NSString showInfoWithStatus:@"验证码有误"];
        return;
    }else if (password.length == 0){
        [NSString showInfoWithStatus:@"请填写密码"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = name;
    param[@"password"]  = password;
    YA_LOG(@"%@",param);
    [NSString showHud];
    [YAHttpBase POST:registerUser_url parameters:param success:^(id responseObject, int code) {
        [NSString hidHud];
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        if (weakSelf.loginSuccessOperation) {
            weakSelf.loginSuccessOperation();
        }
        
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (int i = 0;  i < cookieJar.cookies.count; i ++) {
            
            NSHTTPCookie *cookie = [cookieJar cookies][i];
            if (i == cookieJar.cookies.count - 1) {
                
                [userdef setValue:cookie.value forKey:YALoginCookieKey];
                
                NSData *cookiesData = [NSKeyedArchiver   archivedDataWithRootObject:@[cookie]];
                [userdef setObject:cookiesData forKey:@"doctorcookiesKey"];
                
                [userdef synchronize];
            }
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [NSString hidHud];
        NSLog(@"%@",error);
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
       [self.container endEditing:YES];
}


-(void)agreementAction:(UIButton *)sender{
    YAAgreementViewController *view = [YAAgreementViewController new];
    YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:YES completion:nil];
}




























/*
// 登录
-(void)createBackView{
    UIImageView *backView = [UIImageView new];
    backView.image = [UIImage imageNamed:@"shape"];
    [self.view addSubview:backView];
    self.backgroundView = backView;
    self.backgroundView.userInteractionEnabled = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-135*YAYIScreenScale);
    }];
    
    UIImageView *avater = [UIImageView new];
    avater.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:avater];
    self.avater = avater;
    [avater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@(240.5));
    }];
    
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
        make.top.mas_equalTo(self.avater.mas_bottom).offset(49*YAYIScreenScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 18*YAYIScreenScale));
    }];
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#f3f4f6");
    [self.view addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mobileText.mas_bottom).offset(10*YAYIScreenScale);
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
    self.passwordText = passwordText;
    [self.backgroundView addSubview:passwordText];
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine.mas_bottom).offset(30*YAYIScreenScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.and.height.mas_equalTo(mobileText);
    }];
    
    UILabel *hLine2 = [UILabel new];
    hLine2.backgroundColor = YAColor(@"#f3f4f6");
    [self.view addSubview:hLine2];
    [hLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordText.mas_bottom).offset(10*YAYIScreenScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
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
        make.size.mas_equalTo(CGSizeMake(60, 20));
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
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(109*YAYIScreenScale, 35*YAYIScreenScale));
    }];

    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    registerBtn.titleLabel.font = YAFont(16);
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(21*YAYIScreenScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.attributedText = [self titleString:@"登录"];
    titleLab.font = YAFont(12);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@(-24*YAYIScreenScale));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}

// 注册
-(void)createegisterView{
   
    UIImageView *backView = [UIImageView new];
    backView.image = [UIImage imageNamed:@"shape"];
    [self.view addSubview:backView];
    self.registerBackView = backView;
    self.registerBackView.userInteractionEnabled = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-135*YAYIScreenScale);
    }];
    
    UIImageView *avater = [UIImageView new];
    avater.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:avater];
    self.avater = avater;
    [avater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@(240.5));
    }];
    
    UITextField *mobileText = [UITextField new];
    mobileText.textAlignment = NSTextAlignmentCenter;
    mobileText.returnKeyType = UIReturnKeyNext;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    mobileText.attributedPlaceholder = attributedString;
    mobileText.font = YAFont(14);
    mobileText.textColor = YAColor(@"#424242");
    [backView addSubview:mobileText];
    [mobileText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avater.mas_bottom).offset(25*YAYIScreenScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 15*YAYIScreenScale));
    }];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#f3f4f6");
    [backView addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mobileText.mas_bottom).offset(10*YAYIScreenScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(255*YAYIScreenScale, 2*YAYIScreenScale));
    }];
    
    // 验证码
    UITextField *verifyText = [UITextField new];
    verifyText.textAlignment = NSTextAlignmentCenter;
    verifyText.returnKeyType = UIReturnKeyNext;
    NSAttributedString *verifyattributedString = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    verifyText.attributedPlaceholder = verifyattributedString;
    verifyText.font = YAFont(14);
    verifyText.textColor = YAColor(@"#424242");
    [backView addSubview:verifyText];
    [verifyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(mobileText);
        make.top.mas_equalTo(hLine.mas_bottom).offset(30*YAYIScreenScale);
    }];
    
    UILabel *hLine2 = [UILabel new];
    hLine2.backgroundColor = YAColor(@"#f3f4f6");
    [backView addSubview:hLine2];
    [hLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(hLine);
        make.top.mas_equalTo(verifyText.mas_bottom).offset(10*YAYIScreenScale);
    }];
    
    UITextField *passwordText = [UITextField new];
    NSAttributedString *passwordattributedString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:YAColor(@"#99959a"),NSFontAttributeName:YAFont(14)}];
    passwordText.attributedPlaceholder = passwordattributedString;
    [backView addSubview:passwordText];
    passwordText.textAlignment = NSTextAlignmentCenter;
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(verifyText);
        make.top.mas_equalTo(hLine2.mas_bottom).offset(30*YAYIScreenScale);
    }];
    
    UILabel *hLine3 = [UILabel new];
    hLine3.backgroundColor = YAColor(@"#f3f4f6");
    [backView addSubview:hLine3];
    [hLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(hLine);
        make.top.mas_equalTo(passwordText.mas_bottom).offset(10*YAYIScreenScale);
    }];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 17*YAYIScreenScale;
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.backgroundColor = YAColor(@"#424242");
    [backView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine3.mas_bottom).offset(22*YAYIScreenScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(109*YAYIScreenScale, 35*YAYIScreenScale));
    }];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(29*YAYIScreenScale));
        make.top.mas_equalTo(backView.mas_bottom).offset(38*YAYIScreenScale);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.attributedText = [self titleString:@"注册"];
    titleLab.font = YAFont(12);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@(-24*YAYIScreenScale));
        make.centerX.mas_equalTo(self.view.mas_centerX);
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
    //@"18600202635"
    //@"123456"
    
    if (self.mobileText.text.length ==0) {
        [SVProgressHUD showInfoWithStatus:@"请填写手机号"];
        return;
    }else if ([NSString valiMobile:self.mobileText.text]){
        [SVProgressHUD showInfoWithStatus:@"手机号码不合法"];
        return;
    }else if (self.passwordText.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写密码"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = self.mobileText.text;
    param[@"password"]  = self.passwordText.text;
    [YAHttpBase POST:Login_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (int i = 0;  i < cookieJar.cookies.count; i ++) {
            
            NSHTTPCookie *cookie = [cookieJar cookies][i];
            if (i == cookieJar.cookies.count - 1) {
                
                [userdef setValue:cookie.value forKey:YALoginCookieKey];
                
                NSData *cookiesData = [NSKeyedArchiver   archivedDataWithRootObject:@[cookie]];
                [userdef setObject:cookiesData forKey:@"doctorcookiesKey"];
                
                [userdef synchronize];
            }
        }
    } failure:^(NSError *error) {
        //NSLog(@"%@",error);
    }];
}

-(void)registerAction:(UIButton *)sender{
    YARegisterViewController *registerView  = [YARegisterViewController new];
    [self presentViewController:registerView animated:YES completion:nil];
}

-(void)resetPassword:(UIButton *)sender{
    YAResetPasswordController *resetPasswordView = [YAResetPasswordController new];
    YAYINavigationController *nav = [[YAYINavigationController alloc] initWithRootViewController:resetPasswordView];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}

 */
@end
