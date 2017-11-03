//
//  YAmessageViewCell.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YAMessageViewCell : UITableViewCell
@property (nonatomic, weak)UIImageView * avater;
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, weak)UILabel *timeLab;
@property (nonatomic, weak)UIView  *bgView;
@property (nonatomic, weak)UILabel *contenLab;
@property (nonatomic, weak)UILabel *hLine;
@end
