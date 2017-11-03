//
//  YASelectedTagView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASelectedTagView.h"

@implementation YASelectedTagView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self){
    
        self.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
        self.fontSize = YAYIFontWithScale(13);
        self.fontColor = [UIColor colorWithHexString:@"#424242"];
        self.leftMargin = 15*YAYIScreenScale;
        self.borderColor = [UIColor colorWithHexString:@"#e7e7e7"];
        self.topMargin = 44*YAYIScreenScale;
        self.topMarg = 10 *YAYIScreenScale;
        self.leftMarg = 10 *YAYIScreenScale;
        self.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
        self.cordius = 13*YAYIScreenScale;
        
    }
    return self;

}

-(void)createTopView{
    if (_topView == nil) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, SCREEN_W, 44);
        [self addSubview:view];
        UILabel *label = [UILabel new];
        label.textColor = YAColor(@"#828282");
        label.font = YAFont(14);
        label.text = @"通过标签筛选";
        [view addSubview:label];
        label.frame = CGRectMake(15, 12, 100, 20);
        
        UILabel *hLine = [UILabel new];
        hLine.frame = CGRectMake(0, 0, SCREEN_W, 1);
        hLine.backgroundColor = YAColor(@"#e7e7e7");
        [self addSubview:hLine];
        self.topView = view;
    }
    

}
-(void)setDataAry:(NSMutableArray *)dataAry
{
    _dataAry = dataAry;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self createTopView];
    [self setupView];
}

-(void)setupView{
    //  1、根据容器的 width  计算 一横能容纳多少个标签
    
    
    CGFloat rowWidth = 0;  // 一行的宽度
    CGFloat rowCout  = 0;  // 行数
    CGFloat colCout = 0;   // 列数
    CGFloat rw = 0;        //记录每次横向移动位置
    CGFloat col = 0;       //  记录每次纵向移动的位置
    for (int i  = 0; i < self.dataAry.count; i++) {
        YAAddTagListModel *model = self.dataAry[i];
        NSString *tagName = model.tagName;
        UILabel *label = [UILabel new];
        label.font = self.font;
        if (model.selected) {
            label.textColor = [UIColor colorWithHexString:@"#b7b7b7"];
        }else{
            label.textColor = self.fontColor;
        }
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label.layer.borderColor = self.borderColor.CGColor;
        label.layer.borderWidth = 1.f;
        label.layer.cornerRadius = self.cordius;
        label.userInteractionEnabled = YES;
        label.text = tagName;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
        [label addGestureRecognizer:tap];
        [self  addSubview:label];
        
        
        CGFloat itemW = [self getTagSize:tagName].width + 20;
        CGFloat itemH = [self getTagSize:tagName].height + 10;
        CGFloat itemX = self.leftMargin + rw;
        CGFloat itemY = self.topMargin + (itemH + self.topMarg)*rowCout;
        rowWidth =  itemW + itemX;
        if (rowWidth > self.size.width) {
            rowWidth = 0;
            rowCout++;
            colCout = 0;
            rw = 0;
            itemX = self.leftMargin;
            itemY = self.topMargin + (itemH + self.topMarg)*rowCout;
            label.frame = CGRectMake(itemX, itemY, itemW, itemH);
        }else{
            label.frame = CGRectMake(itemX, itemY, itemW, itemH);
            colCout++;
        }
        rw = rw + itemW + self.leftMarg *1;
        
        // 根据实际内容  ，更新容器的高度
        col = itemY + itemH;
        if (col > self.height) {
            self.height += (itemH + self.topMarg);
        }
        
        
    }
    // 根据实际内容  ，更新容器的高度
    //self.height = 180;
    
    
}
-(void)setFont:(UIFont *)font
{
    _font = font;
}

//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName{
    
    NSDictionary *attrs = @{NSFontAttributeName : self.font};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)selectedAction:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
    
    YAAddTagListModel *model = _dataAry[label.tag];
    if (model.selected) {
        model.selected = false;
        label.textColor = [UIColor colorWithHexString:@"#424242"];
        
    }else{
        model.selected = YES;
        label.textColor = [UIColor colorWithHexString:@"#b7b7b7"];
        
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectedTagName:)]) {
        [_delegate selectedTagName:model];
    }
}

@end
