//
//  YACopyLabel.m
//  YAYIMemo
//
//  Created by MR.H on 2017/10/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACopyLabel.h"
#define UIColorRGB(x,y,z,a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]
@implementation YACopyLabel

-(BOOL)canBecomeFirstResponder {
    
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(newFunc)) {
        return YES;
    }
    return NO;
}

//针对于响应方法的实现
-(void)copy:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}

//绑定事件
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self attachTapHandler];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIMenuControllerWillHideMenuNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
           // [UIMenuController sharedMenuController].menuVisible = false;
            self.backgroundColor = [UIColor clearColor];
        }];
    }
    return self;
}


-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"111");
        return;
    }else if (recognizer.state == UIGestureRecognizerStateBegan){
        NSLog(@"222");
        [self becomeFirstResponder];
        self.backgroundColor = UIColorRGB(236, 236, 236, 1.0);
        UIMenuItem * item = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(newFunc)];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [UIMenuController sharedMenuController].menuItems = @[item];
        [UIMenuController sharedMenuController].menuVisible = YES;
    }
}

-(void)newFunc{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

@end
