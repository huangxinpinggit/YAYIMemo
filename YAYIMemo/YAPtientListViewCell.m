//
//  YAPtientListViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPtientListViewCell.h"

@implementation YAPtientListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setIsCanselected:(BOOL)isCanselected
{
    _isCanselected = isCanselected;
    self.selectBtn.selected = isCanselected;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}
-(void)setModel:(YAPersonModel *)model
{
    _model = model;
    [self loadData];
}

-(void)loadData{
    self.titleLab.text = _model.name;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
    self.selectBtn.selected = _model.isSelected;
}

-(void)createViews{
    self.icon = [UIImageView new];
    [self.icon zy_cornerRadiusAdvance:13.5*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    [self.contentView addSubview:self.icon];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:14];
    self.titleLab.numberOfLines = 0;
    self.titleLab.textColor = [UIColor colorWithHexString:@"#424242"];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:self.titleLab];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.selectBtn setImage:[UIImage imageNamed:@"c_choose"] forState:UIControlStateSelected];
    [self.selectBtn setImage:[UIImage imageNamed:@"n_choose"] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    
    self.hLine = [UILabel new];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:self.hLine];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(58*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(27*YAYIScreenScale));
        make.height.equalTo(@(27*YAYIScreenScale));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(20*YAYIScreenScale);
        make.centerY.mas_equalTo(self.icon.mas_centerY);
        make.height.equalTo(@40);
        make.width.equalTo(@(80*YAYIScreenScale));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
        make.right.equalTo(@0);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.equalTo(@(-8*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(44*YAYIScreenScale, 44*YAYIScreenScale));
    }];
    
    
}

-(void)selectedAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(selectedRow:)]) {
        [_delegate selectedRow:_model];
    }
}
@end
