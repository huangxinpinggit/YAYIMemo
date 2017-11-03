//
//  YAMedicalModel.m
//  YAYIMemo
//
//  Created by hxp on 17/8/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMedicalModel.h"
#import <AVFoundation/AVFoundation.h>
@implementation YAMedicalModel


-(NSArray*)tagList
{
    NSMutableArray *ary = [NSMutableArray array];
    for (NSDictionary *dic in _tagList) {
        YATagsModel *model = [YATagsModel new];
        [model setValuesForKeysWithDictionary:dic];
        [ary addObject:model];
    }
    [self tagviewHH];
    return ary;
}
-(NSString *)createtime
{
    NSInteger  stemp = [_createtime integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stemp];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd";
    NSString *formateStr = [formater stringFromDate:date];
    return formateStr;
}
-(CGFloat)tagviewHH
{
    CGFloat rowWidth= 0;
    CGFloat topMarg = 4;
    NSInteger rowCount = 0;
    CGFloat _tagViewH = 0;
    UIImage *image = [UIImage imageNamed:@"more"];
    CGFloat W =  SCREEN_W - 84*YAYIScreenScale - image.size.width - 30*YAYIScreenScale;
    for (int i = 0; i< _tagList.count; i++) {
        NSDictionary *dic = _tagList[i];
        YATagsModel *model = [YATagsModel new];
        [model setValuesForKeysWithDictionary:dic];
        CGFloat itemW = [self getTagSize:model.tagname font:YAFont(15)].width+14;
        rowWidth = rowWidth+itemW+1;
        if (rowWidth - W >10) {
            rowCount++;
            rowWidth = 0;
            _tagViewH = rowCount*(25*YAYIScreenScale+topMarg);
           
            rowWidth = itemW +1;
        }
        
    }
    return _tagViewH;
}
-(NSString *)avatar
{
    return [NSString stringWithFormat:@"%@%@",_avatar,@"?x-oss-process=image/resize,m_fixed,h_40,w_40"];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName font:(UIFont *)font{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25*YAYIScreenScale) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


-(NSString *)voicetime
{
   
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AVURLAsset*audioAsset=[AVURLAsset URLAssetWithURL:[NSURL URLWithString:_info] options:opts];
        CMTime audioDuration=audioAsset.duration;
        NSInteger second= 0;
        second = ceil(CMTimeGetSeconds(audioDuration));
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //回调或者说是通知主线程刷新，
            if (second <10) {
                _voicetime =  [NSString stringWithFormat:@"00:0%ld",second];
            }else if (second <60){
                _voicetime = [NSString stringWithFormat:@"00:%ld",second];
            }else if (second >60 && second <600){
                NSInteger m = second /60;
                NSInteger n = second %60;
                if (n <10) {
                    _voicetime = [NSString stringWithFormat:@"0%ld:0%ld",m,n];
                }else if (n<60){
                    _voicetime = [NSString stringWithFormat:@"0%ld:%ld",m,n];
                }
            }else{
                NSInteger m = second /60;
                NSInteger n = second %60;
                if (n <10) {
                    _voicetime = [NSString stringWithFormat:@"%ld:0%ld",m,n];
                }else if (n<60){
                    _voicetime = [NSString stringWithFormat:@"%ld:%ld",m,n];
                }
            }
        });
        
    });
    
    
    return _voicetime;
}
-(NSString *)tooth
{
    NSArray *toothAry = [_tooth componentsSeparatedByString:@","];
    NSMutableString *mString = [NSMutableString string];
    for (int i = 0; i< toothAry.count; i++) {
        
        
        if (i > 2) {
            [mString appendString:@"..."];
            break;
        }else{
            [mString appendString:toothAry[i]];
        }
        if (![toothAry[i] isEqualToString:[toothAry lastObject]]) {
            [mString appendString:@","];
        }
        
    
    }
    return mString;
}
-(NSString *)timelong
{
    NSInteger second = [_timelong integerValue];
    if (second == 0) {
        return nil;
    }
    NSString *time = nil;
    //回调或者说是通知主线程刷新，
    if (second <10) {
        time =  [NSString stringWithFormat:@"00:0%ld",second];
    }else if (second <60){
        time = [NSString stringWithFormat:@"00:%ld",second];
    }else if (second >60 && second <600){
        NSInteger m = second /60;
        NSInteger n = second %60;
        if (n <10) {
            time = [NSString stringWithFormat:@"0%ld:0%ld",m,n];
        }else if (n<60){
            time = [NSString stringWithFormat:@"0%ld:%ld",m,n];
        }
    }else{
        NSInteger m = second /60;
        NSInteger n = second %60;
        if (n <10) {
            time = [NSString stringWithFormat:@"%ld:0%ld",m,n];
        }else if (n<60){
            time = [NSString stringWithFormat:@"%ld:%ld",m,n];
        }
    }
    
    return time;
}
@end

