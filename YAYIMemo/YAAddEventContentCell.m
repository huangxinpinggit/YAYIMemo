//
//  YAAddEventContentCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventContentCell.h"

@implementation YAAddEventContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}

-(void)createViews{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    textView.placeholder = @"点击编辑事项...";
    textView.placeholderLabel.font =  [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    textView.placeholderColor = [UIColor colorWithHexString:@"#b7b7b7"];
    [self.contentView addSubview:textView];
    self.textView = textView;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"sb_mic"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:button];
    self.button = button;
    self.button.hidden = YES;
    
    UILabel *label = [UILabel new];
    label.font = YAFont(14);
    label.textColor = YAColor(@"b7b7b7");
    self.tipLab = label;
    label.text = @"字数不超过24个";
    [self.contentView addSubview:label];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"sb_mic"];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*YAYIScreenScale));
        make.top.equalTo(@(8*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(300, 40));
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(49*YAYIScreenScale));
        make.right.equalTo(@(-15*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15*YAYIScreenScale));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8*YAYIScreenScale);
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(345*YAYIScreenScale, 1));
    }];
}

#pragma mark  =================

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(eventcontent:)]) {
        [_delegate eventcontent:textView.text];
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.returnKeyType == UIReturnKeyDone) {
        [textView resignFirstResponder];
        return YES;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length >23) {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    return YES;
}

@end
