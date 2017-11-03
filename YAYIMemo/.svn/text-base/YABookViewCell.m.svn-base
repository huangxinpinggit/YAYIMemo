//
//  YABookViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YABookViewCell.h"

@implementation YABookViewCell

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
        [self createViews];
    }
    return self;
}
-(void)setModel:(YABookModel *)model
{
    _model = model;
    [self loadData];
}

-(void)loadData{
    self.titleLab.text = _model.name;
    self.mobileLab.text = _model.phoneNumber;
    if (_model.avatar != nil) {
       [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[UIImage imageNamed:@"book_avatar"]];
    }else{
        self.icon.image = [UIImage imageNamed:@"book_avatar"];
    }
    
    if (_model.isExit) {
        [self.addBtn setTitle:@"已添加" forState:UIControlStateNormal];
        [self.addBtn setBackgroundColor:[UIColor whiteColor]];
        [self.addBtn setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    }else{
        [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [self.addBtn setBackgroundColor:[UIColor colorWithHexString:@"#424242"]];
        [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)createViews{
    self.icon = [UIImageView new];

    [self.icon zy_cornerRadiusAdvance:13.5*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    
    [self.contentView addSubview:self.icon];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:14];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#424242"];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    self.titleLab.numberOfLines = 0;
    [self.contentView addSubview:self.titleLab];
    
    UILabel *mobileLab = [UILabel new];
    mobileLab.font = [UIFont systemFontOfSize:14];
    mobileLab.textColor = [UIColor colorWithHexString:@"#424242"];
    mobileLab.numberOfLines = 0;
    mobileLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    [self.contentView addSubview:mobileLab];
    self.mobileLab = mobileLab;
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.cornerRadius = 3*YAYIScreenScale;
    self.addBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(12)];
    [self.contentView addSubview:self.addBtn];
    
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
        make.width.equalTo(@(30*YAYIScreenScale));
        make.height.equalTo(@(30*YAYIScreenScale));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(20*YAYIScreenScale);
        make.centerY.mas_equalTo(self.icon.mas_centerY);
        make.width.equalTo(@(60*YAYIScreenScale));
        make.height.equalTo(@(35.0*YAYIScreenScale));
    }];
    
    [self.mobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(20*YAYIScreenScale);
        make.centerY.mas_equalTo(self.icon.mas_centerY);
        make.width.equalTo(@(110*YAYIScreenScale));

    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-3*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(43, 24));
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
        make.right.equalTo(@0);
    }];
    
    
    
}
-(void)addAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(addPatient:)]) {
        [_delegate addPatient:_model];
    }
}

@end
