//
//  YATextView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YATextView : UITextView
@property (copy, nonatomic, nullable) IBInspectable NSString *xx_placeholder;

@property (strong, nonatomic, nullable) IBInspectable UIColor *xx_placeholderColor;

@property (strong, nonatomic, nullable) UIFont *xx_placeholderFont;

@end
