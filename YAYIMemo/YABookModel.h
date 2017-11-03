//
//  YABookModel.h
//  YAYIMemo
//
//  Created by hxp on 17/8/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YABookModel : NSObject
@property (nonatomic, strong)NSString *phoneNumber;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *avatar;
@property (nonatomic, assign)BOOL  isExit;
@property (nonatomic, copy)NSData *imageData;
@property (nonatomic, copy)NSData *thumbnailImageData;
@end
