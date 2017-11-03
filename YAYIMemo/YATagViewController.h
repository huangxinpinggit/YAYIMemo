//
//  YATagViewController.h
//  YAYIMemo
//
//  Created by hxp on 17/8/21.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMedicalModel.h"

typedef void(^ReturnRefreshedRow)();
@interface YATagViewController : UIViewController
@property (nonatomic, strong)NSArray *tagListAry;
@property (nonatomic, strong)NSString *caseid;
@property (nonatomic, copy)ReturnRefreshedRow refreshedRow;
@end
