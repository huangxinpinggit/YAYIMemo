//
//  YAItemModel.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAItemModel : NSObject
@property (nonatomic, strong)NSString *day;
@property (nonatomic, strong)NSString *year;
@property (nonatomic, strong)NSString *moth;
@property (nonatomic, strong)NSDate *date;
@property (nonatomic, strong)NSDate *beyonddate;
@property (nonatomic, assign)BOOL isBeyond;
@property (nonatomic, assign)BOOL isToday;
@property (nonatomic, assign)BOOL isNext;
@property (nonatomic, assign)BOOL isEvent;
@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, assign)BOOL isDefault;
@property (nonatomic, assign)BOOL isNextMonth;
@property (nonatomic, assign)BOOL isLastMonth;

/*

 */
@end
