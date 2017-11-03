//
//  YAMedicalImageViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//
#import "YAHomeBaseCell.h"
#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"

@protocol  YAMedicalImageViewCellDelegate <NSObject>

-(void)addTagAction:(YAMedicalModel *)model;
-(void)detailAction:(YAMedicalModel *)model;
@end

@interface YAMedicalImageViewCell : YAHomeBaseCell
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, strong)UIButton *moreIcon;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UIImageView *imageContentView;
@property (nonatomic, strong)UILabel *dateLab;
@property (nonatomic, strong)UIButton *tooth;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)UIView *sepreteView;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *ageLab;
@property (nonatomic, strong)UILabel *toothLab;
@property (nonatomic, strong)YAMedicalModel *model;
@property (nonatomic, strong)UILabel *contentLab;
@property (nonatomic, assign)BOOL isFreshed;
@property (nonatomic,weak)id <YAMedicalImageViewCellDelegate> delegate;



@end
