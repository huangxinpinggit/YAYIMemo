//
//  YARegisterCardView.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/23.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YSLCardView.h"

@protocol YARegisterCardViewDelegate <NSObject>

-(void)registerPost:(NSString *)name password:(NSString *)password verify:(NSString *)verify  codeStr:(NSString *)code;

@end

@interface YARegisterCardView : YSLCardView<UITextFieldDelegate>
@property (nonatomic, weak)UIImageView *registerBackView;
@property (nonatomic, weak)UIImageView *avater;
@property (nonatomic, weak)UITextField *mobileText;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UITextField *verifyText;
@property (nonatomic, weak)UIButton *verifyBtn;
@property (nonatomic, weak)UIButton *registerBtn;
@property (nonatomic, weak)id <YARegisterCardViewDelegate> delegate;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger s;
@property (nonatomic, strong)NSString *codeStr;
@end
