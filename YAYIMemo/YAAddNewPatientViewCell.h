//
//  YAPatientViewCell.h
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+YA.h"

#import "YAPatientDetailModel.h"

@protocol YAAddNewPatientViewCellDelegate <NSObject>
@optional
-(void)nextAction:(NSInteger)tag;
-(void)beginEdit:(NSInteger)tag;
-(void)content:(NSString *)content tag:(NSInteger)tag;
@end

@interface YAAddNewPatientViewCell : UITableViewCell<UITextFieldDelegate,YATextFieldDelegate>
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UITextField *contentText;
@property (nonatomic, strong)UILabel *hLine;
@property (nonatomic, assign)BOOL isDelete;
@property (nonatomic, strong)YAPatientDetailModel *model;
@property (nonatomic, weak)id <YAAddNewPatientViewCellDelegate> delegate;
@end
