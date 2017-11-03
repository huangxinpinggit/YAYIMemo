//
//  YAHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAHeaderView.h"

@implementation YAHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageAry = @[@"Jan",@"Feb",@"mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
        self.font = [UIFont systemFontOfSize:YAYIFontWithScale(18)];
        self.textColor = [UIColor colorWithHexString:@"#424242"];
        [self createView];
    }
    return self;
}
-(void)updateDateWithYear:(NSInteger)year month:(NSInteger)month
{
   self.mothView.image = [UIImage imageNamed:_imageAry[month-1]];
   self.yearLab.text = [NSString stringWithFormat:@"/%ld",year];
}


-(void)createView{
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:self.imageAry[1]];
    [self addSubview:imageView];
    self.mothView = imageView;
    
    UILabel *label = [UILabel new];
    label.textColor = self.textColor;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = self.font;
    label.text = @"/2017";
    [self addSubview:label];
    self.yearLab = label;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.tag = 1001;
    [nextBtn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    nextBtn.imageView.contentMode = UIViewContentModeCenter;
    [nextBtn addTarget:self action:@selector(updateMonth:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:nextBtn];
    self.nextBtn = nextBtn;
    
    UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    lastBtn.imageView.contentMode = UIViewContentModeCenter;
    lastBtn.tag = 1002;
    
    [lastBtn addTarget:self action:@selector(updateMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lastBtn];
    self.lastBtn = lastBtn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"left"];
    [self.mothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(29*YAYIScreenScale));
        make.top.equalTo(@0);
        //make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
    [self.yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mothView);
        make.left.equalTo(@(48*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(80, 18*YAYIScreenScale));
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15*YAYIScreenScale);
        make.centerY.mas_equalTo(self.mothView);
        make.size.mas_equalTo(CGSizeMake(image.size.width+32*YAYIScreenScale,image.size.height+10));
    }];
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.nextBtn.mas_left).offset(-12*YAYIScreenScale);
        make.centerY.mas_equalTo(self.mothView);;
        make.size.mas_equalTo(CGSizeMake(image.size.width+32*YAYIScreenScale,image.size.height+10));
    }];
}

#pragma mark =============
-(void)updateMonth:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(updateMonth:)]) {
        [_delegate updateMonth:sender.tag];
    }

}
@end
