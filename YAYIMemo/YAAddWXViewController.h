//
//  YAAddWXViewController.h
//  YAYIMemo
//
//  Created by hxp on 17/9/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPatientDetailModel.h"

typedef void(^ReturnRefershedOperation)();
@interface YAAddWXViewController : UIViewController
@property (nonatomic, copy)ReturnRefershedOperation refreshedOperation;
@property (nonatomic, strong)YAPatientDetailModel *model;
@end
