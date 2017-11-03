//
//  YALoginViewController.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginSuccessOperation)(void);

@interface YALoginViewController : UIViewController
@property (nonatomic, copy)LoginSuccessOperation loginSuccessOperation;
@end
