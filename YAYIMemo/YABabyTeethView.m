//
//  YABabyTeethView.m
//  YAYIMemo
//
//  Created by hxp on 17/8/31.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YABabyTeethView.h"

@implementation YABabyTeethView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = YABabyTeeth;
        self.teethArray = [NSMutableArray array];
        self.teethArray = [NSMutableArray array];
        self.maxdataArray = [NSMutableArray array];
        self.mandataArray = [NSMutableArray array];
        self.fulldataArray = [NSMutableArray array];
        [self createView];
        [self leftTopView];
        [self rightTopView];
        [self leftBottomView];
        [self rightBottomView];
    }
    return self;
}
-(void)setDataAry:(NSArray *)dataAry
{
    _dataAry = dataAry;
    NSLog(@"%@",dataAry);
    [self.fulldataArray  enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSString *tooth in dataAry) {
            
            if ([tooth integerValue] == obj.tag) {
                obj.selected = YES;
            }
        }
    }];
    
}
//十字 形

-(void)createView{
    // 上
    
    UIImage *image1 = [[self GetImageWithColor:[UIColor colorWithHexString:@"#424242"] andHeight:40*YAYIScreenScale] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UILabel *topLine = [UILabel new];
    topLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1, 80*YAYIScreenScale));
    }];
    
    self.maxillaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maxillaryBtn.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    self.maxillaryBtn.tag = 1010;
    [self.maxillaryBtn setTitle:@"上颌" forState:UIControlStateNormal];
    self.maxillaryBtn.layer.borderWidth = 1*YAYIScreenScale;
    self.maxillaryBtn.layer.cornerRadius = 20*YAYIScreenScale;
    [self.maxillaryBtn setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    
    self.maxillaryBtn.clipsToBounds = YES;
    [self.maxillaryBtn setBackgroundImage:image1 forState:UIControlStateSelected];
    [self.maxillaryBtn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    [self.maxillaryBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.maxillaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.maxillaryBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(17)];
    [self addSubview:self.maxillaryBtn];
    [self.maxillaryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLine.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale, 40*YAYIScreenScale));
    }];
    
    UILabel *topmidLine = [UILabel new];
    topmidLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self addSubview:topmidLine];
    [topmidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.maxillaryBtn.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1, 44*YAYIScreenScale));
    }];
    
    // 中
    self.fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fullBtn.layer.borderWidth = 1;
    self.fullBtn.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    [self.fullBtn setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    self.fullBtn.tag = 1011;
    self.fullBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(19)];
    self.fullBtn.layer.cornerRadius = 30*YAYIScreenScale;
    [self.fullBtn setTitle:@"全口" forState:UIControlStateNormal];
    [self addSubview:self.fullBtn];
    
    self.fullBtn.clipsToBounds = YES;
    [self.fullBtn setBackgroundImage:image1 forState:UIControlStateSelected];
    [self.fullBtn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    [self.fullBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fullBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*YAYIScreenScale, 60*YAYIScreenScale));
    }];
    
    // 左
    UILabel *leftLine = [UILabel new];
    leftLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.fullBtn.mas_left);
        make.centerY.mas_equalTo(self.fullBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(124*YAYIScreenScale, 1));
    }];
    
    // 右
    UILabel *rightLine = [UILabel new];
    rightLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fullBtn.mas_right);
        make.centerY.mas_equalTo(self.fullBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(124*YAYIScreenScale, 1));
    }];
    
    // 下
    UILabel *bottomMidLine = [UILabel new];
    bottomMidLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self addSubview:bottomMidLine];
    [bottomMidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fullBtn.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1, 44*YAYIScreenScale));
    }];
    
    self.mandibleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mandibleBtn.layer.borderWidth = 1;
    self.mandibleBtn.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    self.mandibleBtn.tag = 1012;
    self.mandibleBtn.layer.cornerRadius = 20*YAYIScreenScale;
    [self.mandibleBtn setTitle:@"下颌" forState:UIControlStateNormal];
    self.mandibleBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(17)];
    [self.mandibleBtn setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    [self addSubview:self.mandibleBtn];
    
    self.mandibleBtn.clipsToBounds = YES;
    [self.mandibleBtn setBackgroundImage:image1 forState:UIControlStateSelected];
    [self.mandibleBtn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    [self.mandibleBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.mandibleBtn.layer.cornerRadius = 20*YAYIScreenScale;
    [self.mandibleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.mandibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(bottomMidLine.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(40*YAYIScreenScale,40*YAYIScreenScale ));
    }];
    
    UILabel *bottomLine = [UILabel new];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mandibleBtn.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1, 80*YAYIScreenScale));
    }];
    
    
    
    
}
// 左上 牙位
-(void)leftTopView{
    NSArray *wAry = @[@"135",@"127",@"110",@"75",@"23"];
    NSArray *hAry = @[@"22",@"76",@"121",@"159",@"175"];
    NSArray *titleAry = @[@"55",@"54",@"53",@"52",@"51"];
    CGFloat centerX = self.centerX-SCREEN_W;
    CGFloat centerY = self.centerY;
     UIImage *image1 = [[self GetImageWithColor:[UIColor colorWithHexString:@"#424242"] andHeight:40*YAYIScreenScale] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    for (int i= 0; i <5; i++) {
        CGFloat itemX = 0;
        CGFloat itemY = 0;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
        button.layer.cornerRadius = 15*YAYIScreenScale;
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(17)];
       
        CGFloat W = [wAry[i] floatValue]*YAYIScreenScale;
        CGFloat H = [hAry[i] floatValue]*YAYIScreenScale;
       
        CGFloat w = 30*YAYIScreenScale;
        CGFloat h = 30*YAYIScreenScale;
        CGFloat r = 15*YAYIScreenScale;
        itemX = centerX - W- r;
        itemY = centerY - H - r;
        button.frame = CGRectMake(itemX, itemY, w, h);
        [self  addSubview:button];
        
        [button setBackgroundImage:image1 forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.tag = [titleAry[i] integerValue];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.maxdataArray addObject:button];
        [self.fulldataArray addObject:button];
    }
}
// 右上 牙位
-(void)rightTopView{
    NSArray *wAry = @[@"135",@"127",@"110",@"75",@"23"];
    NSArray *hAry = @[@"22",@"76",@"121",@"159",@"175"];
    NSArray *titleAry = @[@"65",@"64",@"63",@"62",@"61"];
    CGFloat centerX = self.centerX-SCREEN_W;
    CGFloat centerY = self.centerY;
    UIImage *image1 = [[self GetImageWithColor:[UIColor colorWithHexString:@"#424242"] andHeight:40*YAYIScreenScale] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    for (int i= 0; i <5; i++) {
        CGFloat itemX = 0;
        CGFloat itemY = 0;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
        button.layer.cornerRadius = 15*YAYIScreenScale;
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(17)];
        
        CGFloat W = [wAry[i] floatValue]*YAYIScreenScale;
        CGFloat H = [hAry[i] floatValue]*YAYIScreenScale;
        
        CGFloat w = 30*YAYIScreenScale;
        CGFloat h = 30*YAYIScreenScale;
        CGFloat r = 15*YAYIScreenScale;
        itemX = centerX + W- r;
        itemY = centerY - H - r;
        button.frame = CGRectMake(itemX, itemY, w, h);
        [self  addSubview:button];
        
        [button setBackgroundImage:image1 forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.tag = [titleAry[i] integerValue];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.maxdataArray addObject:button];
        [self.fulldataArray addObject:button];
    }
}
// 左下 牙位
-(void)leftBottomView{
    NSArray *wAry = @[@"135",@"127",@"110",@"75",@"23"];
    NSArray *hAry = @[@"22",@"76",@"121",@"159",@"175"];
    NSArray *titleAry = @[@"85",@"84",@"83",@"82",@"81"];
    CGFloat centerX = self.centerX-SCREEN_W;
    CGFloat centerY = self.centerY;
    UIImage *image1 = [[self GetImageWithColor:[UIColor colorWithHexString:@"#424242"] andHeight:40*YAYIScreenScale] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    for (int i= 0; i <5; i++) {
        CGFloat itemX = 0;
        CGFloat itemY = 0;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
        button.layer.cornerRadius = 15*YAYIScreenScale;
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(17)];
        
        CGFloat W = [wAry[i] floatValue]*YAYIScreenScale;
        CGFloat H = [hAry[i] floatValue]*YAYIScreenScale;
        
        CGFloat w = 30*YAYIScreenScale;
        CGFloat h = 30*YAYIScreenScale;
        CGFloat r = 15*YAYIScreenScale;
        itemX = centerX - W- r;
        itemY = centerY + H - r;
        button.frame = CGRectMake(itemX, itemY, w, h);
        [self  addSubview:button];
        
        [button setBackgroundImage:image1 forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.tag = [titleAry[i] integerValue];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mandataArray addObject:button];
        [self.fulldataArray addObject:button];
    }
}
// 右下 牙位
-(void)rightBottomView{
    NSArray *wAry = @[@"135",@"127",@"110",@"75",@"23"];
    NSArray *hAry = @[@"22",@"76",@"121",@"159",@"175"];
    NSArray *titleAry = @[@"75",@"74",@"73",@"72",@"71"];
    CGFloat centerX = self.centerX-SCREEN_W;
    CGFloat centerY = self.centerY;
    UIImage *image1 = [[self GetImageWithColor:[UIColor colorWithHexString:@"#424242"] andHeight:40*YAYIScreenScale] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    for (int i= 0; i <5; i++) {
        CGFloat itemX = 0;
        CGFloat itemY = 0;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
        button.layer.cornerRadius = 15*YAYIScreenScale;
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(17)];
        
        CGFloat W = [wAry[i] floatValue]*YAYIScreenScale;
        CGFloat H = [hAry[i] floatValue]*YAYIScreenScale;
        
        CGFloat w = 30*YAYIScreenScale;
        CGFloat h = 30*YAYIScreenScale;
        CGFloat r = 15*YAYIScreenScale;
        itemX = centerX + W- r;
        itemY = centerY + H - r;
        button.frame = CGRectMake(itemX, itemY, w, h);
        [self  addSubview:button];
        
        [button setBackgroundImage:image1 forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.tag = [titleAry[i] integerValue];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mandataArray addObject:button];
        [self.fulldataArray addObject:button];
    }
}

-(void)buttonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    //sender.layer.borderWidth = sender.selected? 0: 1;
    if (sender.tag <= 65) {
        if (sender.selected==false) {
            if (self.fullBtn.selected) {
                self.fullBtn.selected = false;
                self.maxillaryBtn.selected = false;
            }else if (!self.fullBtn.selected && self.maxillaryBtn.selected){
                self.maxillaryBtn.selected = false;
            }
        }else{
            int k = 0;
            for (int i =0; i < self.fulldataArray.count; i++) {
                UIButton *button = _fulldataArray[i];
                if (button.tag <= 65 && button.selected) {
                    k++;
                }
                if (k==self.maxdataArray.count&& self.mandibleBtn.selected) {
                    self.maxillaryBtn.selected = YES;
                    self.fullBtn.selected = YES;
                }else if (k==self.maxdataArray.count&& !self.mandibleBtn.selected){
                    self.maxillaryBtn.selected = YES;
                }
            }
        }

        
    }else{
        if (sender.selected==false) {
            if (self.fullBtn.selected) {
                self.fullBtn.selected = false;
                self.mandibleBtn.selected = false;
            }else if (!self.fullBtn.selected && self.mandibleBtn.selected){
                self.mandibleBtn.selected = false;
            }
        }else{
            int m = 0;
            for (int i =0; i < self.fulldataArray.count; i++) {
                UIButton *button = _fulldataArray[i];
                if (button.tag >= 71 && button.selected){
                    m++;
                    NSLog(@"%d",m);
                }
                if (m==self.maxdataArray.count&& self.maxillaryBtn.selected) {
                    self.mandibleBtn.selected = YES;
                    self.fullBtn.selected = YES;
                }else if (m==self.maxdataArray.count&& !self.maxillaryBtn.selected){
                    self.mandibleBtn.selected = YES;
                }
            }
            
        }


    }
    if (_delegate && [_delegate respondsToSelector:@selector(teeth:type:)]) {
        [_delegate teeth:self.fulldataArray type:self.type];
    }
    
    
}
-(void)selectedAction:(UIButton *)sender{
    self.lastButn.layer.borderWidth = 1;
    sender.selected = !sender.selected;
    //sender.layer.borderWidth = sender.selected? 0: 1;
    NSLog(@"%d",sender.selected);
    
    switch (sender.tag) {
        case 1010:
            for (UIButton *button in self.maxdataArray) {
                button.selected = sender.selected?YES:false;
            }
            for (UIButton *button in self.mandataArray) {
                button.selected = self.mandibleBtn.selected?YES:false;
            }
            self.maxillaryBtn.selected = sender.selected;
            if (self.maxillaryBtn.selected && self.self.mandibleBtn.selected) {
                self.fullBtn.selected = true;
            }else{
                self.fullBtn.selected = false;
            }
            break;
        case 1011:
            self.maxillaryBtn.selected = self.mandibleBtn.selected = sender.selected;
            for (UIButton *button in self.fulldataArray) {
                button.selected = sender.selected?YES:false;
            }
            self.fullBtn.selected = sender.selected;
            self.mandibleBtn.selected = self.maxillaryBtn.selected = self.fullBtn.selected;
            break;
        case 1012:
            for (UIButton *button in self.maxdataArray) {
                button.selected = self.maxillaryBtn.selected ?YES : false;
            }
            for (UIButton *button in self.mandataArray) {
                button.selected = sender.selected?YES:false;
            }
            self.mandibleBtn.selected = sender.selected;
            if (self.maxillaryBtn.selected && self.self.mandibleBtn.selected) {
                self.fullBtn.selected = true;
            }else{
                self.fullBtn.selected = false;
            }
            
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(teeth:type:)]) {
        [_delegate teeth:self.fulldataArray type:self.type];
    }
    self.lastButn = sender;
}
#pragma mark ===========================
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, CGRectGetMaxX(rect), CGRectGetMaxY(rect), 5);
    UIBezierPath *berzPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
    
    CGContextAddPath(context, berzPath.CGPath);
    CGContextFillPath(context);
    //    CGContextFillRect(context, rect);
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
