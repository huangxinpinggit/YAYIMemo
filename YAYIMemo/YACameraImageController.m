//
//  YACameraImageController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/11.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACameraImageController.h"

@interface YACameraImageController ()
{
    UIImage *_image;
    CGRect   _frame;
}
@property(nonatomic, strong) UIView *topView;      // 上面的bar
@property(nonatomic, strong) UIView *bottomView;   // 下面的bar
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *info;
@end

@implementation YACameraImageController
- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _image = image;
        _frame = frame;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:_image];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@0);
        make.top.mas_equalTo(@64);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, SCREEN_H - 64 -103*YAYIScreenScale));
    }];
    [self.view addSubview:self.bottomView];
    
    
   
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"w_back"];
    [backBtn setImage:image forState:UIControlStateNormal];
    [_topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.centerY.mas_equalTo(self.topView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15+image.size.width+15, image.size.height+30));
    }];
    
    
    
    // 打开相册
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setTitle:@"重拍" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(opencamera:) forControlEvents:UIControlEventTouchUpInside];
    [photoBtn sizeToFit];
    [_bottomView addSubview:photoBtn];
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(19*YAYIScreenScale));
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    }];
    
    
    // 转换前后摄像头
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton  setTitle:@"使用照片" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton sizeToFit];
    [_bottomView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-19*YAYIScreenScale));
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    }];
}

-(UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
        _topView.backgroundColor = YAColor(@"#222222");
    }
    return _topView;
    
}

-(UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H - 103*YAYIScreenScale, SCREEN_W, 103*YAYIScreenScale)];
        _bottomView.backgroundColor = YAColor(@"#222222");
    }
    return _bottomView;
}

#pragma mark ================================

-(void)opencamera:(UIButton *)sender{
    if (_camareOperation) {
        _camareOperation();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveAction:(UIButton *)sender{
    if (_refreshedOperation) {
        _refreshedOperation();
    }
    [self commitNet];
}

-(void)backAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)commitNet{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"0";
    param[@"userid"]= self.userid;
    
    UIImage *clipImage = [UIImage clipWithImageRect:CGRectMake(0, 0, SCREEN_W, SCREEN_H -64-103*YAYIScreenScale) clipImage:_image];
    NSString *imageStr = [self return32LetterAndNumber];
    NSData *data =   UIImageJPEGRepresentation(clipImage, 0.5);
    [[AliyunOSSObject sharedInstance] uploadObjectAsyc:nil imageData:data file:imageStr success:^(NSString *url) {
        
        param[@"info"] = url;
        
        [YAHttpBase POST:case_insert_url parameters:param success:^(id responseObject, int code) {
            NSString *message = responseObject[@"message"];
            [SVProgressHUD showSuccessWithStatus:message];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            if (weakSelf.refreshedOperation) {
                weakSelf.refreshedOperation();
            }
        } failure:^(NSError *error) {
            
        }];
        
    } fail:^(BOOL fal) {
        
    }];
    
    
    
}


-(NSString *)return32LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
    for (int i = 0; i < 32; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}

@end
