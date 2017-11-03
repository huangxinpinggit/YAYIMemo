//
//  YAAgreementCell.m
//  YAYIMemo
//
//  Created by hxp on 2017/10/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAgreementCell.h"

@implementation YAAgreementCell

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
-(void)createView{
    self.contentbLab = [UILabel new];
    self.contentbLab.font = YAFont(14);
    self.contentbLab.textColor = YAColor(@"#424242");
    self.contentbLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentbLab];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.equalTo(@(SCREEN_W - 20));
    }];
}
@end
