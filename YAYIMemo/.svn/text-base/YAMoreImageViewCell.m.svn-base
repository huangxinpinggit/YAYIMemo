//
//  YAMoreImageViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMoreImageViewCell.h"

@implementation YAMoreImageViewCell

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
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createView];
        [self createImageViews];
    }
    return self;
}

-(void)setModel:(YAMedicalModel *)model
{
    _model = model;
    [self loadDataSource];
}
-(void)loadDataSource{
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
    self.dateLab.text = _model.createtime;
    self.toothLab.text = _model.tooth;
    [self createTags:_model.tagList];
    NSArray *ary = [_model.info componentsSeparatedByString:@","];
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
        };
        if (ary.count > 3 && i == 2) {
            
            self.alphaView.hidden = false;
        }else{
            self.alphaView.hidden = YES;
        }
    }

}
-(void)loadImage:(YAMedicalModel *)model
{
    NSArray *ary = [model.info componentsSeparatedByString:@","];
    for (int i = 0; i < self.imageContentView.subviews.count; i++) {
        UIImageView *imageView = self.imageContentView.subviews[i];
        if (i >= ary.count) {
            imageView.image = [UIImage new];
            return;
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:ary[i]] placeholderImage:[UIImage imageNamed:@"b_photo"]];
        if (ary.count > 3 && i == 2) {
            
            self.alphaView.hidden = false;
        }else{
            self.alphaView.hidden = YES;
        }
    }

    
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
    UILabel *vLine = [UILabel new];
    vLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:vLine];
    self.vLine = vLine;
    
    UIImageView *dotImage = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"red"];
    dotImage.image = image;
    [self.contentView addSubview:dotImage];
    self.dotIcon = dotImage;
    
    UIButton *moreIcon = [UIButton new];
    [moreIcon setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.contentView addSubview:moreIcon];
    self.moreIcon = moreIcon;
    
    
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    
    UIImageView *icon = [[UIImageView alloc] initWithRoundingRectImageView];
    [icon zy_cornerRadiusAdvance:20*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    icon.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    
    
    
    
    UIImageView *imageContentView = [UIImageView new];
    imageContentView.userInteractionEnabled = YES;
    imageContentView.contentMode = UIViewContentModeScaleAspectFill;
    imageContentView.clipsToBounds = YES;
    [self.contentView addSubview:imageContentView];
    self.imageContentView =imageContentView;
    
    
    UILabel *dateLab = [UILabel new];
    dateLab.text = @"2017-08-11";
    dateLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    dateLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:dateLab];
    self.dateLab = dateLab;
    
    UIButton *tooth = [UIButton buttonWithType:UIButtonTypeCustom];
    [tooth setImage:[UIImage imageNamed:@"tooth"] forState:UIControlStateNormal];
    [self.contentView addSubview:tooth];
    self.tooth = tooth;
    
    UILabel *toothLab = [UILabel new];
    toothLab.textColor = YAGray_color
    toothLab.textAlignment = NSTextAlignmentCenter;
    toothLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:toothLab];
    self.toothLab = toothLab;
    
    UIView *sepreteView = [UIView new];
    sepreteView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    [self.contentView addSubview:sepreteView];
    self.sepreteView = sepreteView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    UIImage *image = [UIImage imageNamed:@"red"];
    
    [self.vLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(43*YAYIScreenScale));
        make.top.equalTo(@0);
        make.width.equalTo(@1);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    [self.dotIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@(33*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(image.size.width,image.size.height));
    }];
    
    [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dotIcon.mas_right).offset(31*YAYIScreenScale);
        make.top.equalTo(@0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-45*YAYIScreenScale);
        make.height.equalTo(@(25*YAYIScreenScale + [_model tagviewHH]));
    }];
    
    [self.moreIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);
        make.top.equalTo(@(0));
        make.height.equalTo(@(25*YAYIScreenScale));
        
    }];
    
    [self.hLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_left);
        make.top.mas_equalTo(self.tagView.mas_bottom).offset(4*YAYIScreenScale);
        make.right.mas_equalTo(self.moreIcon.mas_right);
        make.height.equalTo(@1);
    }];
    
    [self.imageContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hLine.mas_left);
        make.top.mas_equalTo(self.hLine.mas_top).offset(14*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(253*YAYIScreenScale, 79*YAYIScreenScale));
    }];
   
    [self.dateLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageContentView.mas_left);
        make.top.mas_equalTo(self.imageContentView.mas_bottom).offset(20*YAYIScreenScale);
    }];
    [self.tooth mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);
        make.centerY.mas_equalTo(self.dateLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.toothLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tooth.mas_left);
        make.centerY.mas_equalTo(self.tooth.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(62*YAYIScreenScale, 13*YAYIScreenScale));
    }];
    
    [self.sepreteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageContentView.mas_left);
        make.top.mas_equalTo(self.tooth.mas_bottom).offset(5*YAYIScreenScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);
        make.height.equalTo(@(4*YAYIScreenScale));
    }];
    //36+4+11+17.8+20+233+14+28 = 67.8+42+253=295+67.8=362.8
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
                NSLog(@"============%lf==============",rowWidth-itemW-1);
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
-(void)createImageViews{
    for (int i = 0; i < 3 ; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic:)];
        imageView.tag = i;
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
            label.text = @"4";
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
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:ary[i]] placeholderImage:nil];
        
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
-(void)buttonAction{
    if (_delegate &&[_delegate respondsToSelector:@selector(addTagAction:)]) {
        [_delegate addTagAction:_model];
    }
}

//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName font:(UIFont *)font{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)showPic:(UITapGestureRecognizer *)tap{
    // 1. 创建photoBroseView对象
    UIImageView *imageView = (UIImageView *)tap.view;
    if (imageView.image == nil) {
        return;
    }
    
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
@end
