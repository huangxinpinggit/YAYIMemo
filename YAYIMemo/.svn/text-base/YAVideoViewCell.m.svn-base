//
//  YAVideoViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAVideoViewCell.h"
#import "YAAVPlayer.h"
@implementation YAVideoViewCell

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
         self.player = [YAAVPlayer shareInstance];
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
    
    self.timeLab.text = _model.voicetime;
    
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
    self.dateLab.text = _model.createtime;
    self.toothLab.text = _model.tooth;
    [self createTags:_model.tagList];
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
    UIImage *image = [UIImage imageNamed:@"yellow"];
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
    
    
    
    
    
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    voiceBtn.imageView.animationImages = @[[UIImage imageNamed:@"voice_a1"],[UIImage imageNamed:@"voice_a2"],[UIImage imageNamed:@"voice_a3"],[UIImage imageNamed:@"voice_a4"]];
    voiceBtn.imageView.animationDuration = 0.5;
    voiceBtn.imageView.animationRepeatCount = 0;
    [voiceBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [voiceBtn setImage:[UIImage imageNamed:@"voice_b1"] forState:UIControlStateNormal];
   
    
    [self.contentView addSubview:voiceBtn];
    self.voiceImage =voiceBtn;
    
    UILabel *timeLab = [UILabel new];
    timeLab.font = YAFont(14);
    timeLab.text = @"2:50";
    timeLab.textColor = YAColor(@"#8a8a8a");
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    
    UILabel *dateLab = [UILabel new];
    dateLab.text = @"2017-08-11";
    dateLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    dateLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:dateLab];
    self.dateLab = dateLab;
    
    UIButton *tooth = [UIButton buttonWithType:UIButtonTypeCustom];
    [tooth setImage:[UIImage imageNamed:@"tooth"] forState:UIControlStateNormal];
    [self.contentView addSubview:tooth];
    self.toothLab = _toothLab;
    
    UILabel *toothLab = [UILabel new];
    toothLab.textColor = YAGray_color
    toothLab.textAlignment = NSTextAlignmentCenter;
    toothLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [self.contentView addSubview:toothLab];
    self.tooth = tooth;
    
    UIView *sepreteView = [UIView new];
    sepreteView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    [self.contentView addSubview:sepreteView];
    self.sepreteView = sepreteView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"yellow"];
    UIImage *voice = [UIImage imageNamed:@"voice_b1"];
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
    
    [self.voiceImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hLine.mas_left);
        make.top.mas_equalTo(self.hLine.mas_top).offset(23*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(voice.size.width, voice.size.height));
    }];
    
    [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.voiceImage.mas_centerY);
        make.left.mas_equalTo(self.voiceImage.mas_right).offset(20*YAYIScreenScale);
        make.width.equalTo(@(80*YAYIScreenScale));
    }];
    
    [self.dateLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.voiceImage.mas_left);
        make.top.mas_equalTo(self.voiceImage.mas_bottom).offset(23*YAYIScreenScale);
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
        make.left.mas_equalTo(self.voiceImage.mas_left);
        make.top.mas_equalTo(self.tooth.mas_bottom).offset(5*YAYIScreenScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*YAYIScreenScale);
        make.height.equalTo(@(4*YAYIScreenScale));
    }];
    //36+4+11+17.8+23+52+23+28 = 68.8+42+52+23 = 75+68.8=143.8
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
-(void)playAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender.imageView startAnimating];
        self.player.url = _model.info;
        self.player.playerCompleted = ^{
            [sender.imageView stopAnimating];
             sender.selected = false;
        };
    }else{
        [self.player pause];
        [sender.imageView stopAnimating];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(playerSound:)]) {
        [_delegate playerSound:_model];
    }
    
}

@end
