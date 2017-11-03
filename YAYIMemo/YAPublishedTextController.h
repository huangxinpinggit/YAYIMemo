//
//  YATextViewController.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnrefreshedOperation)(void);

@interface YAPublishedTextController : UIViewController
@property (nonatomic, copy)ReturnrefreshedOperation refreshedOperation;
@property (nonatomic, strong)NSString *userid;
@end
