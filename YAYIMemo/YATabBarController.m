//
//  YATabBarController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YATabBarController.h"
#import "YAMedicalViewController.h"  // 主页
#import "YAPatientsViewController.h" //   患者
#import "YAScheduleViewController.h" // 日程
#import "YALoginViewController.h"
#import "YANavigationController.h"
#import "YATabBar.h"
#import "YABaseViewController.h"
@interface YATabBarController ()<UITabBarControllerDelegate>

@end

@implementation YATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    YATabBar *tabBar = [[YATabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    [self addViewControllers];
   
}

-(void)addViewControllers{
    
    UIViewController *medicalView = [self setupChildVc:[[YAMedicalViewController alloc] init] title:@"资料" image:@"n_data" selectedImage:@"data" index:0];
    
   
    UIViewController *patientView = [self setupChildVc:[[YAPatientsViewController alloc] init] title:@"患者" image:@"n_addressbook" selectedImage:@"addressbook" index:1];
    UIViewController *schedulView = [self setupChildVc:[[YAScheduleViewController alloc] init] title:@"日程" image:@"n_schedule" selectedImage:@"schedule" index:2];
    self.viewControllers = @[medicalView,patientView,schedulView];
    [self setTabBarAttrs];
    
   
}
 -(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (YALoginCookieValue == nil) {
        [self loginAction];
    }
}
/**
 * 初始化子控制器
 */
- (UIViewController *)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage index:(NSInteger)index
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;

    vc.tabBarController.selectedIndex = index;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage  imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YAColor(@"#424242")} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YAColor(@"#8a8a8a")} forState:UIControlStateNormal];
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器;
    YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:vc];
    nav.title = title;
    return nav;
}
-(void)setTabBarAttrs{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性

    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[YATabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[YATabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[YATabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}
#pragma mark ===========用户登录==================

-(void)loginAction{
    YABaseViewController *baseView = [YABaseViewController new];
   
    YALoginViewController *login = [YALoginViewController new];
    login.loginSuccessOperation = ^{
        [baseView freshedData];
    };
    [self  presentViewController:login  animated:false completion:nil];
    
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (viewController.tabBarController.selectedIndex==1) {
        static NSString *tabBarDidSelectedNotification = @"tabBarDidSelectedNotification";
        [[NSNotificationCenter defaultCenter] postNotificationName:tabBarDidSelectedNotification object:nil userInfo:nil];
    }
}
//禁止tab多次点击
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *tbselect=tabBarController.selectedViewController;
    if([tbselect isEqual:viewController]){
        return NO;
    }
    return YES;
}
@end
