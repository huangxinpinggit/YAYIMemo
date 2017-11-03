//
//  NSString+YA.m
//  YAYIMemo
//
//  Created by hxp on 17/9/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "NSString+YA.h"

@implementation NSString (YA)
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width,MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}


+(void)showInfoWithStatus:(NSString *)message{
     [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
     [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
     [SVProgressHUD setBackgroundColor:YAColor(@"#424242")];
     [SVProgressHUD showInfoWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
+ (void)showHud{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.bezelView.color= YAColor(@"#000000");
    hud.contentColor = [UIColor whiteColor];
    
}
+ (void)hidHud{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}
+(void)showHud:(NSString *)content{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = content;
    hud.label.font = YAFont(12);
    hud.label.numberOfLines =0;
    hud.margin = 8;
    hud.bezelView.color= YAColor(@"#000000");
    hud.label.textColor = YAColor(@"#ffffff");
    [hud hideAnimated:YES afterDelay:1];
    [hud removeFromSuperViewOnHide];
}

+(NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return @"请输入有效的手机号";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入有效的手机号";
        }
    }
    return nil;
}

@end
