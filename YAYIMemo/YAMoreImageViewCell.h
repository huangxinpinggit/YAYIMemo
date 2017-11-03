//
//  YAMoreImageViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"
#import "YAHomeBaseCell.h"
@protocol YAMoreImageViewCellDelegate <NSObject>
-(void)addTagAction:(YAMedicalModel *)model;
@end

@interface YAMoreImageViewCell : YAHomeBaseCell
@property (nonatomic, weak)UIImageView *dotIcon;
@property (nonatomic, weak)UILabel *vLine;
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, weak)UIButton *moreIcon;
@property (nonatomic, weak)UIImageView *icon;
@property (nonatomic, weak)UIImageView *imageContentView;
@property (nonatomic, weak)UILabel *dateLab;
@property (nonatomic, weak)UIButton *tooth;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UIView *sepreteView;
@property (nonatomic, weak)UILabel *toothLab;
@property (nonatomic, weak)UIView *alphaView;
@property (nonatomic, weak)id <YAMoreImageViewCellDelegate> delegate;
@property (nonatomic, strong)YAMedicalModel *model;
@end
