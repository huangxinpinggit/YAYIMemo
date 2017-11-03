//
//  YAAddTagListModel.m
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddTagListModel.h"

@implementation YAAddTagListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

-(NSArray *)patients
{
    NSMutableArray *ary = [NSMutableArray array];
    for (NSDictionary *dic in _patients) {
        YATagPatientModel *model = [YATagPatientModel new];
        
        [model setValuesForKeysWithDictionary:dic];
        [ary addObject:model];
    }
    return ary;
}
@end

@implementation YATagPatientModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
