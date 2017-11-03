//
//  YAPersonModel.h
//  YAYIMemo
//
//  Created by hxp on 17/8/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAPersonModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *avatar;
@property (nonatomic, strong)NSString *gender;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *spell;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, assign)NSInteger session;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, assign)BOOL isSelected;
@end
