//
//  YAMedicalMoreImageViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMedicalMoreImageViewCell.h"

@implementation YAMedicalMoreImageViewCell
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
-(void)setIsFreshed:(BOOL)isFreshed
{
    _isFreshed = isFreshed;
    if(_isFreshed){
         [self  loadImage:_model];
    }
}
-(void)loadDataSource{
   
    if (_model.patientid != nil && [_model.patientid integerValue] != 0) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[UIImage imageNamed:@"home_avatar"] options:SDWebImageLowPriority];
    }else{
        _icon.image = [UIImage new];
    }
    self.nameLab.text = _model.patientname;
    
    

    if ([_model.age integerValue] > 0) {
        self.ageLab.text = [NSString stringWithFormat:@"%d",[_model.age intValue]];;
    }else{
        self.ageLab.text = @"";
    }
    self.dateLab.text = _model.createtime;
    self.toothLab.text = _model.tooth;
    [self createTags:_model.tagList];
    
    NSArray *ary = [_model.info componentsSeparatedByString:@","];
    self.imageCountLab.text =[NSString stringWithFormat:@"%ld",ary.count];
    for (int i = 0; i < self.imageContentView.subviews.count; i++) {
        UIImageView *imageView = self.imageContentView.subviews[i];
        if (i >= ary.count) {
            imageView.image = [UIImage new];
            return;
        }
        if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:ary[i]]) {
            imageView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:ary[i]];
        }else{
             imageView.image = [UIImage imageNamed:@"s_photo"];
        }
        if (ary.count > 3 && i == 2) {
            
            self.alphaView.hidden = false;
        }else{
            self.alphaView.hidden = YES;
        }
    }
    
    
}

-(void)loadImage:(YAMedicalModel *)model
{
   // [super loadImage:model];
    NSArray *ary = [model.info componentsSeparatedByString:@","];
    self.imageCountLab.text =[NSString stringWithFormat:@"%ld",ary.count];
    for (int i = 0; i < self.imageContentView.subviews.count; i++) {
        UIImageView *imageView = self.imageContentView.subviews[i];
        if (i >= ary.count) {
            imageView.image = [UIImage new];
            return;
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:ary[i]] placeholderImage:[UIImage imageNamed:@"s_photo"]];
        if (ary.count > 3 && i == 2) {
            
            self.alphaView.hidden = false;
        }else{
            self.alphaView.hidden = YES;
        }
    }
}

-(UIView *)tagView
{
    if (!_tagView) {
        self.tagView = [UIView new];
        self.tagView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tape = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction)];
        self.tagView.userInteractionEnabled = YES;
        [self.tagView addGestureRecognizer:tape];
    }
    return _tagView;
}
-(void)createView{
    
    [self.contentView addSubview:self.tagView];
    self.contentLab = [UILabel new];
    self.contentLab.textColor = [UIColor colorWithHexString:@"#424242"];
    self.contentLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    self.contentLab.textAlignment = NSTextAlignmentLeft;
    self.contentLab.userInteractionEnabled = YES;
    self.contentLab.numberOfLines = 0;
    [self.tagView addSubview:self.contentLab];
    
    self.moreIcon = [UIButton new];
    [self.moreIcon setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.moreIcon];
    
    self.hLine = [UILabel new];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:self.hLine];
    
    self.icon = [UIImageView new];
    self.icon.layer.shouldRasterize = YES;
     [self.icon zy_cornerRadiusAdvance:20*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self.icon addGestureRecognizer:tap];
    self.icon.backgroundColor = [UIColor whiteColor];
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
    
    
    self.imageContentView = [UIView new];
    self.imageContentView.backgroundColor = [UIColor whiteColor];
    self.imageContentView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageContentView];
    
    
     [self createcreateImageViews];
    
    
    
    self.dateLab = [UILabel new];
    self.dateLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.dateLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:self.dateLab];
    
    self.tooth = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tooth setImage:[UIImage imageNamed:@"tooth"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.tooth];;
    
    
    self.toothLab = [UILabel new];
    self.toothLab.textColor = YAGray_color
    self.toothLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    self.toothLab.textAlignment = NSTextAlignmentCenter;
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
    if([_model.patientid integerValue] != 0){
        self.nameLab.frame = CGRectMake(CGRectGetMinX(self.hLine.frame), CGRectGetMaxY(self.hLine.frame)+15*YAYIScreenScale, 200*YAYIScreenScale, 15*YAYIScreenScale);
        self.ageLab.frame = CGRectMake(CGRectGetMinX(self.hLine.frame), CGRectGetMaxY(self.nameLab.frame)+7*YAYIScreenScale, 200*YAYIScreenScale, 13*YAYIScreenScale);
        self.imageContentView.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.ageLab.frame)+20*YAYIScreenScale, (79*3+16)*YAYIScreenScale, 79*YAYIScreenScale);
    }else{
        self.imageContentView.frame = CGRectMake(CGRectGetMinX(self.tagView.frame), CGRectGetMaxY(self.hLine.frame)+20*YAYIScreenScale, (79*3+16)*YAYIScreenScale, 79*YAYIScreenScale);
    }
    self.dateLab.frame = CGRectMake(CGRectGetMinX(self.imageContentView.frame), CGRectGetMaxY(self.imageContentView.frame)+20*YAYIScreenScale, 90*YAYIScreenScale, 14*YAYIScreenScale);
    self.toothLab.frame =CGRectMake(SCREEN_W - 87*YAYIScreenScale -30,CGRectGetMinY(self.dateLab.frame) ,72*YAYIScreenScale , 14*YAYIScreenScale);
    self.tooth.frame = CGRectMake(CGRectGetMaxX(self.toothLab.frame), CGRectGetMidY(self.dateLab.frame) -15, 30, 30);
    self.sepreteView.frame = CGRectMake(0, CGRectGetMaxY(self.toothLab.frame)+20, SCREEN_W, 10*YAYIScreenScale);
    
    
    
   /*
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@(84*YAYIScreenScale));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-45*YAYIScreenScale);
        make.height.equalTo(@(25*YAYIScreenScale + [_model tagviewHH]));
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
    
    [self.imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_left);
        make.top.mas_equalTo(self.ageLab.mas_bottom).offset(20*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake((79*3+16)*YAYIScreenScale, 79*YAYIScreenScale));
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
        make.size.mas_equalTo(CGSizeMake(52*YAYIScreenScale, 13*YAYIScreenScale));
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
        [self.tagView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(button.mas_right).offset(10*YAYIScreenScale);
            make.centerY.mas_equalTo(self.tagView.mas_centerY);
            make.height.equalTo(@(15*YAYIScreenScale));
        }];
        
        
    }
}


-(void)createcreateImageViews{
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [UIImageView new];
        
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic:)];
        imageView.tag = i;
        imageView.layer.shouldRasterize = YES;
        imageView.opaque = YES;
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView zy_cornerRadiusAdvance:5*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
        [imageView addGestureRecognizer:tap];
        [self.imageContentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i*(79 + 8)*YAYIScreenScale));
            make.top.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(79*YAYIScreenScale, 79*YAYIScreenScale));
        }];
        if (i == 2) {
            
            UIView *view = [UIView new];
            view.backgroundColor = YA_ALPHA_COLOR(0, 0, 0, 0.3);
            [imageView addSubview:view];
            self.alphaView = view;
            view.hidden = YES;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(0));
                make.top.equalTo(@0);
                make.size.mas_equalTo(CGSizeMake(79*YAYIScreenScale, 79*YAYIScreenScale));
            }];
            
            UIImageView *imageIcon = [UIImageView new];
            UIImage *image = [UIImage imageNamed:@"add_sd"];
            imageIcon.image = image;
            
            [view addSubview:imageIcon];
            [imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@8);
                make.bottom.mas_equalTo(view.mas_bottom).offset(-4);
                make.size.mas_equalTo(CGSizeMake(image.size.width ,image.size.width));
            }];
            
            
            UILabel *label = [UILabel new];
            label.textColor = [UIColor whiteColor];
            self.imageCountLab = label;
            label.font = [UIFont systemFontOfSize:YAYIFontWithScale(20)];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(imageIcon.mas_right).offset(4);
                make.bottom.mas_equalTo(view.mas_bottom).offset(-4);
                make.height.equalTo(@(15*YAYIScreenScale));
            }];
           
        }
    }
    

}
/*
-(void)createImageViews:(NSArray *)ary{
    
    
    [self.imageContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    for (int i = 0; i < ary.count ; i++) {
        UIImageView *imageView = [UIImageView new];
        
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic:)];
        imageView.tag = i;
         [imageView zy_cornerRadiusAdvance:5*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
        [imageView addGestureRecognizer:tap];
        [self.imageContentView addSubview:imageView];
        
        __weak typeof(imageView) imgeView = imageView;
        [imageView sd_setImageWithURL:[NSURL URLWithString:ary[i]] placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                int width = 79;
                int height = 79;
                CGFloat scale = (height / width) / (imgeView.height / imgeView.width);
                if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                    imgeView.contentMode = UIViewContentModeScaleAspectFill;
                    imgeView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                } else { // 高图只保留顶部
                    imgeView.contentMode = UIViewContentModeScaleToFill;
                    imgeView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                }
                imgeView.image = image;
                
                CATransition *transition = [CATransition animation];
                transition.duration = 0.15;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                transition.type = kCATransitionFade;
                [imgeView.layer addAnimation:transition forKey:@"contents"];
                
            }
        }];
        
        
        if (i >= 3) {
            
            UIView *view = [UIView new];
            view.backgroundColor = YA_ALPHA_COLOR(0, 0, 0, 0.3);
            [self.imageContentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(2*(79 + 8)*YAYIScreenScale));
                make.top.equalTo(@0);
                make.size.mas_equalTo(CGSizeMake(79*YAYIScreenScale, 79*YAYIScreenScale));
            }];
            
            UIImageView *imageIcon = [UIImageView new];
            UIImage *image = [UIImage imageNamed:@"add_sd"];
            imageIcon.image = image;
            
            [view addSubview:imageIcon];
            [imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@8);
                make.bottom.mas_equalTo(view.mas_bottom).offset(-4);
                make.size.mas_equalTo(CGSizeMake(image.size.width ,image.size.width));
            }];
            
            
            UILabel *label = [UILabel new];
            label.textColor = [UIColor whiteColor];
            label.text = @"4";
            label.font = [UIFont systemFontOfSize:YAYIFontWithScale(20)];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(imageIcon.mas_right).offset(4);
                make.bottom.mas_equalTo(view.mas_bottom).offset(-4);
                make.height.equalTo(@(15*YAYIScreenScale));
            }];
            
            break;
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(i*(79 + 8)*YAYIScreenScale));
                make.top.equalTo(@0);
                make.size.mas_equalTo(CGSizeMake(79*YAYIScreenScale, 79*YAYIScreenScale));
            }];

        }
    }

   
}
 */


-(void)showPic:(UITapGestureRecognizer *)tap{
    // 1. 创建photoBroseView对象
    UIImageView *imageView = (UIImageView *)tap.view;
    if (imageView.image == nil) {
        return;
    }
    NSLog(@"%@   \n %@",[_model.info componentsSeparatedByString:@","],_model.info);
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    // 2.1 设置图片源(UIImageView)数组
    photoBroseView.imagesURL = [_model.info componentsSeparatedByString:@","];
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    photoBroseView.currentIndex = tap.view.tag;
    photoBroseView.showFromView = tap.view;
    photoBroseView.hiddenToView = tap.view;
    // 3.显示(浏览)
    [photoBroseView show];
}

// 添加标签
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
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25*YAYIScreenScale) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)clickAction:(UITapGestureRecognizer *)sender{
    if (_delegate &&[_delegate respondsToSelector:@selector(detailAction:)]) {
        [_delegate detailAction:_model];
    }
}
@end
