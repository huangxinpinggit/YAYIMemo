//
//  YAItemOfdayCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAItemModel.h"
@interface YAItemOfdayCell : UICollectionViewCell
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UILabel *evetnLab;
@property (nonatomic, strong)UIColor *textNormalColor;
@property (nonatomic, strong)UIColor *beyondColor;
@property (nonatomic, strong)UIColor *textLightColor;
@property (nonatomic, strong)UIColor *eventNormalColor;
@property (nonatomic, strong)UIColor *eventLightColor;
@property (nonatomic,strong)YAItemModel *model;
@property (nonatomic, weak)UIView *titleView;
@property (nonatomic, assign)BOOL iSSelected;
@end
