//
//  YAMedicalTextViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMedicalTextViewCell.h"


@implementation YAMedicalTextViewCell
{
    CGFloat _tagViewH;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _tagViewH = 25*YAYIScreenScale;
        [self createView];
    }
    return self;
}
-(void)setModel:(YAMedicalModel *)model
{
    _model = model;
    [self loadDataSource];
}
-(void)loadDataSource{
    if (_model.patientid != nil && [_model.patientid integerValue] != 0) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[UIImage imageNamed:@"home_avatar"] options:SDWebImageLowPriority];
    }else{
        _icon.image = [UIImage new];
    }
    self.nameLab.text = _model.patientname;
    self.contentLab.text = _model.info;
    self.dateLab.text = _model.createtime;
    if ([_model.age integerValue] > 0) {
        self.ageLab.text = [NSString stringWithFormat:@"%d",[_model.age intValue]];;
    }else{
        self.ageLab.text = @"";
    }
    self.toothLab.text = _model.tooth;
    [self createTags:_model.tagList];
    CGFloat height = [self contentHeight:_model.info].height;
    if (height <50) {
        self.openBtn.hidden = YES;
    }else{
        self.openBtn.hidden = false;
    }
}
-(void)loadImage:(YAMedicalModel *)model
{
    [super loadImage:model];
    
}
-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    self.openBtn.selected =_isOpen;
}

-(UIView *)tagView
{
    if (_tagView == nil) {
        self.tagView = [UIView new];
        
        self.tagView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction)];
        [self.tagView addGestureRecognizer:tap];
    }
    return _tagView;
}

-(void)createView{
    
    [self.contentView addSubview:self.tagView];
    
    self.moreIcon = [UIButton new];
    [self.moreIcon setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.moreIcon];;
    
    self.hLine = [UILabel new];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:self.hLine];
    
    self.icon = [UIImageView new];
    [self.icon zy_cornerRadiusAdvance:20*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    self.icon.layer.shouldRasterize = YES;
    self.icon.backgroundColor = [UIColor clearColor];
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self.icon addGestureRecognizer:tap];
    [self.contentView addSubview:self.icon];
    
    
    self.nameLab = [UILabel new];
   
    self.nameLab.textColor = [UIColor colorWithHexString:@"#424242"];
    self.nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLab];
    
    self.ageLab = [UILabel new];
    
    self.ageLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.ageLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:self.ageLab];
    
    
    self.contentLab = [YACopyLabel new];
    self.contentLab.numberOfLines = 0;
    self.contentLab.textColor = [UIColor colorWithHexString:@"#424242"];
    self.contentLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [self.contentView addSubview:self.contentLab];
    
    self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openBtn.layer.masksToBounds = YES;
    self.openBtn.layer.cornerRadius = 8.f;
    self.openBtn.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    self.openBtn.layer.borderWidth = 1.f;
    [self.openBtn setTitle:@"查看全文" forState:UIControlStateNormal];
    [self.openBtn setTitle:@"收起" forState:UIControlStateSelected];
    self.openBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.openBtn addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.openBtn setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.openBtn];
    
    self.dateLab = [UILabel new];
   
    self.dateLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.dateLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:self.dateLab];
    
    self.tooth = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tooth setImage:[UIImage imageNamed:@"tooth"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.tooth];;
    
    self.toothLab = [UILabel new];
    self.toothLab.textColor = YAGray_color
    self.toothLab.textAlignment = NSTextAlignmentCenter;
    self.toothLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:self.toothLab];
    
    
    
    self.sepreteView = [UIView new];
    self.sepreteView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    [self.contentView addSubview:self.sepreteView];
    
   
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"more"];
    
    self.tagView.frame = CGRectMake(84*YAYIScreenScale, 14, SCREEN_W - 129*YAYIScreenScale, 25*YAYIScreenScale+[_model tagviewHH]);
    self.moreIcon.frame = CGRectMake(SCREEN_W - 15*YAYIScreenScale-image.size.width , 14, image.size.width, 25*YAYIScreenScale);
    self.hLine.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.tagView.frame)+2*YAYIScreenScale, CGRectGetMaxX(self.moreIcon.frame), 1);
    self.icon.frame = CGRectMake(17*YAYIScreenScale, CGRectGetMaxY(self.hLine.frame)+11*YAYIScreenScale, 40*YAYIScreenScale, 40*YAYIScreenScale);
    if ([_model.patientid integerValue] != 0) {
        self.nameLab.frame = CGRectMake(CGRectGetMinX(self.hLine.frame), CGRectGetMaxY(self.hLine.frame)+15*YAYIScreenScale, 200*YAYIScreenScale, 15*YAYIScreenScale);
        self.ageLab.frame = CGRectMake(CGRectGetMinX(self.hLine.frame), CGRectGetMaxY(self.nameLab.frame)+7*YAYIScreenScale, 200*YAYIScreenScale, 13*YAYIScreenScale);
        if (self.isOpen) {
            CGFloat height = [self contentHeight:_model.info].height;
            self.contentLab.frame = CGRectMake(CGRectGetMinX(self.tagView.frame),CGRectGetMaxY(self.ageLab.frame)+20*YAYIScreenScale,SCREEN_W -84*YAYIScreenScale -15*YAYIScreenScale ,height);
        }else{
            self.contentLab.frame = CGRectMake(CGRectGetMinX(self.tagView.frame),CGRectGetMaxY(self.ageLab.frame)+20*YAYIScreenScale,SCREEN_W -84*YAYIScreenScale -15*YAYIScreenScale ,65*YAYIScreenScale);
        }
    }else{
        if (self.isOpen) {
            CGFloat height = [self contentHeight:_model.info].height;
            self.contentLab.frame = CGRectMake(CGRectGetMinX(self.tagView.frame),CGRectGetMaxY(self.hLine.frame)+20*YAYIScreenScale,SCREEN_W -84*YAYIScreenScale -15*YAYIScreenScale ,height);
        }else{
            self.contentLab.frame = CGRectMake(CGRectGetMinX(self.tagView.frame),CGRectGetMaxY(self.hLine.frame)+20*YAYIScreenScale,SCREEN_W -84*YAYIScreenScale -15*YAYIScreenScale ,65*YAYIScreenScale);
        }
    }
   
    
    self.openBtn.frame = CGRectMake(CGRectGetMinX(self.tagView.frame),CGRectGetMaxY(self.contentLab.frame) +14.5*YAYIScreenScale , 75*YAYIScreenScale, 22*YAYIScreenScale);
    self.dateLab.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.openBtn.frame)+20*YAYIScreenScale, 84*YAYIScreenScale, 14*YAYIScreenScale);
    
    self.toothLab.frame =CGRectMake(SCREEN_W - 87*YAYIScreenScale -30,CGRectGetMinY(self.dateLab.frame) ,72*YAYIScreenScale , 14*YAYIScreenScale);
    self.tooth.frame = CGRectMake(CGRectGetMaxX(self.toothLab.frame), CGRectGetMidY(self.dateLab.frame) -15, 30, 30);
    self.sepreteView.frame = CGRectMake(0, CGRectGetMaxY(self.toothLab.frame)+20, SCREEN_W, 10*YAYIScreenScale);
    
    
    /*
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@(84*YAYIScreenScale));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-45*YAYIScreenScale);
        make.height.equalTo(@(_tagViewH));
    }];
   
    
    [self.moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);;
        make.top.equalTo(@(14));
        make.height.equalTo(@(25*YAYIScreenScale));
        
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_left);
        make.top.mas_equalTo(self.tagView.mas_bottom).offset(2*YAYIScreenScale);
        make.right.mas_equalTo(self.moreIcon.mas_right);
        make.height.equalTo(@1);
    }];//+1
    
    
    
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hLine.mas_bottom).offset(11*YAYIScreenScale);
        make.left.equalTo(@(17*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale, 40*YAYIScreenScale));
    }];
    
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hLine.mas_left);
        make.top.mas_equalTo(self.hLine.mas_bottom).offset(15*YAYIScreenScale);
        make.height.equalTo(@(15*YAYIScreenScale));
    }]; //+30*YAYIScreenScale
    
    [self.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(7*YAYIScreenScale);
        make.height.equalTo(@(13*YAYIScreenScale));
    }];//(13+7)*YAYIScreenScale
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_left);
        make.top.mas_equalTo(self.ageLab.mas_bottom).offset(20*YAYIScreenScale);
        make.height.equalTo(@(65*YAYIScreenScale));
        make.right.equalTo(@(-15*YAYIScreenScale));
       
    }]; //(20 + 75)*YAYIScreenScale
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLab.mas_bottom).offset(14.5*YAYIScreenScale);
        make.left.mas_equalTo(self.tagView.mas_left);
        make.size.mas_equalTo(CGSizeMake(75*YAYIScreenScale, 22*YAYIScreenScale));
    }];
    
    [self.dateLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.openBtn.mas_bottom).offset(20*YAYIScreenScale);
        make.left.mas_equalTo(self.openBtn.mas_left);
        make.height.equalTo(@(14*YAYIScreenScale));
    }];  //(20+14)*YAYIScreenScale
    
    [self.tooth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);
        make.centerY.mas_equalTo(self.dateLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.toothLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tooth.mas_left);
        make.centerY.mas_equalTo(self.tooth.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(62*YAYIScreenScale, 13*YAYIScreenScale));
    }];

    
    [self.sepreteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(self.dateLab.mas_bottom).offset(20*YAYIScreenScale);
        make.height.equalTo(@(10*YAYIScreenScale));
        make.width.equalTo(@(SCREEN_W));
    }];
     */
    NSLog(@"%lf",self.sepreteView.y);
    
}

-(void)createTags:(NSArray *)tagAry{
    //重置 _tagViewH
    [self.tagView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    UIImage *image = [UIImage imageNamed:@"more"];
    CGFloat W =  SCREEN_W - 84*YAYIScreenScale - image.size.width - 30*YAYIScreenScale;
    CGFloat rowCount = 0;
    CGFloat colCount = 0;
    CGFloat topMarg = 4;
    CGFloat rowWidth = 0;
    if (tagAry.count >0) {
        for (int i = 0 ; i < tagAry.count; i++) {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor colorWithHexString:@"#424242"];
            label.font = YAFont(15);
            label.textAlignment = NSTextAlignmentCenter;
            label.userInteractionEnabled = YES;
            
            [self.tagView addSubview:label];
            
            YATagsModel *model = tagAry[i];
            label.text = model.tagname;
            CGFloat itemW = [self getTagSize:model.tagname font:YAFont(15)].width+14;
            rowWidth = rowWidth+itemW+1;
            if (rowWidth - W > 10) {
                colCount = 0;
                rowWidth = 0;
                rowCount++;
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@(rowCount*(25*YAYIScreenScale + topMarg)));
                    make.left.equalTo(@(0));
                    make.height.equalTo(@(25*YAYIScreenScale));
                    make.width.equalTo(@(itemW));
                }];
                
                
                
                UILabel *vLine = [UILabel new];
                vLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
                [self.tagView addSubview:vLine];
                [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(label.mas_right);
                    make.centerY.mas_equalTo(label.mas_centerY);
                    make.width.equalTo(@1);
                    make.height.equalTo(@23);
                }];
                colCount++;
                rowWidth = rowWidth+itemW+1;
            }else{
               
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@(rowCount*(25*YAYIScreenScale + topMarg)));
                    make.left.equalTo(@(rowWidth-itemW-1));
                    make.height.equalTo(@(25*YAYIScreenScale));
                    make.width.equalTo(@(itemW));
                }];
                
                UILabel *vLine = [UILabel new];
                vLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
                [self.tagView addSubview:vLine];
                [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(label.mas_right);
                    make.centerY.mas_equalTo(label.mas_centerY);
                    make.width.equalTo(@1);
                    make.height.equalTo(@23);
                }];
                colCount++;
            }
        }
    }else{
        UIImage *image = [UIImage imageNamed:@"add-tags"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(selectedAction) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        [self.tagView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tagView.mas_left);
            make.centerY.mas_equalTo(self.tagView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
        }];
        
        UILabel *label = [UILabel new];
        label.text = @"添加标签...";
        label.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
        label.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
        [self.tagView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(button.mas_right).offset(10*YAYIScreenScale);
            make.centerY.mas_equalTo(self.tagView.mas_centerY);
            make.height.equalTo(@(15*YAYIScreenScale));
        }];
    }
}


-(void)selectedAction{
    if (_delegate && [_delegate respondsToSelector:@selector(addTagAction:)]) {
        [_delegate addTagAction:_model];
    }
}

// 获取cell的高度
-(CGFloat)cellHeight{
    [self setNeedsLayout];
    return self.sepreteView.y + 10*YAYIScreenScale;
}

//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName font:(UIFont *)font{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25*YAYIScreenScale) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)clickAction:(UITapGestureRecognizer *)sender{
    if (_delegate &&[_delegate respondsToSelector:@selector(detailAction:)]) {
        [_delegate detailAction:_model];
    }
}

-(void)openAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(openModelAction:)]) {
        [_delegate openModelAction:_model];
    }
}

-(CGSize)contentHeight:(NSString *)conntent{

    NSDictionary *attrs = @{NSFontAttributeName : YAFont(15)};
    return [conntent boundingRectWithSize:CGSizeMake(SCREEN_W -84*YAYIScreenScale -15*YAYIScreenScale, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
