//
//  YAPersonItemCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPersonItemModel.h"
@interface YAPersonItemCell : UITableViewCell
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)YAPersonItemModel *model;
@end
