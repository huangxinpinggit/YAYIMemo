//
//  YAFMDBDatabases.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/19.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAFMDBDatabases.h"

@implementation YAFMDBDatabases
{
    FMDatabase *_fmdatabase;
}


+(instancetype)sharedInstance
{
    static YAFMDBDatabases *databases = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (databases == nil) {
            databases = [[YAFMDBDatabases alloc] init];
        }
    });
    return databases;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initFMDBaseObject];
    }
    return self;
}
-(void)initFMDBaseObject{
    
    //创建数据库
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docementDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [docementDirectory stringByAppendingPathComponent:@"person.db"];
    _fmdatabase = [FMDatabase databaseWithPath:dbPath];
    
    //创建表
    
    if (![_fmdatabase open]) {
        NSLog(@"Could not open db.");
        return;
    }else{
        BOOL result = [_fmdatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY ,patientid text NOT NULL,name text NOT NULL,avatar text ,mobile text NOT NULL,gender text ,userid text);"];
        if (result)
        {
            NSLog(@"创建表成功");
        }else{
            [_fmdatabase lastErrorMessage];
        }
    }
    
}

-(NSArray *)queryAllDatabases{
    if ([_fmdatabase open]) {
        NSMutableArray *dataAry = [NSMutableArray array];
        FMResultSet *set = [_fmdatabase executeQuery:@"select * from t_person"];
        while ([set next]) {
            YAPersonModel *model = [YAPersonModel new];
            model.id = [set objectForColumnName:@"patientid"];
            model.name = [set objectForColumnName:@"name"];
            model.avatar = [set objectForColumnName:@"avatar"];
            model.mobile = [set objectForKeyedSubscript:@"mobile"];
            model.gender = [set objectForColumnName:@"gender"];
            model.userid = [set objectForColumnName:@"userid"];
            [dataAry addObject:model];
        }
        [_fmdatabase close];
        return dataAry;
        
    }else{
        [_fmdatabase open];
        return nil;
    }
}
-(BOOL)queryModeId:(YAPersonModel *)model
{
    BOOL isExist = NO;
    if ([_fmdatabase open]) {
        
        FMResultSet *set = [_fmdatabase executeQuery:@"select * from t_person where patientid = (?)",model.id];
        if ([set next]) {
            isExist = true;
        }
        [_fmdatabase close];
        return isExist;
    }else{
        [_fmdatabase open];
        return isExist;
    }
}
-(void)updateDatabases:(YAPersonModel *)model
{
    BOOL isExist = NO;
    if ([self queryModeId:model]) {
        return;
    }
    if ([_fmdatabase open]) {
        isExist = [_fmdatabase executeUpdate:@"INSERT INTO t_person (patientid, name,avatar,mobile,gender,userid) VALUES (?,?,?,?,?,?);",model.id,model.name,model.avatar,model.mobile,model.gender,model.userid];
        if (isExist) {
            NSLog(@"insert a item success!");
            [_fmdatabase close];
        }else{
            NSLog(@"%@",[_fmdatabase lastErrorMessage]);
        }
    }
}
-(void)deleteDownloaid:(NSString *)patientid{
    if ([_fmdatabase open]) {
        
        BOOL isExist = NO;
        isExist = [_fmdatabase executeUpdate:@"delete from t_person where patientid = (?) ;",patientid];
        
        if (!isExist) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
        [_fmdatabase close];
        
        
    }
}

@end
