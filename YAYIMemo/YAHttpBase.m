//
//  YAHttpBase.m
//  YAYIMemo
//
//  Created by hxp on 17/8/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAHttpBase.h"

@implementation YAHttpBase
+(void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id, int))success failure:(void (^)(NSError *))failure{
    
    
    AFHTTPSessionManager *manager = [YAHttpBase sharedHTTPSession];
    manager.responseSerializer.acceptableContentTypes = [[NSSet  alloc] initWithObjects:@"application/json", nil];
    AFJSONResponseSerializer *json =[AFJSONResponseSerializer serializer];
    json.removesKeysWithNullValues = YES;
    manager.responseSerializer = json;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    // 设置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API,URLString];
    
    [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject != nil) {
           NSString *status = responseObject[@"status"];
            if ([status isEqualToString:@"success"]) {
                success(responseObject ,200);
            }else if([status isEqualToString:@"redirect"]){
                NSString *message = responseObject[@"message"];
                NSLog(@"%@",message);
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate.window.rootViewController presentViewController:[[YALoginViewController alloc] init] animated:false completion:nil];
            }
           
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       
        if (error.code == -1009) {  // 网络连接错误
           [NSString showHud:@"网络连接出现异常，请检查网络设置"];

        }else if (error.code == -1001){ // 链接超时
            [SVProgressHUD showInfoWithStatus:@"请求超时，稍后重试"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            //[SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else{
            //[SVProgressHUD dismiss];
        }
        failure(error);
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}
+(void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id, int))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [YAHttpBase sharedHTTPSession];
    manager.responseSerializer.acceptableContentTypes = [[NSSet  alloc] initWithObjects:@"application/json", nil];
    AFJSONResponseSerializer *json =[AFJSONResponseSerializer serializer];
    json.removesKeysWithNullValues = YES;
    manager.responseSerializer = json;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    // 设置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API, URLString];
    
    //[NSString showHud];
    
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[NSString hidHud];
        if (responseObject != nil) {
            NSString *status = responseObject[@"status"];
            NSString *message = responseObject[@"message"];
           
            if ([status isEqualToString:@"error"]) {
                [SVProgressHUD showErrorWithStatus:message];
                NSLog(@"%@",message);
            }else if([status isEqualToString:@"success"]){
                success(responseObject ,200);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else if ([status isEqualToString:@"redirect"]){
                [NSString showHud:@"登录状态已经过期，请重新登录"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //task.
        
        [NSString hidHud];
        if (error.code == -1009) {
            [NSString showHud:@"网络连接出现异常，请检查网络设置"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        }else if (error.code == -1001){ // 链接超时
             [SVProgressHUD showInfoWithStatus:@"请求超时，稍后重试"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
           // [SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else{
            
            if (error.userInfo[@"com.alamofire.serialization.response.error.data"]) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
                NSString *message = dict[@"message"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
                [SVProgressHUD setBackgroundColor:YAColor(@"#424242")];
                [SVProgressHUD showErrorWithStatus:message];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
               
                failure(error);
            }else{

            }
            failure(error);
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

static AFHTTPSessionManager *manager;
+ (AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}

@end
