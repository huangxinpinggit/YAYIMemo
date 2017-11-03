//
//  UIImage+VR.h
//  VRWeibo
//
//  Created by h3c-hp on 15/12/21.
//  Copyright © 2015年 h3c-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    YABabyTeeth,
    YAPermanentTeeth,
}YATEECHTYPE;
@interface UIImage (VR)

+ (UIImage *)imageWithColor:(UIColor*)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;
+ (UIImage *)createImageWithColor:(UIColor *)color;
@end
