//
//  YADetailMattersViewCell.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YADetailMattersViewCell.h"

@implementation YADetailMattersViewCell

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
    if (_model.recentItem == 1) {
        self.dotLab.hidden = false;
    }else{
        self.dotLab.hidden = YES;
    }
}
-(void)createView{
    UIView *topView = [UIView new];
    topView.backgroundColor = YAColor(@"#f3f4f6");
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = YAFont(15);
    titleLab.text = @"最近事项";
    titleLab.textColor = YAColor(@"#8a8a8a");
    [self.contentView addSubview:titleLab];
    self.titleLab = titleLab;
    
    
    UIImageView *leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"enter"];
    [self.contentView addSubview:leftView];
    self.leftView = leftView;

    
    UILabel *dotLab = [UILabel new];
    dotLab.layer.masksToBounds = YES;
    dotLab.backgroundColor = YAColor(@"#ff414c");
    dotLab.layer.cornerRadius = 4*YAYIScreenScale;
    [self.contentView addSubview:dotLab];
    self.dotLab = dotLab;
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = YAColor(@"#f3f4f6");
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 5*YAYIScreenScale));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(@(15*YAYIScreenScale));
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.equalTo(@(-15*YAYIScreenScale));
    }];

    
    [self.dotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.leftView.mas_left).offset(-10*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(8*YAYIScreenScale, 8*YAYIScreenScale));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 5*YAYIScreenScale));
    }];
}
 
@end
