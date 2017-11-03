//
//  YAAddPatienttagHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  YAAddPatienttagHeaderViewDelegate <NSObject>

-(void)openAction;

@end

@interface YAAddPatienttagHeaderView : UITableViewHeaderFooterView<UITextFieldDelegate>
@property (nonatomic, weak)UITextField *textfield;
@property (nonatomic, weak)UIView *backView;
@property (nonatomic, weak)id <YAAddPatienttagHeaderViewDelegate> delegate;
@end
