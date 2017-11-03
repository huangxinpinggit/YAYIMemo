//
//  YAAddPatienActionHeaderView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YAAddPatienActionHeaderViewDelegate <NSObject>

-(void)addAction;
-(void)tagName:(NSString *)tagName;
@end

@interface YAAddPatienActionHeaderView : UITableViewHeaderFooterView<UITextFieldDelegate>

@property (nonatomic, weak)UITextField *textfield;
@property (nonatomic, weak)UIView *backView;
@property (nonatomic, weak)UILabel *hLineView;
@property (nonatomic, weak)UIView *tagView;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UIButton *addBtn1;
@property (nonatomic, weak)id<YAAddPatienActionHeaderViewDelegate>delegate;
@end
