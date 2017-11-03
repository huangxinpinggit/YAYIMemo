//
//  YAAddPatientTagActionController.h
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnRefreshedOperationBlock)();
@interface YAAddPatientTagActionController : UIViewController
@property (nonatomic, strong)NSArray *patientArray;
@property (nonatomic, strong)NSString *tagName;
@property (nonatomic, strong)NSString *tagid;
@property (nonatomic, copy)ReturnRefreshedOperationBlock refreshedOperation;
@end
