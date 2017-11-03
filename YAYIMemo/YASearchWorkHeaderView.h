//
//  YASearchWorkHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/19.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAWorkEventModel.h"
@interface YASearchWorkHeaderView : UITableViewHeaderFooterView
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UILabel *topLine;
@property (nonatomic, strong)YAWorkEventModel *model;
@property (nonatomic, strong)NSString *dateString;
@end
