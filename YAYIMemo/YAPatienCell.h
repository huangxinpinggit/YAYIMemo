//
//  YAPatienCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPersonModel.h"
@interface YAPatienCell : UITableViewCell
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)YAPersonModel *model;

@end
