//
//  AppDelegate.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerManager.h"
#import <QMapKit/QMapKit.h>
#import <QMapKit/QMSSearchKit.h>

@interface AppDelegate ()
@property (assign, nonatomic) BOOL isFirstLanuch;//检查是否是第一次登录
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [RequestHelp addReachabilityNetworkBackHandle:^{
        
    }];
     [QMapServices sharedServices].APIKey = @"FLYBZ-C5O3W-IGARX-RNIYE-FFFTE-L2B33";
    [[QMSSearchServices sharedServices] setApiKey:@"FLYBZ-C5O3W-IGARX-RNIYE-FFFTE-L2B33"];
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"1113200511107367#jz"];
    // apnsCertName是证书名称，可以先传nil，等后期配置apns推送时在传入证书名称
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    [self showViewController];
    return YES;
}
/*
 判断用户是否登录
 */
-(BOOL)isUserLogin
{
    UserModel * model =[[UserManager shareInstance]getUser];
    
    if (model.id != nil && [model.id intValue] > 0)
    {
        //已经登录
        return YES;
    }
    return NO;
}
/**
 展示视图方法
 */
- (void)showViewController
{
    if (self.isFirstLanuch)
    {
        [ViewControllerManager showLoginViewController];//显示引导图
    }
    else
    {
        if (![self isUserLogin])
        {
            [ViewControllerManager showLoginViewController];//显示登录界面
//              [ViewControllerManager showMainViewController];//显示主界面
        }
        else
        {
            
            [ViewControllerManager showMainViewController];//显示home界面
        }
    }
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


@end
