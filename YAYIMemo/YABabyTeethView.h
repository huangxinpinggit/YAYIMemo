//
//  YABabyTeethView.h
//  YAYIMemo
//
//  Created by hxp on 17/8/31.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YATeethModel.h"

@protocol YABabyTeethViewDelegate <NSObject>

-(void)teeth:(NSArray *)teeth type:(YATEECHTYPE)type;

@end

@interface YABabyTeethView : UIView
// maxillary  上颌
@property (nonatomic, strong)UIButton *maxillaryBtn;
// Mandible 下颌
@property (nonatomic, strong)UIButton *mandibleBtn;
// full  全口
@property (nonatomic, strong)UIButton *fullBtn;

@property (nonatomic, strong)NSMutableArray *maxdataArray;
@property (nonatomic, strong)NSMutableArray *mandataArray;
@property (nonatomic, strong)NSMutableArray *fulldataArray;

@property (nonatomic, strong)UIButton *lastButn;
@property (nonatomic, strong)NSArray *dataAry;
@property (nonatomic, assign)YATEECHTYPE type;
@property (nonatomic, weak)id <YABabyTeethViewDelegate>delegate;
@property (nonatomic, strong)NSMutableArray *teethArray;
@end
