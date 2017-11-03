//
//  YASelectPatientController.h
//  YAYIMemo
//
//  Created by hxp on 17/8/30.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnRefreshedRow)();
typedef void(^SelectedPatientBlock)(NSString *patineid,NSString *name);
@interface YASelectPatientController : UIViewController
@property (nonatomic, strong)NSString *caseid;
@property (nonatomic, copy)ReturnRefreshedRow refreshedRow;
@property (nonatomic, copy)SelectedPatientBlock selectedPatientBlock;
@property (nonatomic,assign)BOOL isPresent;
@end
