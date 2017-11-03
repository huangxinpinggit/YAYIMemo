//
//  YANavigationController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YANavigationController.h"
#import "UINavigationBar+YA.h"
#import "UIImage+VR.h"
@interface YANavigationController ()

@end

@implementation YANavigationController

+(void)initialize
{
    [self setupNavigationBarTheme];
}
+ (void)setupNavigationBarTheme {
    // 通过appearance对象能修改整个项目中所有UIBarbuttonItem的样式
    //    UINavigationBar *appearance = [UINavigationBar appearance];
    UINavigationBar *appearance = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    // 1.设置导航条的背景
    [appearance setBackgroundImage:[UIImage createImageWithColor:YA_ALPHA_COLOR(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    //appearance.backgroundColor = [UIColor whiteColor];
    // 设置文字
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = YAFont(17);
    att[NSForegroundColorAttributeName] = YAColor(@"#424242");
    [appearance setTitleTextAttributes:att];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏黑线
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navBarHairlineImageView.hidden = YES;
    [self dropShadowWithOffset:CGSizeMake(0, -0.5)
                        radius:1
                         color:YAColor(@"#8a8a8a")
                       opacity:0.4];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = false;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : YAColor(@"#424242"), NSFontAttributeName : YAFont(17)}];
    self.interactivePopGestureRecognizer.enabled = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    //主要是以下两个图片设置
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
   
   // self.navigationBar.tintColor = [UIColor whiteColor];
}

//  push 事件
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count >0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //button.backgroundColor = [UIColor orangeColor];
        button.frame = (CGRect){{0, 0}, CGSizeMake(70, 30)};
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
       // viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
     
    [super pushViewController:viewController animated:animated];
}

-(void)setitle:(NSString *)title
{
    UILabel *titleView = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleView.textColor = [UIColor  whiteColor];
    titleView.text = title;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont  systemFontOfSize:18 weight:0];
    self.navigationItem.titleView = titleView;
}
////设置状态栏样式
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//
//
//
//}

- (void)backBarButtonItemAction
{
    [self popViewControllerAnimated:YES];
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.navigationBar.bounds);
    self.navigationBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.navigationBar.layer.shadowColor = color.CGColor;
    self.navigationBar.layer.shadowOffset = offset;
    self.navigationBar.layer.shadowRadius = radius;
    self.navigationBar.layer.shadowOpacity = opacity;
    self.navigationBar.clipsToBounds = NO;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/*
- (void)setNavigationState:(BOOL)state{
    if (state) {
        self.edgesForExtendedLayout=UIRectEdgeBottom;
    }
    else{
        self.edgesForExtendedLayout=UIRectEdgeTop;
    }
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController setNavigationBarHidden:state animated:YES];
}
 */
@end
