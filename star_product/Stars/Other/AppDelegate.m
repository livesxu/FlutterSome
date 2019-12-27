//
//  AppDelegate.m
//  Stars
//
//  Created by Livespro on 16/10/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+Assist.h"

//#import <Bugly/Bugly.h>

//#import "AppDelegate+Notification.h"

@interface AppDelegate ()<LXRouteDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [LXRouter shareRouter].routeDelegate = self;
    //加载界面
    [self GuideAndLaunchAction];
    
    //不可多重点击
    [[UIButton appearance] setExclusiveTouch:YES];
    //运行中检测状态
    //Test_run
#if DEBUG

#else
    //bugly
//    [Bugly startWithAppId:@"e24d39006b"];
#endif
    
    //三方登录、分享 注册
//    [MobManager manager];
    
    return YES;
}

- (NSDictionary *_Nonnull)lxRouteCustomPropertyMapper;{
    
    return @{@"http":@"CommonWebViewController",
             @"https":@"CommonWebViewController",
             };
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;{
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;{
    
    [[LXRouter shareRouter] receiveScheme:url];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0);{
    
    [[LXRouter shareRouter] receiveScheme:url];
    
    return YES;
 }


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    NSLog(@"已经进入后台");
    //进入后台时，保存用户信息
    [[UserCenter center] saveStoreInfo];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
//     [[EMClient sharedClient] applicationWillEnterForeground:application];
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //关闭app时，保存用户信息
    [[UserCenter center] saveStoreInfo];
}

//#pragma mark - 通知相关 - 
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//    [self lx_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    
//    [self lx_application:application didFailToRegisterForRemoteNotificationsWithError:error];
//    
//}
//
//- (void)application:(UIApplication *)application
//        didReceiveRemoteNotification:(NSDictionary *)userInfo
//        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    
//    [self lx_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
//}

@end
