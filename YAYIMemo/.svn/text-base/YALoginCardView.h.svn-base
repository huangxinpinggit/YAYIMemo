//
//  YACarView.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/23.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YSLCardView.h"

@protocol YALoginCardViewDelegate <NSObject>

-(void)loginPost:(NSString *)name password:(NSString *)password;
-(void)resetPassword;
@end

@interface YALoginCardView : YSLCardView<UITextFieldDelegate>
@property (nonatomic, strong)UIImageView *avater;
@property (nonatomic, weak)UITextField *mobileText;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UIImageView *backgroundView;
@property (nonatomic, weak)id <YALoginCardViewDelegate>delegate;
@end
