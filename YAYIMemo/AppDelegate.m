//
//  AppDelegate.m
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "AppDelegate.h"
#import "YATabBarController.h"
#import "YAYITabBarController.h"

#import "YAPersonalViewController.h"
#import "Reachability.h"
#import "YAGuideView.h"
@interface AppDelegate ()

-(void)reachabilityChanged:(NSNotification*)note;

@property(strong) Reachability * googleReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    //3、使用MMDrawerController
    YAPersonalViewController *leftVC = [[YAPersonalViewController alloc] init];
    //YAYITabBarController  *tabbar = [[YAYITabBarController alloc] init];
    YATabBarController *tabBar = [[YATabBarController alloc] init];
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabBar leftDrawerViewController:leftVC];
    self.drawerController.view.backgroundColor = [UIColor whiteColor];
    
    //4、设置打开/关闭抽屉的手势
    //self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 264.0*YAYIScreenScale;
    self.drawerController.maximumRightDrawerWidth = 264.0*YAYIScreenScale;
    
    
//   self.mainNavigationController = [[YANavigationController alloc]initWithRootViewController:tabBar];
//   self.mainNavigationController.navigationBar.hidden = YES;
//   //self.mainNavigationController.view.backgroundColor = [UIColor whiteColor];
//   self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1];
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
    //设置引导页
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"FirstLaunchApp"] == nil) {
        YAGuideView *guideView = [[YAGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults] setValue:@"FirstLaunchApp" forKey:@"FirstLaunchApp"];
    }
    //59e6bf0f8f4a9d1c49000500
    
    //友盟统计
    UMConfigInstance.appKey = @"59e6bf0f8f4a9d1c49000500";
    [MobClick startWithConfigure:UMConfigInstance];
    //监听网络
    [self reachalibily];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
   /*
    self.googleReach = [Reachability reachabilityWithHostname:API];
    [self.googleReach startNotifier];
    self.localWiFiReach = [Reachability reachabilityForLocalWiFi];
    self.localWiFiReach.reachableOnWWAN = NO;
    [self.localWiFiReach startNotifier];
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    [self.internetConnectionReach startNotifier];
    */
    
    [IQKeyboardManager sharedManager].toolbarTintColor =YAColor(@"#424242");
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if(reach == self.googleReach)
    {
        if([reach isReachable])
        {
            
        }
        else
        {
            
        }
    }
    else if (reach == self.localWiFiReach)
    {
        if([reach isReachable])
        {
            
        }
        else
        {
            
        }
    }
    else if (reach == self.internetConnectionReach)
    {
        if([reach isReachable])
        {
           
        }
        else
        {
            
        }
    }
    
}
-(void)reachalibily{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"有网");
        }else
        {
            NSLog(@"没有网");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"netNotReachable" object:nil];
        }
    }];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    // 将URL转成字符串
    NSString *urlString = url.absoluteString;
    NSLog(@"%@",urlString);
    return YES;
}
@end
