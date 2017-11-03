//
//  YAPatientViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddNewPatientViewCell.h"

@implementation YAAddNewPatientViewCell

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
    if (self.contentText.tag == 1000) {
        self.contentText.text = _model.patient.name;
    }else if (self.contentText.tag == 1001){
        self.contentText.text = _model.patient.age>0?[NSString stringWithFormat:@"%ld",_model.patient.age]:@"";
    }else if (self.contentText.tag == 1002){
       
        self.contentText.textColor = [UIColor colorWithHexString:@"#678aff"];
        self.contentText.text =  _model.patient.mobile==nil?@"":[self mobileStr:_model.patient.mobile];
    }else if (self.contentText.tag == 1003){
        self.contentText.text = _model.patient.wx;
    }

}

-(void)createView{
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    [self.contentView addSubview:self.titleLab];
    
    self.contentText = [UITextField new];
    self.contentText.textColor = [UIColor colorWithHexString:@"#424242"];
    self.contentText.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.contentText.returnKeyType = UIReturnKeyNext;
    self.contentText.delegate = self;
    [self.contentView addSubview:self.contentText];
    
    self.hLine = [UILabel new];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:self.hLine];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(22*YAYIScreenScale));
        make.left.equalTo(@(27*YAYIScreenScale));
        make.height.equalTo(@(13*YAYIScreenScale));

    }];
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.left.mas_equalTo(@(114*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(200*YAYIScreenScale, 20*YAYIScreenScale));
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.titleLab.mas_left);
        make.right.equalTo(@(-27*YAYIScreenScale));
        make.height.equalTo(@(1*YAYIScreenScale));
    }];
}
#pragma mark  ===========================

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(beginEdit:)]) {
        [_delegate beginEdit:textField.tag];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(content:tag:)]) {
        [_delegate content:textField.text tag:textField.tag-1000];
    }
    if (textField.returnKeyType == UIReturnKeyNext) {
        if (_delegate && [_delegate respondsToSelector:@selector(nextAction:)]) {
            [_delegate nextAction:textField.tag];
        }
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(content:tag:)]) {
        [_delegate content:textField.text tag:textField.tag-1000];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag == 1002 && textField.text.length ==9 && !_isDelete) {
        textField.text = [self mobileStr:textField.text];
        textField.textColor = [UIColor colorWithHexString:@"#678aff"];
    }else if(textField.text.length <10 && textField.tag == 1002){
        textField.textColor = [UIColor colorWithHexString:@"#424242"];
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        _isDelete = false;
    }
    return YES;
}
-(void)textFieldDidDeleteBackward:(UITextField *)textField
{
    if(textField.tag == 1002){
        _isDelete = YES;
    }
}
//手机号格式处理
-(NSString *)mobileStr:(NSString *)str{
    NSString *str1 = [str substringToIndex:3];
    NSString *str2 = [str substringWithRange:NSMakeRange(3, 4)];
    NSString *str3 = [str substringWithRange:NSMakeRange(7, str.length - 7)];
    NSString *mobile = [NSString stringWithFormat:@"%@-%@-%@",str1,str2,str3];
    return mobile;
}
@end
