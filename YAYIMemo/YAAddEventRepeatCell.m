//
//  YAAddEventRepeatCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/7.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventRepeatCell.h"

@implementation YAAddEventRepeatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.button.selected = YES;
        self.nameLab.textColor = [UIColor colorWithHexString:@"#424242"];
    }else{
        self.button.selected = false;
        self.nameLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(repeatEvent: isSelected:)]) {
        [_delegate repeatEvent:self.nameLab.text isSelected:selected];
    }
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView{
    UILabel *nameLab = [UILabel new];
    nameLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    UIImage *image = [UIImage imageNamed:@"c_choose"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateSelected];
    [button setImage:[UIImage new] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    
    self.button = button;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(16*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale, 14*YAYIScreenScale));
    }];
    UIImage *image = [UIImage imageNamed:@"c_choose"];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-6*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(image.size.width +(18*YAYIScreenScale), image.size.height));
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(330*YAYIScreenScale, 1));
    }];
}

-(void)buttonAction:(UIButton *)sender{
    //sender.selected = YES;
    
}
@end
