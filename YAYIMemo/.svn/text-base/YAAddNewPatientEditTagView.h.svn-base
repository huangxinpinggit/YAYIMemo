//
//  YAAddNewPatientEditTagView.h
//  YAYIMemo
//
//  Created by hxp on 17/8/29.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPatientDetailModel.h"

typedef void(^YAUpadetLayout)(CGFloat height);
typedef void(^YAUpadetData)(YAPatientInfoPatientTagModel  *model);
@protocol  YAAddNewPatientEditTagViewDelegate <NSObject>
@optional
-(void)beginEdtitingText:(BOOL)isEditting;
-(void)endEdittingText:(BOOL)isEditEnd;
-(void)datasources:(NSMutableArray *)ary;
@end

@interface YAAddNewPatientEditTagView : UIView<UITextFieldDelegate>
//  标签数组
@property (nonatomic, strong)NSMutableArray *dataAry;

//  标签数组
@property (nonatomic, strong)NSMutableArray *dataLabAry;
//  标签字体大小
@property (nonatomic, assign)CGFloat fontSize;

// 左边距
@property (nonatomic, assign)CGFloat leftMargin;

// 上边距
@property (nonatomic, assign)CGFloat topMargin;

// 标签 之间的左右边距
@property (nonatomic, assign)CGFloat leftMarg;

// 标签 之间的上下边距
@property (nonatomic, assign)CGFloat topMarg;

// 标签字体
@property (nonatomic, strong)UIFont *font;

// 标签的字体颜色
@property (nonatomic, strong)UIColor *fontColor;

// 标签的边框颜色
@property (nonatomic, strong)UIColor *borderColor;

//  标签的圆角
@property (nonatomic, assign)CGFloat cordius;

//编辑输入框
@property (nonatomic, strong)UITextField *editText;

@property (nonatomic, strong)YAPatientInfoPatientTagModel  *model;
@property (nonatomic, copy)YAUpadetLayout updateLayout;
@property (nonatomic, copy)YAUpadetData updatedata;
@property (nonatomic, weak)id <YAAddNewPatientEditTagViewDelegate> delegate;

@end
