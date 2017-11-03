//
//  YAVideoViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"
#import "YAAVPlayer.h"
#import "YAHomeBaseCell.h"
@protocol YAVideoViewCellDelegate <NSObject>
-(void)addTagAction:(YAMedicalModel *)model;
-(void)playerSound:(YAMedicalModel *)model;
@end

@interface YAVideoViewCell : YAHomeBaseCell
@property (nonatomic, weak)UIImageView *dotIcon;
@property (nonatomic, weak)UILabel *vLine;
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, weak)UIButton *moreIcon;
@property (nonatomic, weak)UIImageView *icon;
@property (nonatomic, weak)UIButton *voiceImage;
@property (nonatomic, weak)UILabel *dateLab;
@property (nonatomic, weak)UIButton *tooth;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UIView *sepreteView;
@property (nonatomic, weak)UILabel *toothLab;
@property (nonatomic, weak)UILabel *timeLab;
@property (nonatomic, strong)YAAVPlayer *player;
@property (nonatomic, weak)id <YAVideoViewCellDelegate> delegate;
@property (nonatomic, strong)YAMedicalModel *model;
@end
