//
//  UITextField+YA.h
//  YAYIMemo
//
//  Created by hxp on 17/8/29.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  监听删除按钮
 *  object:UITextField
 */
//extern NSString * const YATextFieldDidDeleteBackwardNotification;

@protocol YATextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end


@interface UITextField (YA)
@property (weak, nonatomic) id<YATextFieldDelegate> delegate;
@end
