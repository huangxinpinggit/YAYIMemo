//
//  YAYIActionSheet.h
//  yayi
//
//  Created by Veer on 16/4/12.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YAYIActionSheet;
@protocol YAYIActionSheetDelegate <NSObject>
@optional
- (void)actionSheet:(YAYIActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index;

@end

@interface YAYIActionSheet : UIView

// 最后一个按钮标题，如果没有则不显示
@property (nonatomic, copy) NSString *lastBtnTitle;
@property (nonatomic, strong) id<YAYIActionSheetDelegate> delegate;

- (instancetype)initWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles lastBtnTitle:(NSString *)lastBtnTitle;

- (instancetype)initWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles;
+ (instancetype)showActionSheetWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles;
- (void)show;

@end

@interface UIColor (YAYIActionSheet)
+ (instancetype)lightBlueColor;
+ (instancetype)randomColor;
+ (instancetype)colorWithHex:(NSUInteger)hexColor;
@end