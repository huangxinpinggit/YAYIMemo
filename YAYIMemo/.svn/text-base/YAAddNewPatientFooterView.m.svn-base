//
//  YAAddNewPatientFooterView.m
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddNewPatientFooterView.h"

@implementation YAAddNewPatientFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;

}
-(void)createView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(12)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.titleLab.text = @"所有标签";
    [self.contentView addSubview:self.titleLab];
    
    self.tagView = [[YAAddNewPatientTagView alloc] initWithFrame:CGRectMake(27*YAYIScreenScale, 43*YAYIScreenScale, SCREEN_W - 54*YAYIScreenScale, 0)];
    
    
    self.tagView.backgroundColor = [UIColor whiteColor];
   
    self.tagView.delegate = self;
    [self.contentView addSubview:self.tagView];
    
    

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*YAYIScreenScale));
        make.left.equalTo(@(27*YAYIScreenScale));
        make.height.equalTo(@(13*YAYIScreenScale));
        
    }];
    [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(27*YAYIScreenScale));
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 54*YAYIScreenScale, self.tagView.height));
    }];
}

-(void)selectedTagName:(YAPatientInfoPatientTagModel  *)model
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectTagName:)]) {
        [_delegate selectTagName:model];
    }
}

@end
