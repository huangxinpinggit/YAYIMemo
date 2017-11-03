//
//  YAAddPatienttagCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAAddTagListModel.h"
@interface YAAddPatienttagCell : UITableViewCell
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, weak)UILabel *contentLab;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, strong)YAAddTagListModel *model;
@end
