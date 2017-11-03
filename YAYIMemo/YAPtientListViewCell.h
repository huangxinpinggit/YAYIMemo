//
//  YAPtientListViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPersonModel.h"

@protocol YAPtientListViewCellDelegate <NSObject>

-(void)selectedRow:(YAPersonModel *)model;

@end

@interface YAPtientListViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)YAPersonModel *model;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, assign)BOOL isCanselected;
@property (nonatomic, weak)id<YAPtientListViewCellDelegate>delegate;
@end
