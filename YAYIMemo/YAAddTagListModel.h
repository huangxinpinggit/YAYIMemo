//
//  YAAddTagListModel.h
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YATagPatientModel ;

@interface YAAddTagListModel : NSObject
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)NSString *tagName;
@property (nonatomic, strong)NSString *tagid;
@property (nonatomic, strong)NSArray *patients;
@property (nonatomic, assign)BOOL selected;
@end

@interface YATagPatientModel :NSObject

@property (nonatomic, strong)NSString *patientName;
@property (nonatomic, strong)NSString *patientid;
@property (nonatomic, strong)NSString *spell;

@end
