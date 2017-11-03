//
//  YAMedicalImageViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMedicalImageViewCell.h"
//#import "UIImageView+YYWebImage.h"
@implementation YAMedicalImageViewCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self createView];
    }
    return self;
}
-(void)setIsFreshed:(BOOL)isFreshed
{
    _isFreshed = isFreshed;
    if(_isFreshed){
        [self  loadImage:_model];
    }
}
-(void)setModel:(YAMedicalModel *)model
{
    
    _model = model;
    [self loadDataSource];
}
-(void)loadDataSource{

    
    
    self.nameLab.text = _model.patientname;
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_model.info]) {
        self.imageContentView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_model.info];
    }else{
        self.imageContentView.image = [UIImage imageNamed:@"b_photo"];
    }
    
    
    self.dateLab.text = _model.createtime;
    if ([_model.age integerValue] > 0) {
        self.ageLab.text = [NSString stringWithFormat:@"%d",[_model.age intValue]];;
    }else{
        self.ageLab.text = @"";
    }
    self.toothLab.text = _model.tooth;
    [self createTags:_model.tagList];
}
-(void)loadImage:(YAMedicalModel *)model
{
    //[super loadImage:model];
    if (model.patientid != nil && [model.patientid integerValue] != 0) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"home_avatar"] options:SDWebImageLowPriority];
    }else{
        _icon.image = [UIImage new];
    }
    //__weak typeof(_imageContentView) imageView = self.imageContentView;
    [self.imageContentView  sd_setImageWithURL:[NSURL URLWithString:model.info] placeholderImage:[UIImage imageNamed:@"b_photo"]];
//    [self.imageContentView sd_setImageWithURL:[NSURL URLWithString:model.info] placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image) {
//            int width = 103;
//            int height = 117;
//            CGFloat scale = (height / width) / (imageView.height / imageView.width);
//            if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
//                imageView.contentMode = UIViewContentModeScaleAspectFill;
//                imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
//            } else { // 高图只保留顶部
//                imageView.contentMode = UIViewContentModeScaleToFill;
//                imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
//            }
//            imageView.image = image;
//
//            CATransition *transition = [CATransition animation];
//            transition.duration = 0.15;
//            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//            transition.type = kCATransitionFade;
//            [imageView.layer addAnimation:transition forKey:@"contents"];
//
//        }
//    }];
    
    
}
-(UIView *)tagView
{
    if (_tagView == nil) {
        self.tagView = [UIView new];
        
        self.tagView.backgroundColor = [UIColor whiteColor];
        self.tagView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tape = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction)];
        [self.tagView addGestureRecognizer:tape];
    }
    return _tagView;
}

-(void)createView{
    
    [self.contentView addSubview:self.tagView];
    
    self.moreIcon = [UIButton new];
    [self.moreIcon setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.moreIcon];
    
    self.contentLab = [UILabel new];
    self.contentLab.textColor = [UIColor colorWithHexString:@"#424242"];
    self.contentLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.contentLab.textAlignment = NSTextAlignmentCenter;
    self.contentLab.userInteractionEnabled = YES;
    self.contentLab.numberOfLines = 0;
    [self.tagView addSubview:self.contentLab];
    
    self.hLine = [UILabel new];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:self.hLine];
    
    self.icon = [[UIImageView alloc] initWithRoundingRectImageView];
    [self.icon zy_cornerRadiusAdvance:20*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self.icon addGestureRecognizer:tap];
    self.icon.backgroundColor = [UIColor whiteColor];
    self.icon.layer.shouldRasterize = YES;
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
    
    
    //
    self.imageContentView = [UIImageView new];
    self.imageContentView.userInteractionEnabled = YES;
    self.imageContentView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageContentView.clipsToBounds = YES;
    self.imageContentView.backgroundColor = [UIColor whiteColor];
    self.imageContentView.layer.shouldRasterize = YES;
    self.imageView.opaque = YES;
    [self.imageContentView zy_cornerRadiusAdvance:3*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic)];
    [self.imageContentView addGestureRecognizer:tap1];
    [self.contentView addSubview:self.imageContentView];
    
    
    self.dateLab = [UILabel new];
    self.dateLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.dateLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:self.dateLab];
    
    self.tooth = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tooth setImage:[UIImage imageNamed:@"tooth"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.tooth];
    
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
    //(15 +15 +13+7)*YAYIScreenScale
       [super layoutSubviews];
        UIImage *image = [UIImage imageNamed:@"more"];
        self.tagView.frame = CGRectMake(84*YAYIScreenScale, 14, SCREEN_W - 129*YAYIScreenScale, 25*YAYIScreenScale+[_model tagviewHH]);
        self.moreIcon.frame = CGRectMake(SCREEN_W - 15*YAYIScreenScale-image.size.width , 14, image.size.width, 25*YAYIScreenScale);
        self.hLine.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.tagView.frame)+2*YAYIScreenScale, CGRectGetMaxX(self.moreIcon.frame), 1);
        self.icon.frame = CGRectMake(17*YAYIScreenScale, CGRectGetMaxY(self.hLine.frame)+11*YAYIScreenScale, 40*YAYIScreenScale, 40*YAYIScreenScale);
      if ([_model.patientid integerValue] != 0) {
        self.nameLab.frame = CGRectMake(CGRectGetMinX(self.hLine.frame), CGRectGetMaxY(self.hLine.frame)+15*YAYIScreenScale, 200*YAYIScreenScale, 15*YAYIScreenScale);
        self.ageLab.frame = CGRectMake(CGRectGetMinX(self.hLine.frame), CGRectGetMaxY(self.nameLab.frame)+7*YAYIScreenScale, 200*YAYIScreenScale, 13*YAYIScreenScale);
        self.imageContentView.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.ageLab.frame)+20*YAYIScreenScale, 205*YAYIScreenScale, 232.5*YAYIScreenScale);
       }else{
        self.imageContentView.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.hLine.frame)+20*YAYIScreenScale, 205*YAYIScreenScale, 232.5*YAYIScreenScale);
       }
    
        self.dateLab.frame = CGRectMake(CGRectGetMinX(self.imageContentView.frame), CGRectGetMaxY(self.imageContentView.frame)+20*YAYIScreenScale, 90*YAYIScreenScale, 14*YAYIScreenScale);
        self.toothLab.frame =CGRectMake(SCREEN_W - 87*YAYIScreenScale -30,CGRectGetMinY(self.dateLab.frame) ,72*YAYIScreenScale , 14*YAYIScreenScale);
        self.tooth.frame = CGRectMake(CGRectGetMaxX(self.toothLab.frame), CGRectGetMidY(self.dateLab.frame) -15, 30, 30);
        self.sepreteView.frame = CGRectMake(0, CGRectGetMaxY(self.toothLab.frame)+20, SCREEN_W, 10*YAYIScreenScale);

    
    /*
    
    [self createTags:_model.tagList];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@(84*YAYIScreenScale));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-45*YAYIScreenScale);
        make.height.equalTo(@(25*YAYIScreenScale +[_model tagviewHH]));
    }];
    
    [self.moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);
        make.top.equalTo(@(14));
        make.height.equalTo(@(25*YAYIScreenScale));
        
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_left);
        make.top.mas_equalTo(self.tagView.mas_bottom).offset(2*YAYIScreenScale);
        make.right.mas_equalTo(self.moreIcon.mas_right);
        make.height.equalTo(@1);
    }];
    
    
    
    
    
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
    
    [self.imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_left);
        make.top.mas_equalTo(self.ageLab.mas_bottom).offset(20*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(205*YAYIScreenScale, 232.5*YAYIScreenScale));
    }]; //(20 + 232.5)*YAYIScreenScale
    
    [self.dateLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageContentView.mas_bottom).offset(20*YAYIScreenScale);
        make.left.mas_equalTo(self.imageContentView.mas_left);
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
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
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
        label.userInteractionEnabled = YES;
        [self.tagView addSubview:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction)];
        [label addGestureRecognizer:tap];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(button.mas_right).offset(10*YAYIScreenScale);
            make.centerY.mas_equalTo(self.tagView.mas_centerY);
            make.height.equalTo(@(15*YAYIScreenScale));
        }];
    }
}


-(void)showPic{
    // 1. 创建photoBroseView对象
    
    
    if (self.imageContentView.image == nil) {
        return;
    }
    
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImageView)数组
    NSLog(@"%@",_model.info);
    photoBroseView.imagesURL = @[_model.info];
    photoBroseView.showFromView = self.imageContentView;
    photoBroseView.hiddenToView = self.imageContentView;
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    //photoBroseView.currentIndex = 1;
    
    // 3.显示(浏览)
    [photoBroseView show];
}

-(void)buttonAction{
    if (_delegate &&[_delegate respondsToSelector:@selector(addTagAction:)]) {
        [_delegate addTagAction:_model];
    }
}

// 获取cell的高度
-(CGFloat)cellHeight{
    [self setNeedsLayout];
    return self.sepreteView.y + 10*YAYIScreenScale;
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:YAFont(fontSize)
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeToFit.height;
}
-(NSString *)tagStr:(NSArray *)ary{
    NSMutableString *str = [NSMutableString string];
    for (YATagsModel *model in ary) {
        [str appendString:@"| "];
        [str appendString:model.tagname];
        [str appendString:@" |"];
    }
    return str;
}

//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName font:(UIFont *)font{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)clickAction:(UITapGestureRecognizer *)sender{
    if (_delegate &&[_delegate respondsToSelector:@selector(detailAction:)]) {
        [_delegate detailAction:_model];
    }
}
@end
