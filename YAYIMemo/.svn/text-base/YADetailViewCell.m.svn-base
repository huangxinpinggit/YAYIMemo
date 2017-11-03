//
//  YADetailViewCell.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YADetailViewCell.h"

@implementation YADetailViewCell

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
    
    [[SDImageCache sharedImageCache] removeImageForKey:_model.patient.avatar];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.patient.avatar] placeholderImage:[UIImage imageNamed:@"default_person_avatar"]];
    self.namelLab.text =_model.patient.name;
    if (_model.patient.gender == 1) {
        self.genderLab.text = @"男";
        self.dotLab.hidden = false;
    }else if (_model.patient.gender == 0){
        self.genderLab.text = @"";
        self.dotLab.hidden = YES;
    }else{
        self.genderLab.text = @"女";
        self.dotLab.hidden = false;
    }
    if (_model.patient.age != 0) {
        self.ageLab.text = [NSString stringWithFormat:@"%ld",_model.patient.age];
        self.dotLab1.hidden = false;
    }else{
        self.ageLab.text = @"";
        self.dotLab1.hidden = YES;
    }
    
    [self createTagView:_model.patientTag];
}
-(void)createView{
    UIImageView *icon = [UIImageView new];
    [icon zy_attachBorderWidth:2*YAYIScreenScale color:YAColor(@"e7e7e7")];
    [icon zy_cornerRadiusAdvance:45*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    UILabel *nameLab = [UILabel new];
    nameLab.font = YAFont(15);
    nameLab.textColor = YAColor(@"#424242");
    [self.contentView addSubview:nameLab];
    self.namelLab = nameLab;
    
    UILabel *dotLab = [UILabel new];
    dotLab.backgroundColor = YAColor(@"#424242");
    dotLab.layer.masksToBounds = YES;
    dotLab.layer.cornerRadius = 2*YAYIScreenScale;
    [self.contentView addSubview:dotLab];
    self.dotLab = dotLab;
    
    UILabel *genderLab = [UILabel new];
    genderLab.font = YAFont(15);
    genderLab.textColor = YAColor(@"#424242");
    [self.contentView addSubview:genderLab];
    self.genderLab = genderLab;
    
    UILabel *dotLab1 = [UILabel new];
    dotLab1.backgroundColor = YAColor(@"#424242");
    dotLab1.layer.masksToBounds = YES;
    dotLab1.layer.cornerRadius = 2*YAYIScreenScale;
    [self.contentView addSubview:dotLab1];
    self.dotLab1 = dotLab1;
    
    UILabel *ageLab = [UILabel new];
    ageLab.font = YAFont(15);
    ageLab.textColor = YAColor(@"#424242");
    [self.contentView addSubview:ageLab];
    self.ageLab = ageLab;
    
    
    UIImageView *leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"enter"];
    [self.contentView addSubview:leftView];
    self.leftView = leftView;
    
    UIView *tagView = [UIView new];
    tagView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:tagView];
    self.tagView = tagView;
    
    UIView *seperateView=[UIView new];
    seperateView.backgroundColor = YAColor(@"#f3f4f6");
    [self.contentView addSubview:seperateView];
    self.seperateView = seperateView;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(15*YAYIScreenScale));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(90*YAYIScreenScale, 90*YAYIScreenScale));
    }];
    CGFloat w = [self getTagSize:_model.patient.name].width;
    
    [self.namelLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(18);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(-10*YAYIScreenScale);
        if (w >80) {
            make.width.equalTo(@(80*YAYIScreenScale));
        }
    }];
    [self.dotLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.namelLab.mas_centerY);
        make.left.mas_equalTo(self.namelLab.mas_right).offset(6*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(4*YAYIScreenScale, 4*YAYIScreenScale));
    }];
    
    [self.genderLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.namelLab.mas_centerY);
        make.left.mas_equalTo(self.dotLab.mas_right).offset(6*YAYIScreenScale);
    
    }];
    [self.dotLab1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.namelLab.mas_centerY);
        make.left.mas_equalTo(self.genderLab.mas_right).offset(6*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(4*YAYIScreenScale, 4*YAYIScreenScale));
    }];
    
    [self.ageLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dotLab1.mas_right).offset(6*YAYIScreenScale);
        make.centerY.mas_equalTo(self.dotLab1.mas_centerY);
    }];
    [self.leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(-4*YAYIScreenScale);
        make.right.equalTo(@(-15*YAYIScreenScale));
    }];
    [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.namelLab.mas_left);
        make.top.mas_equalTo(self.namelLab.mas_bottom).offset(10*YAYIScreenScale);
        make.width.equalTo(@(240*YAYIScreenScale));
        make.height.equalTo(@(self.tagView.height));
    }];
    
    [self.seperateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(self.icon.mas_bottom).offset(8*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 5*YAYIScreenScale));
    }];
}

-(void)createTagView:(NSArray *)ary{
    CGFloat rowWidth = 0;  // 一行的宽度
    CGFloat rowCout  = 0;  // 行数
    CGFloat colCout = 0;   // 列数
    CGFloat rw = 0;        //记录每次横向移动位置
    CGFloat col = 0;       //  记录每次纵向移动的位置
    for (int i  = 0; i < ary.count; i++) {
        YAPatientInfoPatientTagModel *model = ary[i];
        NSString *tagName = model.tagName;
        UILabel *label = [UILabel new];
        label.font = YAFont(12);
        if (model.selected) {
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor colorWithHexString:@"#424242"];
        }else{
            label.textColor = YAColor(@"#8a8a8a");
            label.backgroundColor = [UIColor whiteColor];
            
        }
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label.layer.borderColor = YAColor(@"#e7e7e7").CGColor;
        label.layer.borderWidth = 1.f;
        label.layer.cornerRadius = 11.5*YAYIScreenScale;
        label.userInteractionEnabled = YES;
        label.text = tagName;
        [self.tagView  addSubview:label];
        
        
        CGFloat itemW = tagName.length>2?[self getTagSize:tagName].width + 20:[self getTagSize:tagName].width + 26;
        CGFloat itemH = 23*YAYIScreenScale;
        CGFloat itemX = 0 + rw;
        CGFloat itemY = 0 + (itemH + 4*YAYIScreenScale)*rowCout;
        rowWidth =  itemW + itemX;
        
        
        
        
        if (rowWidth > 240*YAYIScreenScale) {
            rowWidth = 0;
            rowCout++;
            if (rowCout == 1) {
                break;
            }
            colCout = 0;
            rw = 0;
            itemX = 0;
            itemY = 0 + (itemH + 4*YAYIScreenScale)*rowCout;
            label.frame = CGRectMake(itemX, itemY, itemW, itemH);
            
        }else{
            label.frame = CGRectMake(itemX, itemY, itemW, itemH);
            colCout++;
        }
        rw = rw + itemW + 4*YAYIScreenScale *1;
        
        // 根据实际内容  ，更新容器的高度
        col = itemY + itemH;
        if (col > self.height){
            self.tagView.height = itemY+itemH;
        }
        
    }

}

//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName{
    
    NSDictionary *attrs = @{NSFontAttributeName : YAFont(12)};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
