//
//  YACameraImageController.h
//  YAYIMemo
//
//  Created by hxp on 17/9/11.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCameraOperation)(void);
typedef void(^ReturnrefreshedOperation)(void);
@interface YACameraImageController : UIViewController
//+ (instancetype)new  NS_UNAVAILABLE;
//
//- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
@property (nonatomic, copy)ReturnCameraOperation camareOperation;
@property (nonatomic, copy)ReturnrefreshedOperation refreshedOperation;
@property (nonatomic, strong)NSString *userid;
@end
