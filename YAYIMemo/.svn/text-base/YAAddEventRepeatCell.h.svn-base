//
//  YAAddEventRepeatCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/7.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YAAddEventRepeatCellDelegate <NSObject>

-(void)repeatEvent:(NSString *)repeat isSelected:(BOOL)isSelected;

@end

@interface YAAddEventRepeatCell : UITableViewCell
@property (nonatomic, weak)UIButton *button;
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UIButton *lastBtn;
//@property (nonatomic, assign)BOOL isSelectedRow;
@property (nonatomic, weak)id <YAAddEventRepeatCellDelegate>delegate;
@end
