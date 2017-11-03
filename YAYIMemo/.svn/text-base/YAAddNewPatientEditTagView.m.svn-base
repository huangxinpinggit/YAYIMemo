//
//  YAAddNewPatientEditTagView.m
//  YAYIMemo
//
//  Created by hxp on 17/8/29.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddNewPatientEditTagView.h"

@implementation YAAddNewPatientEditTagView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataAry = [NSMutableArray array];
        self.dataLabAry = [NSMutableArray array];
        self.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
        self.fontSize = YAYIFontWithScale(13);
        self.fontColor = [UIColor colorWithHexString:@"#424242"];
        self.leftMargin = 0*YAYIScreenScale;
        self.borderColor = [UIColor colorWithHexString:@"#e7e7e7"];
        self.topMargin = 10*YAYIScreenScale;
        self.topMarg = 9 *YAYIScreenScale;
        self.leftMarg = 9 *YAYIScreenScale;
        self.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
        self.cordius = 13*YAYIScreenScale;
        [self addSubview:self.editText];
        
    }
    return self;
}

-(void)setModel:(YAPatientInfoPatientTagModel  *)model
{
    _model = model;
    if (model.selected == false){
        if (model.isInput) {
            [self.dataAry removeObject:model];
        }else{
            for (YAPatientInfoPatientTagModel  *mdel in self.dataAry) {
                if (model.tagid == mdel.tagid) {
                    [self.dataAry removeObject:mdel];
                    break;
                }
            }
        }
    }else{
        [self.dataAry addObject:model];
    }
    
    [self.dataLabAry removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self createView];
    [self addSubview:self.editText];
    
    if (_delegate && [_delegate respondsToSelector:@selector(datasources:)]) {
        [_delegate datasources:self.dataAry];
    }
}
-(void)setDataAry:(NSMutableArray *)dataAry
{
    _dataAry = dataAry;
    [self createView];
}
-(void)createView{
    NSLog(@"%@",self.dataAry);
    for (int i = 0; i < _dataAry.count; i++){
        UILabel *label = [UILabel new];
        label.font = self.font;
        label.textColor = self.fontColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label.layer.borderColor = self.borderColor.CGColor;
        label.layer.borderWidth = 1.f;
        label.layer.cornerRadius = self.cordius;
        label.userInteractionEnabled = YES;
        label.tag = 100+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
        [label addGestureRecognizer:tap];
        [self  addSubview:label];
        [self.dataLabAry addObject:label];
    }
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //  1、根据容器的 width  计算 一横能容纳多少个标签
    
    
    CGFloat rowWidth = 0;  // 一行的宽度
    CGFloat rowCout  = 0;  // 行数
    CGFloat colCout = 0;   // 列数
    CGFloat rw = 0;        //记录每次横向移动位置
    CGFloat col = 0;       //  记录每次纵向移动的位置
    CGFloat itemYY = 0;        // 记录item 的Y坐标
    for (int i  = 0; i < self.dataAry.count + 1; i++) {
        if (_dataAry.count >0) {
            if (i < self.dataAry.count) {
                YAPatientInfoPatientTagModel  *model = self.dataAry[i];
                NSString *tagName = model.tagName;
                UILabel *label = _dataLabAry[i];
                label.text = tagName;
                CGFloat itemW = [self getTagSize:tagName].width + 20;
                CGFloat itemH = [self getTagSize:tagName].height + 10;
                NSLog(@"%lf",itemH);
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
                itemYY = itemY;
                col = itemY + itemH;
                if (col > self.height) {
                    self.height += (itemH + self.topMarg);
                    if (self.updateLayout) {
                        self.updateLayout(self.height+self.topMargin);
                    }
                    
                }
            }else{
                CGFloat textW = 80;
                if ([self getTagSize:self.editText.text].width >60) {
                    textW = [self getTagSize:self.editText.text].width+6;
                }
                
                CGFloat textH = 24;
                CGFloat textX = rw + self.leftMargin;
                CGFloat textY = itemYY;
                if ((rw + textW) > self.size.width ) {
                    rowCout++;
                    colCout = 0;
                    rw = 0;
                    textX = self.leftMargin;
                    textY = col + self.topMarg;
                    self.editText.frame = CGRectMake(textX, textY, textW, textH);
                }else{
                    colCout++;
                    self.editText.frame = CGRectMake(textX, textY, textW, textH);
                }
                NSLog(@"%lf",col);
                col = textY + textH;
                NSLog(@"%lf ===== %lf",col, self.height);
                if (col > self.height) {
                    self.height += (textH + self.topMarg);
                    if (self.updateLayout) {
                        self.updateLayout(self.height+self.topMargin);
                    }
                }else if (self.height - col > textH){
                    self.height-=(textH+self.topMarg);
                    if (self.updateLayout) {
                        self.updateLayout(self.height+self.topMargin);
                    }
                }
                
            }
            
        }else{
            if ([self getTagSize:self.editText.text].width >60) {
                CGFloat w = [self getTagSize:self.editText.text].width+10;
                self.editText.frame = CGRectMake(self.leftMargin, (CGRectGetHeight(self.frame) - 26)/2.0, w, 25.513672);
            }else{
                self.editText.frame = CGRectMake(self.leftMargin, (CGRectGetHeight(self.frame) - 26)/2.0, 60+20, 25.513672);
            }
            
        }
    }
    
}

-(UITextField *)editText
{
    if (_editText == nil) {
        self.editText = [[UITextField alloc] init];
        //self.editText.placeholder = @"添加标签";
        self.editText.font = self.font;
        self.editText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"添加标签" attributes:@{NSForegroundColorAttributeName: YA_COLOR(171,171,171),NSFontAttributeName:[UIFont systemFontOfSize:YAYIFontWithScale(13)]}];
        self.editText.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
        self.editText.returnKeyType = UIReturnKeyDone;
        self.editText.layer.borderWidth = 1;
        self.editText.layer.masksToBounds = YES;
        self.editText.layer.cornerRadius = 13;
        self.editText.delegate = self;
        self.editText.textAlignment = NSTextAlignmentCenter;
    }
    return _editText;
    
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
    UILabel *lab = (UILabel *)tap.view;
    YAPatientInfoPatientTagModel  *model = self.dataAry[lab.tag - 100];
    
    if (model.deleted) {
        NSLog(@"%@",model.tagName);
        [self.dataLabAry removeAllObjects];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.dataAry removeObject:model];
        [self createView];
        [self addSubview:self.editText];
        
        if (_updatedata && model.isInput == false) {
            self.updatedata(model);
        }
        if (_delegate && [_delegate respondsToSelector:@selector(datasources:)]) {
            [_delegate datasources:self.dataAry];
        }
    }else{
        lab.backgroundColor = [UIColor colorWithHexString:@"#252525"];
        lab.text= [NSString stringWithFormat:@"%@×",lab.text];
        lab.textColor = [UIColor whiteColor];
        model.deleted = YES;
    }
    
    
    
}

#pragma mark =============================
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(beginEdtitingText:)]) {
        [_delegate beginEdtitingText:YES];
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    CGRect rect = self.editText.frame;
    if (textField.text.length >17) {
        return false;
    }else if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] ||
              ![[textField textInputMode] primaryLanguage] ||
              range.location > 17) {
        return NO;
    }
    rect.size.width = [self getTagSize:textField.text].width;
    
    [self.editText setFrame:rect];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(endEdittingText:)]) {
        [_delegate endEdittingText:YES];
    }
    [textField resignFirstResponder];
    self.editText.text = @"";
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    YAPatientInfoPatientTagModel  *model = [YAPatientInfoPatientTagModel  new];
    model.isInput = YES;
    if (textField.text.length >17) {
        
        model.tagName = [textField.text substringToIndex:17];
        [self.dataAry addObject:model];
    }else if(textField.text.length >0){
        model.tagName = textField.text;
        [self.dataAry addObject:model];
    }else{
        return;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.dataLabAry removeAllObjects];
    [self createView];
    self.editText.text = @"";
    [self addSubview:self.editText];
    
    if (_delegate && [_delegate respondsToSelector:@selector(datasources:)]) {
        [_delegate datasources:self.dataAry];
    }
   
}


@end
