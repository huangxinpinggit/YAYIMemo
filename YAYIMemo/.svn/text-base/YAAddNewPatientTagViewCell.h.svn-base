//
//  YAAddNewPatientTagViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAAddNewPatientEditTagView.h"

@protocol  YAAddNewPatientTagViewCellDelegate<NSObject>
@optional
-(void)beginEditTagView:(BOOL)isEditting;
-(void)endEditTagView:(BOOL)isEnd;
-(void)updateCellHeight:(CGFloat)height;
-(void)updateData:(YAPatientInfoPatientTagModel  *)model;
-(void)tagName:(NSString *)tagname tag_id:(NSString *)tagid;
@end

@interface YAAddNewPatientTagViewCell : UITableViewCell<YAAddNewPatientEditTagViewDelegate>
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)YAAddNewPatientEditTagView *tagView;
@property (nonatomic, strong)UIImageView *hLine;
@property (nonatomic, weak)id <YAAddNewPatientTagViewCellDelegate>delegate;
@end
