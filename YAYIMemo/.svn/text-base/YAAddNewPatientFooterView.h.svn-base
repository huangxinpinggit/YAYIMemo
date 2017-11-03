//
//  YAAddNewPatientFooterView.h
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAAddNewPatientTagView.h"

@protocol YAAddNewPatientFooterViewDelegate <NSObject>

-(void)selectTagName:(YAPatientInfoPatientTagModel  *)model;

@end

@interface YAAddNewPatientFooterView : UITableViewHeaderFooterView<YAAddNewPatientTagViewDelegate>
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, weak)id <YAAddNewPatientFooterViewDelegate> delegate;
@property (nonatomic, strong)YAAddNewPatientTagView *tagView;
@end
