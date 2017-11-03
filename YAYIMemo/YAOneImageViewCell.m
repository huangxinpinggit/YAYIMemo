//
//  YAOneImageViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAOneImageViewCell.h"

@implementation YAOneImageViewCell

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
    self.nameLab.text = _model.patientname;
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_model.info]) {
        self.imageContentView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_model.info];
    }else{
        self.imageContentView.image = [UIImage imageNamed:@"b_photo"];
    };
    
    
    self.dateLab.text = _model.createtime;
    if ([_model.age integerValue] > 0) {
        self.ageLab.text = [NSString stringWithFormat:@"%d",[_model.age intValue]];;
    };
    self.toothLab.text = _model.tooth;
    NSLog(@"%@",_model.tooth);
    [self createTags:_model.tagList];
}
-(void)loadImage:(YAMedicalModel *)model
{
   [self.imageContentView sd_setImageWithURL:[NSURL URLWithString:model.info] placeholderImage:[UIImage imageNamed:@"b_photo"]];
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
    UIImage *image = [UIImage imageNamed:@"green"];
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
    
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"不知火舞";
    nameLab.textColor = [UIColor colorWithHexString:@"#424242"];
    nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    nameLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *ageLab = [UILabel new];
    ageLab.text = @"24岁";
    ageLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    ageLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:ageLab];
    self.ageLab = ageLab;
    
    
    UIImageView *imageContentView = [UIImageView new];
    imageContentView.userInteractionEnabled = YES;
    imageContentView.contentMode = UIViewContentModeScaleAspectFill;
    imageContentView.clipsToBounds = YES;
    [imageContentView zy_cornerRadiusAdvance:2 rectCornerType:UIRectCornerAllCorners];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic)];
    [imageContentView addGestureRecognizer:tap];
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
    UIImage *image = [UIImage imageNamed:@"green"];
    
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
        make.size.mas_equalTo(CGSizeMake(103*YAYIScreenScale, 117*YAYIScreenScale));
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
-(void)showPic{
    // 1. 创建photoBroseView对象
    
    
    if (self.imageContentView.image == nil) {
        return;
    }
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImageView)数组
    photoBroseView.imagesURL = @[_model.info];
    photoBroseView.showFromView = self.imageContentView;
    photoBroseView.hiddenToView = self.imageContentView;
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    //photoBroseView.currentIndex = 1;
    
    // 3.显示(浏览)
    [photoBroseView show];
}
@end
