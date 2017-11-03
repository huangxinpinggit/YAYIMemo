//
//  YAPersonModel.m
//  YAYIMemo
//
//  Created by hxp on 17/8/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPersonModel.h"

@implementation YAPersonModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
-(NSString *)avatar
{
    if ([_avatar containsString:@"?x-oss-process=image/resize,m_fixed,h_37,w_37"]) {
        return _avatar;
    }
    return [NSString stringWithFormat:@"%@%@",_avatar,@"?x-oss-process=image/resize,m_fixed,h_37,w_37"];
}
@end
