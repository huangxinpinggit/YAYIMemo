//
//  YAAddNewPatientController.h
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnRefreshedRow)();
@interface YAAddNewPatientController : UIViewController
@property (nonatomic, strong)NSString *caseid;
@property (nonatomic, copy)ReturnRefreshedRow refreshedRow;
@property (nonatomic,  strong)NSString *patientid;
@end

@interface YAAddNewPatientModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *placher;
@property (nonatomic, strong)NSString *content;
@end
