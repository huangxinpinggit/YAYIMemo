//
//  YAHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YAHeaderViewDelegate  <NSObject>

-(void)updateMonth:(NSInteger)index;

@end

@interface YAHeaderView : UIView
@property (nonatomic, weak)UIImageView *mothView;
@property (nonatomic, weak)UILabel *yearLab;
@property (nonatomic, weak)UIButton *nextBtn;
@property (nonatomic, weak)UIButton *lastBtn;
@property (nonatomic, strong)UIFont *font;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic,strong)NSArray *imageAry;
@property (nonatomic, weak)id <YAHeaderViewDelegate>delegate;
-(void)updateDateWithYear:(NSInteger)year month:(NSInteger)month;
@end
