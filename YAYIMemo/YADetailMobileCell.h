//
//  YADetailMobileCell.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPatientDetailModel.h"
typedef enum : NSUInteger {
    MOBileTYPE,
    WEIXINTYPE,
} DETAILCELLTYPE;

@protocol YADetailMobileCellDelegate <NSObject>
-(void)callMobileAction:(NSString *)mobile;
-(void)sendMessageAction:(NSString *)mobile;
-(void)openWeixinAction:(NSString *)weixin;
@end

@interface YADetailMobileCell : UITableViewCell
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UILabel *conntentLab;
@property (nonatomic, weak)UIButton *mobileBtn;
@property (nonatomic, weak)UIButton *messageBtn;
@property (nonatomic, weak)UIImageView *leftView;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, strong)YAPatientDetailModel *model;
@property (nonatomic, assign)DETAILCELLTYPE type;
@property (nonatomic, weak)id <YADetailMobileCellDelegate> delegate;
@end
