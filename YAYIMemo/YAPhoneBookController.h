//
//  YAPhoneBookController.h
//  YAYIMemo
//
//  Created by hxp on 17/8/24.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ReturrefreshedBlock)();
@interface YAPhoneBookController : UIViewController
@property (nonatomic, copy)ReturrefreshedBlock refreshedBlock;
@end
