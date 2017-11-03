//
//  YAMedicalTextViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"
#import "YAHomeBaseCell.h"
#import "YACopyLabel.h"
@protocol  YAMedicalTextViewCellDelegate <NSObject>

-(void)addTagAction:(YAMedicalModel *)model;
-(void)detailAction:(YAMedicalModel *)model;
-(void)openModelAction:(YAMedicalModel *)model;
@end

@interface YAMedicalTextViewCell : YAHomeBaseCell
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, strong)UIButton *moreIcon;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)YACopyLabel *contentLab;
@property (nonatomic, strong)UIButton *openBtn;
@property (nonatomic, strong)UILabel *dateLab;
@property (nonatomic, strong)UIButton *tooth;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)UIView *sepreteView;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *ageLab;
@property (nonatomic, strong)UILabel *toothLab;
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, weak)id <YAMedicalTextViewCellDelegate> delegate;
@property (nonatomic, strong)YAMedicalModel *model;

-(CGFloat)cellHeight;
@end
