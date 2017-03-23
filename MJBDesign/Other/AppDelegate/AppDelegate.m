//
//  AppDelegate.m
//  MJBangProject
//
//  Created by X团 on 15-1-23.
//  Copyright (c) 2015年 X团. All rights reserved.
//

#import "AppDelegate.h"
#import "MJBTabBarViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "RNCachingURLProtocol.h"
#import "PJExceptionHandler.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    InstallUncaughtExceptionHandler();
    [NSThread sleepForTimeInterval:1.6];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MJBTabBarViewController * denseTabBar = [[MJBTabBarViewController alloc] init];
    [denseTabBar.tabBar setTintColor:[UIColor whiteColor]];
    [denseTabBar.tabBar setSelectionIndicatorImage:[[UIImage alloc] init]];
    self.window.rootViewController = denseTabBar;
    
    [self.window makeKeyAndVisible];
    
//    AFNetworkReachabilityManager *network = [AFNetworkReachabilityManager sharedManager];
//    [network startMonitoring];
    
    [self setUMConfigInstance];
    [self setWeiXinShare];
    
    return YES;
}

/**
 *   友盟统计设置初始化
 */
- (void)setUMConfigInstance{
    UMConfigInstance.appKey = UMAppkey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}

/**
 *   友盟微信分享初始化
 */
- (void)setWeiXinShare{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppkey];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeiXinAppID appSecret:WeiXinAppSecret redirectURL:@"http://mobile.umeng.com/social"];

}

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"didReceiveLocalNotification");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
