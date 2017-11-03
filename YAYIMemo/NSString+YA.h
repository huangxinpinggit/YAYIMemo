//
//  NSString+YA.h
//  YAYIMemo
//
//  Created by hxp on 17/9/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YA)
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;

+ (NSString *)valiMobile:(NSString *)mobile;
+ (void)showInfoWithStatus:(NSString *)message;
+ (void)showHud;
+ (void)hidHud;
+(void)showHud:(NSString *)content;
@end
