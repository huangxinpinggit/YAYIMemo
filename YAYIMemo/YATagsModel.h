//
//  YATagsModel.h
//  YAYIMemo
//
//  Created by hxp on 17/8/23.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YATagsModel : NSObject
@property (nonatomic, assign)NSInteger tagid;
@property (nonatomic, strong)NSString *tagname;
// 手动输入的标签
@property (nonatomic, assign)BOOL isInput;
//  选中的标签
@property (nonatomic,assign)BOOL  selected;
// 要删除的标签
@property (nonatomic, assign)BOOL deleted;
@end
