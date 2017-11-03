//
//  YAAddEventRepeatHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YAAddEventRepeatHeaderView : UITableViewHeaderFooterView
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UILabel *repeatLab;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, strong)NSString *repeatStr;
@end
