//
//  YACameraView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/11.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACameraView.h"

@interface  YACameraView()

@property(nonatomic, strong) UIView *topView;      // 上面的bar
@property(nonatomic, strong) UIView *bottomView;   // 下面的bar
@property(nonatomic, strong) UIView *focusView;    // 聚焦动画view
@property(nonatomic, strong) UIView *exposureView; // 曝光动画view

@property (nonatomic, weak)UIButton *photoBtton;

@end

@implementation YACameraView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self ;
}

-(UIView *)topView
{
    CGFloat navH = YANavBarHeight;
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, navH)];
        _topView.backgroundColor = YAColor(@"#222222");
    }
    return _topView;

}
-(UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 103*YAYIScreenScale, SCREEN_W, 103*YAYIScreenScale)];
        _bottomView.backgroundColor = YAColor(@"#222222");
    }
    return _bottomView;
}
-(void)setupUI{
    CGFloat statuH = YAStatusBarHeight;
    self.previewView = [[YAVideoPreview alloc]initWithFrame:CGRectMake(0, 64, self.width, self.height-64-103*YAYIScreenScale)];
    [self addSubview:self.previewView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"w_back"];
    [backBtn setImage:image forState:UIControlStateNormal];
    [_topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.mas_equalTo(statuH);
        make.size.mas_equalTo(CGSizeMake(15+image.size.width+15, image.size.height+20));
    }];
    
    
    // 拍照
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"t_photo"] forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [photoButton sizeToFit];
    [self.bottomView addSubview:photoButton];
    _photoBtton = photoButton;
    [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_bottomView.mas_centerX);
        make.centerY.mas_equalTo(_bottomView.mas_centerY);
    }];
    
    
    // 打开相册
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(openLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [photoBtn sizeToFit];
    [self.bottomView addSubview:photoBtn];
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(19*YAYIScreenScale));
        make.centerY.mas_equalTo(_bottomView.mas_centerY);
    }];

    
    
    // 转换前后摄像头
    UIButton *switchCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchCameraButton setImage:[UIImage imageNamed:@"p_camera"] forState:UIControlStateNormal];
    [switchCameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [switchCameraButton addTarget:self action:@selector(switchCameraClick:) forControlEvents:UIControlEventTouchUpInside];
    [switchCameraButton sizeToFit];
    [self.bottomView addSubview:switchCameraButton];
    [switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-19*YAYIScreenScale));
        make.centerY.mas_equalTo(_bottomView.mas_centerY);
    }];
}

// 拍照
-(void)takePicture:(UIButton *)btn{
    
    if ([_delegate respondsToSelector:@selector(takePhotoAction:)]) {
            [_delegate takePhotoAction:self];
    }
}

// 取消
-(void)openLibrary:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(takePhotoLibarray)]) {
        [_delegate takePhotoLibarray];
    }
}

// 转换前后摄像头
-(void)switchCameraClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(swicthCameraAction:succ:fail:)]) {
        [_delegate swicthCameraAction:self succ:nil fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

//返回
-(void)backAction:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(cancelAction:)]) {
        [_delegate cancelAction:self];
    }
}
- (void)showError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        YA_LOG(error);
    });
}

@end
