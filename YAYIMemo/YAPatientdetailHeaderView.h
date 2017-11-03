//
//  YAPatientdetailHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPatientDetailTagview.h"

@protocol YAPatientdetailHeaderViewDelegate <NSObject>

-(void)selectedTags:(NSString*)tagsid tagAry:(NSArray *)ary;

@end

@interface YAPatientdetailHeaderView : UITableViewHeaderFooterView<YAPatientDetailTagviewDelegate>
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)YAPatientDetailTagview  *tagView;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UILabel *detailtitleLab;
@property (nonatomic, weak)id < YAPatientdetailHeaderViewDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *tagArray;
@end
