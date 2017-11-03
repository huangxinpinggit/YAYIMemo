//
//  YASelectedPatienCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/30.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPersonModel.h"

@protocol  YASelectedPatienCellDelegate <NSObject>

-(void)selectedIndexRow:(YAPersonModel *)model;

@end

@interface YASelectedPatienCell : UITableViewCell
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)YAPersonModel *model;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, weak)id <YASelectedPatienCellDelegate>delegate;
@end
