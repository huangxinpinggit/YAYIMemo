//
//  YAFMDBDatabases.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/19.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "YAPersonModel.h"
@interface YAFMDBDatabases : NSObject
+(instancetype)sharedInstance;
-(void)initFMDBaseObject;
-(NSArray *)queryAllDatabases;
-(BOOL)queryModeId:(YAPersonModel *)model;
-(void)updateDatabases:(YAPersonModel *)model;
-(void)deleteDownloaid:(NSString *)downloadid;
@end
