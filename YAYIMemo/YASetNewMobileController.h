//
//  YASetNewMobileController.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnRefershedOperation)();
@interface YASetNewMobileController : UIViewController
@property (nonatomic, strong)NSString *oldMobile;
@property (nonatomic, copy)ReturnRefershedOperation refreshedOperation;
@end
