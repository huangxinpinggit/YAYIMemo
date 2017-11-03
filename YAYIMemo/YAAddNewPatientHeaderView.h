//
//  YAAddNewPatientHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPatientDetailModel.h"
@protocol  YAAddNewPatientHeaderViewDelegate<NSObject>

-(void)gender:(NSString *)gender tag:(NSInteger)index;

@end

@interface YAAddNewPatientHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong)UIImageView *avatar;
@property (nonatomic, strong)UIButton *camera;
@property (nonatomic, strong)UISegmentedControl *segment;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)YAPatientDetailModel *model;
@property (nonatomic, weak)id <YAAddNewPatientHeaderViewDelegate>delegate;
@end
