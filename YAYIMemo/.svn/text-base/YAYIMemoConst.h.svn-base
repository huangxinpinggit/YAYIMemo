//
//  YAYIMemoConst.h
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#ifndef YAYIMemoConst_h
#define YAYIMemoConst_h



#ifdef DEBUG
#define YA_LOG(...) //NSLog(__VA_ARGS__)
#else
#define YA_LOG(...)
#endif
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height==2436 : NO)
//导航栏高度
#define  YANavBarHeight  isIPhoneX ? 88 : 64
//底部Tabbar 高度
#define YATabBarHeight  isIPhoneX ?  83 : 49
//状态栏高度
#define  YAStatusBarHeight  isIPhoneX ? 44 : 20

#define YA_ALPHA_COLOR(r,g,b,c) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:c]
#define YA_COLOR(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]


#define YAYIScreenScale (SCREEN_W / 375.0)
#define YAYIFontWithScale(font) ((font)*(1 + YAYIScreenScale)*0.5)


#define YAYILineColor  YA_COLOR(239,240,240)
#define YAYICellTitleColor  YA_COLOR(0x25, 0x25, 0x25)
#define YAYICellLineColor   YA_COLOR(239,240,240)
#define YAYIBackgroundColor YA_COLOR(250,250,250)

#define YALoginCookieKey @"YALoginCookieKey"
#define YALoginCookieValue [[NSUserDefaults standardUserDefaults] valueForKey:YALoginCookieKey]
//灰色，
#define YAGray_color  [UIColor colorWithHexString:@"#8a8a8a"];
// 黑色 ，设置name，title的颜色
#define YABlack_color [UIColor colorWithHexString:@"#424242"];
// 灰色  ,设置线的颜色
#define YALine_color [UIColor colorWithHexString:@"#e7e7e7"];
#define YAFont(s)   [UIFont systemFontOfSize:YAYIFontWithScale(s)]
#define YAColor(s)  [UIColor colorWithHexString:s]
#endif
