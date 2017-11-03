//
//  YAAddPatienttagCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddPatienttagCell.h"

@implementation YAAddPatienttagCell

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

-(void)setModel:(YAAddTagListModel *)model
{
    _model = model;
    self.nameLab.text = [NSString stringWithFormat:@"%@ (%ld)",model.tagName,model.count];
    self.contentLab.text = [self nameString:model.patients];
}

-(void)createView{
    UILabel *label = [UILabel new];
    label.textColor = YAColor(@"#424242");
    label.font = YAFont(15);
    [self.contentView addSubview:label];
    self.nameLab = label;
    
    UILabel *contentLab = [UILabel new];
    contentLab.textColor = YAColor(@"#8a8a8a");
    contentLab.font = YAFont(15);
    [self.contentView addSubview:contentLab];
    self.contentLab = contentLab;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#e7e7e7");
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.equalTo(@(10*YAYIScreenScale));
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(7*YAYIScreenScale);
        make.width.equalTo(@(SCREEN_W -30*YAYIScreenScale));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W-15*YAYIScreenScale, 1));
    }];
    
    
}

#pragma mark    =======================

-(NSString *)nameString:(NSArray *)ary{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i< ary.count; i++) {
        YATagPatientModel *model = ary[i];
        [str appendString:model.patientName];
        if (i != ary.count -1) {
            [str appendString:@","];
        }
        
    }
    
    return str;

}

@end
