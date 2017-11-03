//
//  YAHttpBase.h
//  YAYIMemo
//
//  Created by hxp on 17/8/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "YALoginViewController.h"
@interface YAHttpBase : NSObject
/**
 *  CET请求方法
 *
 *  @param URLString   请求地址
 *  @param parameters  请求参数
 *  @param success     请求成功回调
 *  @param failure     请求失败回调
 */
+(void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject, int code)) success failure:(void(^)(NSError *error))failure;

/**
 *  POST请求方法
 *
 *  @param URLString   请求地址
 *  @param parameters  请求参数
 *  @param success     请求成功回调
 *  @param failure     请求失败回调
 */
+(void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject, int code)) success failure:(void(^)(NSError *error))failure;



@end
