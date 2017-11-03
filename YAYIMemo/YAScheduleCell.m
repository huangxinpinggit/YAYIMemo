//
//  YAScheduleCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAScheduleCell.h"

@implementation YAScheduleCell

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

-(void)setModel:(YAWorkEventModel *)model
{
    _model = model;
    [self loadData];
}

-(void)loadData{
    self.timeLab.text = _model.worktime;
    self.nameLab.text = _model.patientname;
    self.tagLab.text = _model.items;
    if (_model.repetition == 0) {
        self.setLab.text = @"";
    }else if (_model.repetition == 1){
        self.setLab.text = @"每天";
    }else if (_model.repetition == 2){
         self.setLab.text = @"每周";
    }else{
         self.setLab.text = @"每年";
    }
    self.tagLab.text = _model.items;
    
}

-(void)createView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *timeLab = [UILabel new];
    timeLab.textColor = YABlack_color;
    timeLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    UILabel *setLab = [UILabel new];
    setLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    setLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(12)];
    [self.contentView addSubview:setLab];
    self.setLab = setLab;
    
    UILabel *vLine = [UILabel new];
    vLine.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:vLine];
    self.vLine = vLine;
    
    UILabel *nameLab = [UILabel new];
    nameLab.textColor = YABlack_color;
    nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *tagLab = [UILabel new];
    tagLab.textColor = YABlack_color;
    tagLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:tagLab];
    tagLab.numberOfLines = 0;
    self.tagLab = tagLab;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(30*YAYIScreenScale));
        if (_setLab.text.length) {
            make.top.mas_equalTo(@(12*YAYIScreenScale));
        }else{
            make.centerY.mas_equalTo(self.contentView);
        }
        
        make.size.mas_equalTo(CGSizeMake(50*YAYIScreenScale, 13*YAYIScreenScale));
    }];
    
    [self.setLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLab.mas_left);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(5*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale, 12*YAYIScreenScale));
    }];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLab.mas_right).offset(12*YAYIScreenScale);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(2*YAYIScreenScale, 51*YAYIScreenScale));
    }];
    if ([self getTagSize:_model.patientname].width >50) {
        self.nameLab.adjustsFontSizeToFitWidth = YES;
        self.nameLab.numberOfLines = 0;
    }
    [self.nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vLine.mas_right).offset(30*YAYIScreenScale);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@(44*YAYIScreenScale));
        if (_model.patientname) {
             make.width.equalTo(@(50*YAYIScreenScale));
        }
       
    }];
    
    CGFloat w = [self getTagSize:_model.items].width;
    NSLog(@"%lf",w);
    if (w >188*YAYIScreenScale &&_model.patientname) {
        
        self.tagLab.font = YAFont(12);
    }else{
        self.tagLab.font = YAFont(15);
    }
    [self.tagLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        if(self.nameLab.text.length){
           make.left.equalTo(self.nameLab.mas_right).offset(37*YAYIScreenScale);
        }else{
           make.left.equalTo(self.nameLab.mas_right);
        }
        if (w >188*YAYIScreenScale && _model.patientname) {
            make.width.equalTo(@(160*YAYIScreenScale));
        }else{
            make.right.mas_equalTo(@(-8));
        }
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.equalTo(@(15*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 15*YAYIScreenScale, 1));
    }];
}

//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName{
    
    NSDictionary *attrs = @{NSFontAttributeName : YAFont(15)};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
