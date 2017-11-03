//
//  YAGuideView.m
//  YAYIMemo
//
//  Created by hxp on 2017/10/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAGuideView.h"

@implementation YAGuideView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonAry = [NSMutableArray array];
        [self createScrollView];
        [self createPageViews];
        [self createPageControl];
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    
    }
    return self;
}
-(void)createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
}

-(void)createPageViews{
    CGFloat navH = YANavBarHeight;
    CGFloat tabH = YATabBarHeight;
    NSArray *imageAry = @[@"guideone",@"guidetwo",@"guidethree",@"guidefour"];
    for (int i = 0; i< imageAry.count; i++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(SCREEN_W*i, 0, SCREEN_W, SCREEN_H);
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageAry[i]];
        imageView.userInteractionEnabled = YES;
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(@(102*YAYIScreenScale + navH));
        }];
        if (i == 3) {
            UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
            [login setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
            [login addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:login];
            [login mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.bottom.mas_equalTo(@(-(tabH + 13*YAYIScreenScale + 32*YAYIScreenScale)));
            }];
        }
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_W*4, SCREEN_H);
    self.scrollView.contentOffset = CGPointMake(0, 0);
}
-(void)createPageControl{
    CGFloat tabH = YATabBarHeight;
    UIView *view = [UIView new];
    UIImage *normalImgage = [UIImage imageNamed:@"empty"];
    UIImage *lightImage = [UIImage imageNamed:@"fill"];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.equalTo(@(-(tabH + 9*YAYIScreenScale)));
        make.size.mas_equalTo(CGSizeMake(normalImgage.size.width*4+8*3*YAYIScreenScale, normalImgage.size.height));
    }];
    for (int i =0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            button.selected = YES;
        }
        button.tag = 1000+i;
        button.frame = CGRectMake((normalImgage.size.width + 8*YAYIScreenScale)*i, 0, normalImgage.size.width, normalImgage.size.height);
        [button setImage:normalImgage forState:UIControlStateNormal];
        [button setImage:lightImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [_buttonAry addObject:button];
    }
                               
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.lastBtn.selected = false;
    NSInteger index = (self.scrollView.contentOffset.x + SCREEN_W/2.0)/SCREEN_W;
    UIButton *button = self.buttonAry[index];
    button.selected = YES;
    self.lastBtn = button;
}
-(void)buttonAction:(UIButton *)sender{
     self.lastBtn.selected = false;
    NSInteger i = sender.tag - 1000;
    sender.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(i*SCREEN_W, 0) animated:YES];
     self.lastBtn = sender;
}
-(void)startAction:(UIButton *)sender{
    self.alpha = 0;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //UIWindow *window = (UIWindow *)self.superview;
    ;
    
}
@end
