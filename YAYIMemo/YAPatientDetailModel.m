//
//  YAPatientDetailModel.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientDetailModel.h"

@implementation YAPatientDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
-(NSArray *)patientTag
{
    NSMutableArray *ary = [NSMutableArray array];
    for (NSDictionary *dic  in _patientTag) {
        YAPatientInfoPatientTagModel *model = [YAPatientInfoPatientTagModel new];
        [model setValuesForKeysWithDictionary:dic];
        [ary addObject:model];
    }
    return ary;
}

-(NSArray *)caseTag
{
    NSMutableArray *ary = [NSMutableArray array];
    for (NSDictionary *dic  in _caseTag) {
        YAPatientInfoPatientTagModel *model = [YAPatientInfoPatientTagModel new];
        [model setValuesForKeysWithDictionary:dic];
        [ary addObject:model];
    }
    return ary;
}

@end

@implementation  YAPatientInfoDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation YAPatientInfoPatientTagModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
