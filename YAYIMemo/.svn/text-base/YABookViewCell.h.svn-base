//
//  YABookViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YABookModel.h"

@protocol  YABookViewCellDelegate <NSObject>

-(void)addPatient:(YABookModel *)model;

@end

@interface YABookViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *mobileLab;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, weak)id <YABookViewCellDelegate> delegate;
@property (nonatomic, strong)YABookModel *model;
@end
