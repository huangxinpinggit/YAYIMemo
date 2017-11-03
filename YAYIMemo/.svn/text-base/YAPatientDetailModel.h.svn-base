//
//  YAPatientDetailModel.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAPatientInfoDetailModel;
@class YAPatientInfoPatientTagModel;
@interface YAPatientDetailModel : NSObject
@property (nonatomic, strong)YAPatientInfoDetailModel *patient;
@property (nonatomic, strong)NSArray *patientTag;
@property (nonatomic, assign)NSInteger recentItem;
@property (nonatomic, strong)NSArray *caseTag;
@end

@interface YAPatientInfoDetailModel : NSObject
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, assign)NSInteger gender;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *spell;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *wx;
@property (nonatomic, strong)NSString *avatar;
@end

@interface YAPatientInfoPatientTagModel : NSObject
@property (nonatomic, strong)NSString *patientid;
@property (nonatomic, strong)NSString *tagName;
@property (nonatomic, strong)NSString *tagid;
// 手动输入的标签
@property (nonatomic, assign)BOOL isInput;
//  选中的标签
@property (nonatomic,assign)BOOL  selected;
// 要删除的标签
@property (nonatomic, assign)BOOL deleted;
@end
