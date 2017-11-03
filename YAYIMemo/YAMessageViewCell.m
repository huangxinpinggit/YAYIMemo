//
//  YAmessageViewCell.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMessageViewCell.h"

@implementation YAMessageViewCell
{
    NSString *_content;
}
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
        
        _content = @"鲜花笑脸轻轻扬，小鸟欢歌喜婉转，天空悠闲好蔚蓝，小溪幸福慢慢淌，晨风轻叩美窗棂，催你早起迎朝阳!祝你早安，心情灿烂!";
        [self createView];
        
    }
    return self;

}

-(void)createView{
    UIImageView *icon = [UIImageView new];
    icon.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:icon];
    self.avater = icon;
    
    UILabel *nameLab = [UILabel new];
    nameLab.font = YAFont(14);
    nameLab.text = @"系统通知";
    nameLab.textColor = YAColor(@"#424242");
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *timeLab = [UILabel new];
    timeLab.textColor = YAColor(@"8a8a8a");
    timeLab.font = YAFont(12);
    timeLab.text = @"2017-09-10  10:50";
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    UIView *bgView = [UIView new];
    bgView.layer.cornerRadius = 3*YAYIScreenScale;
    bgView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.contentView addSubview:bgView];
    self.bgView = bgView;
    
    UILabel *contentLab = [UILabel new];
    contentLab.font = YAFont(12);
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = UILineBreakModeWordWrap;
    contentLab.text = _content;
    contentLab.textColor = YAColor(@"#8a8a8a");
    [self.bgView addSubview:contentLab];
    self.contenLab = contentLab;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = [self heightForString:_content fontSize:12 andWidth:278*YAYIScreenScale];
    [self.avater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(18*YAYIScreenScale));
        make.left.equalTo(@(16*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(31*YAYIScreenScale, 31*YAYIScreenScale));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avater.mas_right).offset(15*YAYIScreenScale);
        make.top.equalTo(@(20*YAYIScreenScale));
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(6*YAYIScreenScale);
        make.left.mas_equalTo(self.nameLab.mas_left);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(15*YAYIScreenScale);
        make.width.equalTo(@(298*YAYIScreenScale));
        make.height.equalTo(@(height + 20*YAYIScreenScale));
    }];
    
    [self.contenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10*YAYIScreenScale));
        make.left.equalTo(@(10*YAYIScreenScale));
        make.right.mas_equalTo(@(-10*YAYIScreenScale));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(313*YAYIScreenScale, 1*YAYIScreenScale));
    }];
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:YAFont(fontSize)
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeToFit.height;
}
@end
