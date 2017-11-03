//
//  AliyunOSSObject.m
//  YAYIDoctor
//
//  Created by hxp on 17/4/11.
//
//

#import "AliyunOSSObject.h"
#import <AliyunOSSiOS/OSSService.h>

#import <CommonCrypto/CommonDigest.h>

NSString * const endPoint = @"http://oss-cn-hangzhou.aliyuncs.com";
OSSClient * client;
@implementation AliyunOSSObject
+(instancetype)sharedInstance{
    static AliyunOSSObject *object = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (object == nil) {
            object = [[AliyunOSSObject alloc] init];
        }
    });
    return object;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self  initOSS];
    }
    return self;
}

-(void)initOSS{
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken *{
        
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];

        [YAHttpBase GET:OSS_GetSTS parameters:nil success:^(id responseObject, int code) {
            [tcs setResult:responseObject];
        } failure:^(NSError *error) {
            [tcs setError:error];

        }];
        
        [tcs.task waitUntilFinished];
        
        if (tcs.task.error) {
            NSLog(@"get token error: %@", tcs.task.error);
            return nil;
        }
    
        NSDictionary *data = tcs.task.result;
        
        NSDictionary *object = data[@"data"];
        OSSFederationToken * token = [OSSFederationToken new];
        token.tAccessKey = [object objectForKey:@"accessKeyId"];
        token.tSecretKey = [object objectForKey:@"accessKeySecret"];
        token.tToken = [object objectForKey:@"securityToken"];
        token.expirationTimeInGMTFormat = [object objectForKey:@"expiration"];
        return token;
        
    }];
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 3;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
}
//&tag_name=${x:tag_name}&tagid=${x:tagid}&gender=${x:gender}&age=${x:age}
-(void)uploadObjectAsyc:(NSMutableDictionary *)param imageData:(NSData *)data file:(NSString *)mobile success:(void (^)(NSString *))success fail:(void (^)(BOOL))fail{
    
   
    //NSString *url = [NSString stringWithFormat:@"%@%@",API,patient_insert_url];
    OSSPutObjectRequest *request = [OSSPutObjectRequest new];
    request.bucketName = mobile?BucketNameAvatar:BucketName;
    NSLog(@"%@",request.bucketName);
    if (mobile != nil) {
        request.objectKey = [NSString stringWithFormat:@"%@.jpg",[self MD5:mobile]];
    }else{
        NSString *str = [self MD5:[self uniqueString]];
        request.objectKey = [NSString stringWithFormat:@"%@.jpg",[self MD5:str]];
    }
    ;
    /*
    request.callbackParam = @{
                              
                              @"callbackUrl":url,
                              @"callbackBody":@"avatar=http://${bucket}.oss-cn-hangzhou.aliyuncs.com/${object}&mobile=18317893650&name=yur"
                              };
     */
//
//                              
//                              };
    //request.callbackVar = @{@"x:var":@"we"};
    //avatar=http://${bucket}.oss-cn-hangzhou.aliyuncs.com/${object}&imageInfo.format=${imageInfo.format}&name_var=${x:name}&mobile_var=${x:mobile}
    //request.callbackVar = @{@"x:var1":@"wr",@"x:var2":@"18317893650"};
    
    request.uploadingData = data;
    request.contentType = @"image/jpeg";
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * task = [client putObject:request];
    [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        if (!task.error) {
            OSSPutObjectResult *result = task.result;
            NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
            success([NSString stringWithFormat:@"http://%@.oss-cn-hangzhou.aliyuncs.com/%@",request.bucketName,request.objectKey]);
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    //[task waitUntilFinished];
    
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block NSString *avatarUrl = nil;
        OSSTask * task = [client putObject:request];
        [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
            if (!task.error) {
                OSSPutObjectResult *result = task.result;
                NSLog(@"upload object success!");
                
                NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                      result.requestId,
                      result.httpResponseHeaderFields,
                      result.serverReturnJsonString);
                avatarUrl = [NSString stringWithFormat:@"http://ya-avatar.oss-cn-hangzhou.aliyuncs.com/%@",request.objectKey];
                
            } else {
                
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        [task waitUntilFinished];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (avatarUrl) {
                success(avatarUrl);
            }else{
                fail(true);
            }
            
        });
    });
    */
    /*
    [task continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            OSSPutObjectResult *result = task.result;
            NSLog(@"upload object success!");
            
            NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
            NSString *url = [NSString stringWithFormat:@"http://yayi-avatar.oss-cn-hangzhou.aliyuncs.com/%@",request.objectKey];
            //success(url);
        } else {
            //fail(true);
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    [task waitUntilFinished];
     */
}

/*
-(void)uploadObjectAsyc{
 
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    put.bucketName = @"yayi-avatar";
    put.callbackParam = @{@"callbackUrl":@"https://app1.yayi365.cn/site/uploadFile",@"callbackBody":@"avatar=http://${bucket}.oss-cn-hangzhou.aliyuncs.com/${object}&userid=33&role=2"};
    for (int i =1; i <= 1; i++) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"23456%d",i] ofType:@"jpg"];
        NSData *data = [NSData dataWithContentsOfFile:filepath];
        
        //put.callbackParam = @{@"callbackUrl":@"https://app1.yayi365.cn/site/uploadFile",@"callbackBody":@"filename=${object}&avatar=${x:avatar}&userid＝${x:userid}&role=${x:role}&size=${size}"};
        //put.callbackVar = @{@"x:avatar":@"sdsfsddfd.jpg",@"x:userid":@"33",@"x:role":@"2"};
        put.objectKey = [NSString stringWithFormat:@"doctor2/1234567%d",i];
        put.uploadingData = data; // 直接上传NSData
        put.contentType = @"image/jpeg";
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };
        
        OSSTask * putTask = [client putObject:put];
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                
                OSSPutObjectResult *result = task.result;
                NSLog(@"upload object success!");
                
                NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                      result.requestId,
                      result.httpResponseHeaderFields,
                      result.serverReturnJsonString);
            } else {
                
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        [putTask waitUntilFinished];
        
    }
}
*/
-(void)uploadRecorderObjectAsyc:(NSMutableDictionary *)param imageData:(NSData *)data file:(NSString *)mobile success:(void(^)(NSString * url))success fail:(void(^)(BOOL fal))fail{

    OSSPutObjectRequest *request = [OSSPutObjectRequest new];
    request.bucketName = BucketName;
    request.objectKey = [NSString stringWithFormat:@"%@.wav",[self MD5:[self uniqueString]]];
    request.uploadingData = data;
    request.contentType = @"audio/x-wav";
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * task = [client putObject:request];
    [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        if (!task.error) {
            OSSPutObjectResult *result = task.result;
            NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
           success([NSString stringWithFormat:@"http://%@.oss-cn-hangzhou.aliyuncs.com/%@",request.bucketName,request.objectKey]);
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];


}
-(NSString *)signAccessObjectURL:(NSString *)bucketName objectKey:(NSString *)objectKey{
    OSSTask * task = [client presignConstrainURLWithBucketName:bucketName
    withObjectKey:objectKey withExpirationInterval: 30 * 60];
    if (!task.error) {
        
        NSLog(@"%@",task.result);
        return task.result;
    }else {
        NSLog(@"error: %@", task.error);
    }
    return nil;
    
}


-(NSString *)publicObjectURL:(NSString *)bucketName objectKey:(NSString *)objectKey{
    OSSTask * task = [client presignPublicURLWithBucketName:bucketName withObjectKey:objectKey];
    if (!task.error) {
        NSLog(@"%@",task.result);
        return task.result;
    } else {
        NSLog(@"sign url error: %@", task.error);
    }
    return nil;
}

-(void)filecache:(NSString *)filename data:(NSData *)data{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
   
    
    NSString *toPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"PDF/%@",filename]];
    
    
    
    if (![fileManager fileExistsAtPath:toPath]) {
        
        NSLog(@"document--%@",toPath);
        NSString *pdfDir = [documentDirectory stringByAppendingPathComponent:@"PDF"];
        [fileManager createDirectoryAtPath:[documentDirectory stringByAppendingPathComponent:@"PDF"] withIntermediateDirectories:YES attributes:nil error:nil];
        
      BOOL success =  [fileManager createFileAtPath:[pdfDir stringByAppendingPathComponent:filename] contents:data attributes:nil];
        if (success) {
            
            NSLog(@"success");
        }else{
            NSLog(@"fail");
        }
        
        //[data writeToFile:toPath atomically:NO];
        if (error) {
            NSLog(@"copy error--%@",error.description);
        }
        
    }
}

-(NSString *)bucketName:(NSString *)ossurl{
    
    NSInteger location = [ossurl rangeOfString:@".oss-cn-"].location;
    NSInteger location1 = [ossurl rangeOfString:@"://"].location;
    NSString *buckname = [ossurl substringWithRange:NSMakeRange(location1+3, location -location1 - 3)];
    NSLog(@"%ld ----  %ld ---  %@",location,location1,buckname);
    return buckname;
}

-(NSString *)objectKey:(NSString *)ossurl{
    NSLog(@"%@",[ossurl lastPathComponent]);
    return [ossurl lastPathComponent];
}




- (NSString *)MD5:(NSString *)mdStr
{
    const char *original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
// 唯一字符串
-(NSString *)uniqueString{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    NSString *uniqueId = (__bridge NSString *)uuidStringRef;
    return uniqueId;
}
@end
