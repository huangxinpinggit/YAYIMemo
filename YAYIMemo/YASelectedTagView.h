//
//  YASelectedTagView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YATagsView.h"
#import "YAAddTagListModel.h"
@protocol  YASelectedTagViewDelegate <NSObject>
-(void)selectedTagName:(YAAddTagListModel *)model;
@end

@interface YASelectedTagView : UIView
//  标签数组
@property (nonatomic, strong)NSMutableArray *dataAry;

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
@property (nonatomic, strong)UIView *topView;

@property (nonatomic, weak)id <YASelectedTagViewDelegate> delegate;
@end
