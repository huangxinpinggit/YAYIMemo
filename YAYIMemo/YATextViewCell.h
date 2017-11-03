//
//  YATextViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"
#import "YAHomeBaseCell.h"
@protocol YATextViewCellDelegate <NSObject>
-(void)addTagAction:(YAMedicalModel *)model;
-(void)openModelAction:(YAMedicalModel *)model;
@end

@interface YATextViewCell : YAHomeBaseCell
@property (nonatomic, weak)UIImageView *dotIcon;
@property (nonatomic, weak)UILabel *vLine;
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, weak)UIButton *moreIcon;
@property (nonatomic, weak)UIImageView *icon;
@property (nonatomic, weak)UILabel *contentLab;
@property (nonatomic, weak)UIButton *openBtn;
@property (nonatomic, weak)UILabel *dateLab;
@property (nonatomic, weak)UIButton *tooth;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UIView *sepreteView;
@property (nonatomic, weak)UILabel *toothLab;
@property (nonatomic, weak)id <YATextViewCellDelegate> delegate;
@property (nonatomic, strong)YAMedicalModel *model;
@property (nonatomic, assign)BOOL isOpen;
@end
