//
//  YAYINavigationController.h
//  YAYIDoctor
//
//  Created by hxp on 16/4/28.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OUNavigationController.h"
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface YAYINavigationController : UINavigationController
//-(void)setitile:(NSString *)title;
@end
