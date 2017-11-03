//
//  UITextField+YA.m
//  YAYIMemo
//
//  Created by hxp on 17/8/29.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "UITextField+YA.h"
#import <objc/runtime.h>
//NSString *const YATextFieldDidDeleteBackwardNotification = @"com.achego.textfield.did.notification";

@implementation UITextField (YA)
+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(wj_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)wj_deleteBackward {
    [self wj_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <YATextFieldDelegate> delegate  = (id<YATextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YATextFieldDidDeleteBackwardNotification" object:self];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
