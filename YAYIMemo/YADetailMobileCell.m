//
//  YADetailMobileCell.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YADetailMobileCell.h"

@implementation YADetailMobileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)setModel:(YAPatientDetailModel *)model
{
    _model = model;
}
-(void)setType:(DETAILCELLTYPE)type
{
    _type = type;
    if (_type == 0) {
        self.conntentLab.text = [self mobileStr:_model.patient.mobile];
        self.titleLab.text = @"手机号";
        self.leftView.hidden = YES;
        [self.mobileBtn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.mobileBtn addTarget:self action:@selector(callMobileAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [self.messageBtn addTarget:self action:@selector(sendMessageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.hLine.hidden = false;
    }else{
        if (_model.patient.wx.length == 0) {
            self.mobileBtn.hidden = YES;
            self.conntentLab.text = @"添加微信号";
            self.conntentLab.textColor = YAColor(@"#8a8a8a");
        }else{
             self.mobileBtn.hidden = false;
             self.conntentLab.text = _model.patient.wx;
             self.conntentLab.textColor = YAColor(@"#424242");
        }
        
        self.titleLab.text = @"微信号";
        [self.mobileBtn setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        [self.mobileBtn addTarget:self action:@selector(openWeiXinAction:) forControlEvents:UIControlEventTouchUpInside];
        self.messageBtn.hidden = YES;
        self.hLine.hidden = YES;
        self.leftView.hidden = false;
       
    }
}

-(void)createView{
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = YAColor(@"#8a8a8a");
    titleLab.font = YAFont(15);
    [self.contentView addSubview:titleLab];
    self.titleLab = titleLab;
    
    UILabel *contentLab = [UILabel new];
    contentLab.font = YAFont(15);
    contentLab.textColor = YAColor(@"#424242");
    [self.contentView addSubview:contentLab];
    self.conntentLab = contentLab;
    
    UIButton *mobileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:mobileBtn];
    self.mobileBtn = mobileBtn;
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:messageBtn];
    self.messageBtn = messageBtn;
    
    UIImageView *leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"enter"];
    [self.contentView addSubview:leftView];
    self.leftView = leftView;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#e7e7e7");
    [self.contentView addSubview:hLine];
    self.hLine = hLine;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(@(15*YAYIScreenScale));
    }];
    
    [self.conntentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(@(122*YAYIScreenScale));
    }];
    
    [self.mobileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-82*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.mobileBtn.mas_right).offset(15*YAYIScreenScale);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.equalTo(@(-15*YAYIScreenScale));
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W-15*YAYIScreenScale, 1*YAYIScreenScale));
    }];

}
-(NSString *)mobileStr:(NSString *)mobile{
    NSString *lead = [mobile substringToIndex:3];
    NSString *mid = [mobile substringWithRange:NSMakeRange(4, 4)];
    NSString *tail = [mobile substringFromIndex:7];
    
    NSString *newStr = [NSString stringWithFormat:@"%@-%@-%@",lead,mid,tail];
    return newStr;
}
-(void)callMobileAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(callMobileAction:)]) {
        [_delegate callMobileAction:[self mobileStr:_model.patient.mobile]];
    }
}
-(void)sendMessageAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessageAction:)]) {
        [_delegate sendMessageAction:[self mobileStr:_model.patient.mobile]];
    }

}
-(void)openWeiXinAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(openWeixinAction:)]) {
        [_delegate openWeixinAction:_model.patient.wx];
    }

}
@end
