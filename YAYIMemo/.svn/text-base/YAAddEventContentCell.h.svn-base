//
//  YAAddEventContentCell.h
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YAAddEventContentCellDelegate <NSObject>

-(void)eventcontent:(NSString *)str;

@end

@interface YAAddEventContentCell : UITableViewCell<UITextViewDelegate>
@property (nonatomic, weak)UITextView *textView;
@property (nonatomic, weak)UIButton *button;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UILabel *tipLab;
@property (nonatomic, weak)id <YAAddEventContentCellDelegate>delegate;
@end
