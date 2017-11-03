//
//  YAOneImageViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"
#import "YAHomeBaseCell.h"
@protocol YAOneImageViewCellDelegate <NSObject>

-(void)addTagAction:(YAMedicalModel *)model;
@end

@interface YAOneImageViewCell : YAHomeBaseCell
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
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, weak)UILabel *ageLab;
@property (nonatomic, weak)UILabel *toothLab;
@property (nonatomic, weak)id <YAOneImageViewCellDelegate> delegate;
@property (nonatomic, strong)YAMedicalModel *model;


@end
