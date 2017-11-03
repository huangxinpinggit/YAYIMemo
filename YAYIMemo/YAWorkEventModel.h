//
//  YAWorkEventModel.h
//  YAYIMemo
//
//  Created by hxp on 17/9/18.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAWorkEventModel : NSObject
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *items;
@property (nonatomic, assign)NSInteger repetition;
@property (nonatomic, strong)NSString *patientid;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *worktime;
@property (nonatomic, strong)NSString *patientname;
@property (nonatomic, strong)NSString *month;
@end
