//
//  UIViewController+XLSlideMenu.m
//  YAYIMemo
//
//  Created by MR.H on 2017/10/7.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "UIViewController+XLSlideMenu.h"
#import "XLSlideMenu.h"
@implementation UIViewController (XLSlideMenu)
- (XLSlideMenu *)xl_sldeMenu {
    UIViewController *sldeMenu = self.parentViewController;
    while (sldeMenu) {
        if ([sldeMenu isKindOfClass:[XLSlideMenu class]]) {
            return (XLSlideMenu *)sldeMenu;
        } else if (sldeMenu.parentViewController && sldeMenu.parentViewController != sldeMenu) {
            sldeMenu = sldeMenu.parentViewController;
        } else {
            sldeMenu = nil;
        }
    }
    return nil;
}
@end
