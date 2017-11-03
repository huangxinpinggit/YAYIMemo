//
//  AliyunOSSObject.h
//  YAYIDoctor
//
//  Created by hxp on 17/4/11.
//
//

#import <Foundation/Foundation.h>


@interface AliyunOSSObject : NSObject
+(instancetype)sharedInstance;

-(void)uploadObjectAsyc:(NSMutableDictionary *)param imageData:(NSData *)data file:(NSString *)mobile success:(void(^)(NSString * url))success fail:(void(^)(BOOL fal))fail;
-(NSString *)signAccessObjectURL:(NSString *)bucketName objectKey:(NSString *)objectKey;
-(NSString *)publicObjectURL:(NSString *)bucketName objectKey:(NSString *)objectKey;
-(void)uploadRecorderObjectAsyc:(NSMutableDictionary *)param imageData:(NSData *)data file:(NSString *)mobile success:(void(^)(NSString * url))success fail:(void(^)(BOOL fal))fail;
@end
