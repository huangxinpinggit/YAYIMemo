//
//  YAMedicalVoiceViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"
#import <AVFoundation/AVFoundation.h>
#import "YAHomeBaseCell.h"
#import "YAAVPlayer.h"
@protocol  YAMedicalVoiceViewCellDelegate <NSObject>

-(void)addTagAction:(YAMedicalModel *)model;
-(void)detailAction:(YAMedicalModel *)model;
-(void)playerSound:(YAMedicalModel *)model;
@end

@interface YAMedicalVoiceViewCell : YAHomeBaseCell
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, strong)UIButton *moreIcon;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UIButton *voiceImage;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UIButton *playBtn;
@property (nonatomic, strong)UILabel *dateLab;
@property (nonatomic, strong)UIButton *tooth;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)UIView *sepreteView;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *ageLab;
@property (nonatomic, strong)UILabel *toothLab;
@property (nonatomic, weak)id <YAMedicalVoiceViewCellDelegate> delegate;
@property (nonatomic, strong)YAMedicalModel *model;
@property (nonatomic, strong)YAAVPlayer *player;
@property (nonatomic, strong)UIButton *lastBtn;
-(CGFloat)cellHeight;
@end
