//
//  YAYIActionSheet.m
//  yayi
//
//  Created by Veer on 16/4/12.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import "YAYIActionSheet.h"

#define LZActionSheetCancelTag 9999
#define LZActionSheetCancelBaseTag 1000
#define LZActionSheetBaseHeight 52
#define LZACtionSheentFontSize  16
#define LZActionSheetBaseAnimationDuration 0.25
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface YAYIActionSheet ()
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *actionSheet;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *dividerArray;
@property (nonatomic, strong) YAYIActionSheet *YAYIActionSheet;
@end


@implementation YAYIActionSheet

- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

- (NSMutableArray *)dividerArray{
    if (!_dividerArray) {
        _dividerArray = [[NSMutableArray alloc] init];
    }
    return _dividerArray;
}

- (instancetype)initWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles lastBtnTitle:(NSString *)lastBtnTitle
{
    if (self = [super init]) {
        
        self.btnArray = nil;
        self.dividerArray = nil;
        
        
        self.backgroundColor = [UIColor clearColor];
        self.YAYIActionSheet = [YAYIActionSheet new];
        self.YAYIActionSheet.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
        self.delegate = delegate;
        [self addSubview:self.YAYIActionSheet];
        
        // 遮盖
        UIView *coverView = [UIButton buttonWithType:UIButtonTypeCustom];
        coverView.backgroundColor = [UIColor clearColor];
        [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewDidClick)]];
        self.coverView = coverView;
        [self.YAYIActionSheet addSubview:coverView];
        
        
        // 底部弹窗
        UIView *actionSheet = [UIView new];
        actionSheet.backgroundColor = [UIColor clearColor];
        self.actionSheet = actionSheet;
        [self.coverView addSubview:actionSheet];
        
        if (lastBtnTitle) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:otherButtonTitles];
            [array addObject:lastBtnTitle];
            otherButtonTitles = [array copy];
        }
        
        // 操作action
        for (int i = 0; i < otherButtonTitles.count; i++) {
            [self createBtnWithTitle:otherButtonTitles[i] backgroundColor:[UIColor colorWithWhite:1 alpha:1] titleColor:[UIColor blackColor] tagIndex:i + LZActionSheetCancelBaseTag];
        }
        UIButton *lastBtn = [self.btnArray lastObject];
        [lastBtn setTitleColor:[UIColor colorWithHexString:@"#ff5454"] forState:UIControlStateNormal];
        
        // 取消action
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.tag = LZActionSheetCancelTag;
        cancelBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(LZACtionSheentFontSize)];
        [cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(actionSheetClickedButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn = cancelBtn;
        [self.actionSheet addSubview:cancelBtn];
        
        if (lastBtnTitle) {
            //[cancelBtn setTitleColor:[UIColor colorWithRed:101/255.0 green:173/255.0 blue:244/255.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (instancetype)initWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles{
    if (self = [super init]) {
        
        self.btnArray = nil;
        self.dividerArray = nil;
        
        
        self.backgroundColor = [UIColor clearColor];
        self.YAYIActionSheet = [YAYIActionSheet new];
        self.YAYIActionSheet.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
        self.delegate = delegate;
        [self addSubview:self.YAYIActionSheet];
        
        // 遮盖
        UIView *coverView = [UIButton buttonWithType:UIButtonTypeCustom];
        coverView.backgroundColor = [UIColor clearColor];
        [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewDidClick)]];
        self.coverView = coverView;
        [self.YAYIActionSheet addSubview:coverView];
        
        
        // 底部弹窗
        UIView *actionSheet = [UIView new];
        actionSheet.backgroundColor = [UIColor clearColor];
        self.actionSheet = actionSheet;
        [self.coverView addSubview:actionSheet];
        

        // 操作action
        for (int i = 0; i < otherButtonTitles.count; i++) {
            [self createBtnWithTitle:otherButtonTitles[i] backgroundColor:[UIColor whiteColor] titleColor:[UIColor colorWithHexString:@"#424242"] tagIndex:i + LZActionSheetCancelBaseTag];
        }
        
        
        
        // 取消action
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.tag = LZActionSheetCancelTag;
        cancelBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(LZACtionSheentFontSize)];
        [cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(actionSheetClickedButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn = cancelBtn;
        [self.actionSheet addSubview:cancelBtn];
    }
    return self;
    
}

+ (instancetype)showActionSheetWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles{
    return [[self alloc] initWithDelegate:delegate cancelButtonTitle:cancleTitle otherButtonTitles:otherButtonTitles];
}

- (void)createBtnWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroudColor titleColor:(UIColor *)textColor tagIndex:(NSInteger)tagIndex{
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    actionBtn.tag = tagIndex;
    actionBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(LZACtionSheentFontSize)];
    actionBtn.backgroundColor = backgroudColor;
    actionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [actionBtn setTitle:title forState:UIControlStateNormal];
    [actionBtn setTitleColor:textColor forState:UIControlStateNormal];
    [actionBtn addTarget:self action:@selector(actionSheetClickedButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionSheet addSubview:actionBtn];
    [self.btnArray addObject:actionBtn];
    
    
    UIView *divider = [UIView new];
    divider.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [actionBtn addSubview:divider];
    [self.dividerArray addObject:divider];
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
}


#pragma mark - 事件处理
// 点击遮盖
- (void)coverViewDidClick{
    [self dismiss];
}

// 点击action按钮
- (void)actionSheetClickedButtonAtIndex:(UIButton *)actionBtn{
    if (actionBtn.tag != LZActionSheetCancelTag) {
        if ([self.delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
            [self.delegate actionSheet:self didClickedButtonAtIndex:actionBtn.tag - LZActionSheetCancelBaseTag];
            
            
        }
        [self dismiss];
    }else{ // 取消按钮
        [self dismiss];
    }
}



- (void)show{
    if (self.superview != nil) return;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    
    
    self.YAYIActionSheet.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.coverView.frame = self.YAYIActionSheet.bounds;
    
    CGFloat actionHeight = (self.btnArray.count + 1) * LZActionSheetBaseHeight + 5;
    self.actionSheet.frame = CGRectMake(0, self.bounds.size.height, SCREEN_WIDTH, actionHeight);
    
    
    self.cancelBtn.frame = CGRectMake(0, actionHeight - LZActionSheetBaseHeight,self.bounds.size.width, LZActionSheetBaseHeight);
    
    
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = LZActionSheetBaseHeight;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        UIView *divider = self.dividerArray[i];
        btnY = LZActionSheetBaseHeight * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        divider.frame = CGRectMake(btnX, btnH - 1, btnW, 1);
    }
    
    
    
    
    [UIView animateWithDuration:LZActionSheetBaseAnimationDuration animations:^{
        CGRect rect = self.actionSheet.frame;
        rect.origin.y = self.frame.size.height - self.actionSheet.frame.size.height;
        self.actionSheet.frame = rect;
    }];
    
}

- (void)dismiss{
    [UIView animateWithDuration:LZActionSheetBaseAnimationDuration animations:^{
        CGRect rect = self.actionSheet.frame;
        rect.origin.y = self.frame.size.height;
        self.actionSheet.frame = rect;
    } completion:^(BOOL finished) {
        if (self.superview != nil) {
            [self removeFromSuperview];
        }
    }];
}

@end



@implementation UIColor (LZActionSheet)
+ (instancetype)randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}
+ (instancetype)lightBlueColor {
    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}
+ (instancetype) colorWithHex:(NSUInteger)hexColor {
    return [UIColor colorWithHex:hexColor alpha:1.];
}
+ (instancetype)colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
