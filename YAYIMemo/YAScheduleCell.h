//
//  YAScheduleCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAWorkEventModel.h"
@interface YAScheduleCell : UITableViewCell
@property (nonatomic,weak)UILabel *timeLab;
@property (nonatomic, weak)UILabel *vLine;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, weak)UILabel *tagLab;
@property (nonatomic, weak)UILabel *setLab;
@property (nonatomic, strong)YAWorkEventModel *model;
@end
